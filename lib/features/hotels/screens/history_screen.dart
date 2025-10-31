import 'package:flutter/material.dart';
import '../models/booking.dart';

class HistoryScreen extends StatelessWidget {
  final List<Booking> history;

  const HistoryScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('История бронирования', style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: true),
      body: history.isEmpty
          ? const Center(child: Text('Вы пока ничего не бронировали'))
          : ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final booking = history[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.hotelName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Город: ${booking.city}', style: TextStyle(color: Colors.grey[600])),
                        Text('Гостей: ${booking.guests}', style: TextStyle(color: Colors.grey[600])),
                        Text('Дата: ${booking.date.day}.${booking.date.month}.${booking.date.year}', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  Text('${booking.price} ₽', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
