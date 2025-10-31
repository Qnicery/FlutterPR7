import 'package:flutter/material.dart';
import 'package:pr7/features/hotels/screens/hotels_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Бронирование отелей',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HotelsScreen(history: []),
    );
  }
}

