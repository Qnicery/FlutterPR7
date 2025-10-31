import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pr7/features/hotels/screens/hotels_screen.dart';

import 'features/hotels/models/booking.dart';
import 'features/hotels/models/hotel.dart';
import 'features/hotels/screens/history_screen.dart';
import 'features/hotels/screens/hotel_detail_screen.dart';
import 'features/hotels/screens/profile_screen.dart';
import 'features/hotels/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/hotels',
      routes: [
        GoRoute(
          name: 'hotels',
          path: '/hotels',
          builder: (context, state) {
            final history = state.extra as List<Booking>? ?? [];
            return HotelsScreen(history: history);
          },
          routes: [
            GoRoute(
              name: 'hotelDetail',
              path: 'detail',
              builder: (context, state) {
                final hotel = state.extra as Hotel;
                return HotelDetailScreen(hotel: hotel);
              },
            ),
          ],
        ),
        GoRoute(
          name: 'history',
          path: '/history',
          builder: (context, state) {
            final history = state.extra as List<Booking>? ?? [];
            return HistoryScreen(history: history);
          },
        ),
        GoRoute(
          name: 'profile',
          path: '/profile',
          builder: (context, state) {
            final history = state.extra as List<Booking>? ?? [];
            return ProfileScreen(history: history);
          },
          routes: [
            GoRoute(
              name: 'settings',
              path: 'settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: _router,
      title: 'Бронирование отелей',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

