import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/photos_screen.dart';
import '../screens/photo_details_screen.dart';
import '../screens/settings_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const PhotosScreen(),
      ),
      GoRoute(
        path: '/photo/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PhotoDetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) {
          final tab = state.uri.queryParameters['tab'] ?? 'general';
          return SettingsScreen(tab: tab);
        },
      ),
    ],
  );
}
