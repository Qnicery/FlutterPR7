import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../widgets/hotel_list.dart';

class HotelsListScreen extends StatefulWidget {
  final List<Hotel> hotels;
  final void Function(Hotel) onBook;

  const HotelsListScreen({super.key, required this.hotels, required this.onBook});

  @override
  State<HotelsListScreen> createState() => _HotelsListScreenState();
}

class _HotelsListScreenState extends State<HotelsListScreen> {
  String? _selectedCity;

  @override
  Widget build(BuildContext context) {
    final cities = widget.hotels.map((e) => e.city).toSet().toList();
    final filtered = _selectedCity == null
        ? widget.hotels
        : widget.hotels.where((h) => h.city == _selectedCity).toList();

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
          Expanded(child: HotelList(hotels: filtered, onBook: widget.onBook)),
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
