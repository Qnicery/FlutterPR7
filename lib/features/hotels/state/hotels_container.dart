import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../models/booking.dart';
import '../screens/hotels_list_screen.dart';
import '../screens/history_screen.dart';
import '../screens/hotel_detail_screen.dart';

class HotelsContainer extends StatefulWidget {
  const HotelsContainer({super.key});

  @override
  State<HotelsContainer> createState() => _HotelsContainerState();
}

class _HotelsContainerState extends State<HotelsContainer> {
  int _currentIndex = 0;

  final List<Hotel> _hotels = [
    Hotel(
      id: '1',
      name: 'Отель Сочи',
      city: 'Сочи',
      imageUrl: 'https://cdn.worldota.net/t/640x400/extranet/17/bf/17bf990ad454e75cf172efcebc4abf9baa4a0afa.jpeg',
      price: 3200,
      description: 'Уютный отель у моря с видом на горы.',
    ),
    Hotel(
      id: '2',
      name: 'Москва Гранд',
      city: 'Москва',
      imageUrl: 'https://cdn.worldota.net/t/640x400/extranet/8f/2b/8f2b893e95e2ed215921ad7c75509d20976d86c5.jpeg',
      price: 4500,
      description: 'Отель в центре столицы рядом с достопримечательностями.',
    ),
    Hotel(
      id: '3',
      name: 'Казань Ривер',
      city: 'Казань',
      imageUrl: 'https://cdn.worldota.net/t/640x400/extranet/media/647c01d693594ffcaecf76a74cc99ff4.jpg',
      price: 2800,
      description: 'Современный отель с панорамным видом на реку.',
    ),
    Hotel(
      id: '4',
      name: 'Невский Палас',
      city: 'Санкт-Петербург',
      imageUrl: 'https://cdn.worldota.net/t/640x400/extranet/c0/dd/c0ddd6d6e0fa1c10811bf5108192ccb223eb11f1.jpeg',
      price: 3900,
      description: 'Отель в историческом центре с видом на Невский проспект.',
    ),
    Hotel(
      id: '5',
      name: 'Алтай Резорт',
      city: 'Горно-Алтайск',
      imageUrl: 'https://cdn.worldota.net/t/640x400/extranet/83/ab/83ab86554d3058caf51bb2087c4bed16828d93a2.jpeg',
      price: 2700,
      description: 'Экологичный отель в окружении гор и природы.',
    ),
  ];

  final List<Booking> _history = [];

  void _openHotelDetail(Hotel hotel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HotelDetailScreen(
          hotel: hotel,
          onConfirm: _addBookingToHistory,
        ),
      ),
    );
  }

  void _addBookingToHistory(Booking booking) {
    setState(() {
      _history.add(booking);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Забронировано: ${booking.hotelName} на ${booking.guests} гостей')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HotelsListScreen(hotels: _hotels, onBook: _openHotelDetail),
      HistoryScreen(history: _history),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'История'),
        ],
      ),
    );
  }
}
