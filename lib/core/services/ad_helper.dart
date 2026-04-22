import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4729157971041343/6940587794';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4729157971041343/2171981422';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get pdfRewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4729157971041343/7543223028';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4729157971041343/5272282908';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
