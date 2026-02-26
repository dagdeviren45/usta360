import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;


@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  debugPrint('notificationTapBackground: ${notificationResponse.payload}');
}

/// Bildirim servisi provider
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

/// Bildirim servisi
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Function(String?)? onNotificationTapped;

  Future<void> initialize() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        onNotificationTapped?.call(response.payload);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    if (Platform.isAndroid) {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      await androidPlugin?.createNotificationChannel(
        const AndroidNotificationChannel(
          'usta360_reminders',
          'Hatırlatıcılar',
          importance: Importance.high,
          playSound: true,
          enableVibration: true,
        ),
      );
    }

    await requestPermissions();
  }

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final androidPlugin =
          _plugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final granted = await androidPlugin?.requestNotificationsPermission();
      return granted ?? false;
    } else if (Platform.isIOS) {
      final iosPlugin =
          _plugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();
      final granted = await iosPlugin?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }
    return false;
  }

  Future<void> scheduleReminder({
    required int notificationId,
    required String title,
    required String body,
    required DateTime scheduledAt,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'usta360_reminders',
      'Hatırlatıcılar',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
      color: Color(0xFF6366F1),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final tzScheduledAt = tz.TZDateTime.from(scheduledAt, tz.local);

    if (tzScheduledAt.isBefore(tz.TZDateTime.now(tz.local))) {
      return;
    }

    try {
      await _plugin.zonedSchedule(
        notificationId,
        title,
        body,
        tzScheduledAt,
        details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
      );
    } catch (e) {
      debugPrint('Bildirim planlama hatası: $e');
    }
  }

  Future<void> cancelNotification(int notificationId) async {
    await _plugin.cancel(notificationId);
  }

  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return _plugin.pendingNotificationRequests();
  }
}
