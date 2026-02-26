import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/shell/app_shell.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/jobs/jobs_list_screen.dart';
import '../../features/jobs/job_detail_screen.dart';
import '../../features/jobs/job_form_screen.dart';
import '../../features/customers/customers_list_screen.dart';
import '../../features/customers/customer_detail_screen.dart';
import '../../features/customers/customer_form_screen.dart';
import '../../features/calculator/calculator_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/reminders/reminder_form_screen.dart';
import '../../features/line_items/line_item_form_screen.dart';
import '../../features/photos/photo_manager_screen.dart';
import '../../features/ledger/ledger_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // Shell (bottom nav bar)
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/jobs',
            builder: (context, state) => const JobsListScreen(),
          ),
          GoRoute(
            path: '/customers',
            builder: (context, state) => const CustomersListScreen(),
          ),
          GoRoute(
            path: '/calculator',
            builder: (context, state) => const CalculatorScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      // Full screen routes
      GoRoute(
        path: '/job/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final customerIdStr = state.uri.queryParameters['customerId'];
          return JobFormScreen(
            customerId: customerIdStr != null ? int.tryParse(customerIdStr) : null,
          );
        },
      ),
      GoRoute(
        path: '/job/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return JobDetailScreen(jobId: id);
        },
      ),
      GoRoute(
        path: '/job/:id/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return JobFormScreen(jobId: id);
        },
      ),
      GoRoute(
        path: '/job/:jobId/line-item/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final jobId = int.parse(state.pathParameters['jobId']!);
          return LineItemFormScreen(jobId: jobId);
        },
      ),
      GoRoute(
        path: '/job/:jobId/line-item/:id/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final jobId = int.parse(state.pathParameters['jobId']!);
          final id = int.parse(state.pathParameters['id']!);
          return LineItemFormScreen(jobId: jobId, lineItemId: id);
        },
      ),
      GoRoute(
        path: '/job/:jobId/reminder/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final jobId = int.parse(state.pathParameters['jobId']!);
          return ReminderFormScreen(jobId: jobId);
        },
      ),
      GoRoute(
        path: '/job/:jobId/photos',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final jobId = int.parse(state.pathParameters['jobId']!);
          return PhotoManagerScreen(jobId: jobId);
        },
      ),
      GoRoute(
        path: '/customer/new',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CustomerFormScreen(),
      ),
      GoRoute(
        path: '/customer/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return CustomerDetailScreen(customerId: id);
        },
      ),
      GoRoute(
        path: '/customer/:id/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return CustomerFormScreen(customerId: id);
        },
      ),
      GoRoute(
        path: '/ledger',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LedgerScreen(),
      ),
    ],
  );
});
