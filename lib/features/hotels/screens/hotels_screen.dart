import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../models/booking.dart';
import '../widgets/hotel_list.dart';
import 'hotel_detail_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';

class HotelsScreen extends StatefulWidget {
  final List<Booking> history;

  const HotelsScreen({super.key, required this.history});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
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

  void _openHotelDetail(Hotel hotel) async {
    final booking = await Navigator.push<Booking>(
      context,
      MaterialPageRoute(
        builder: (_) => HotelDetailScreen(hotel: hotel),
      ),
    );
    if (booking != null) {
      setState(() {
        widget.history.add(booking);
      });
    }
  }

  void _openHistory() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HistoryScreen(history: widget.history),
      ),
    );
  }

  void _openProfile() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(history: widget.history),
      ),
    );
  }
  String? _selectedCity;
  @override
  Widget build(BuildContext context) {
    final cities = _hotels.map((e) => e.city).toSet().toList();
    final filtered = _selectedCity == null
        ? _hotels
        : _hotels.where((h) => h.city == _selectedCity).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Отели', style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: true,),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _CityButton(
                  text: 'Все города',
                  selected: _selectedCity == null,
                  onTap: () => setState(() => _selectedCity = null),
                ),
                for (final city in cities)
                  _CityButton(
                    text: city,
                    selected: _selectedCity == city,
                    onTap: () => setState(() => _selectedCity = city),
                  ),
              ],
            ),
          ),
          Expanded(child: HotelList(hotels: filtered, onBook: _openHotelDetail)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) _openHistory();
          if (i == 2) _openProfile();
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
class _CityButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _CityButton({required this.text, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(text),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}
