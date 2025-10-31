import 'package:flutter/material.dart';
import '../models/booking.dart';
import 'settings_screen.dart';
import 'hotels_screen.dart';
import 'history_screen.dart';

class ProfileScreen extends StatelessWidget {
  final List<Booking> history;
  const ProfileScreen({super.key, required this.history});

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  void _navigateToHotels(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HotelsScreen( history: history),
      ),
    );
  }

  void _navigateToHistory(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HistoryScreen(history: history),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль', style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 50),
            const SizedBox(height: 12),
            const Text('User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _openSettings(context),
              child: const Text('Настройки'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) _navigateToHotels(context);
          if (index == 1) _navigateToHistory(context);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'История'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}
