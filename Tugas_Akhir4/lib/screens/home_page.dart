/*
  Muhamad Ridwan Pratama
  162024015
  Tugas Akhir 4
*/

import 'package:flutter/material.dart';
import '../models/drink.dart';
import 'drink_detail_page.dart';
import 'add_product.dart';

class HomePage extends StatefulWidget {
  final List<Drink> drinkList;
  final Function(Drink, int) onAddToCart;

  const HomePage({
    super.key,
    required this.drinkList,
    required this.onAddToCart,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final filteredList = widget.drinkList
        .where((drink) => drink.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Warung IS - Menu',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: const Color(0xFFFBF5F8),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductPage(),
            ),
          );
        },
        backgroundColor: const Color(0xFFE2DDF3),
        elevation: 2,
        child: const Icon(Icons.add, color: Color(0xFF5E548E)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 38,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 18),
                  labelText: 'Cari Minuman',
                  labelStyle: const TextStyle(fontSize: 12),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final drink = filteredList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC3DFF8),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            drink.imageUrl,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.coffee, size: 30, color: Colors.brown),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              drink.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Rp ${drink.price}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrinkDetailPage(
                                  drink: drink,
                                  onAddToCart: widget.onAddToCart,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Detail',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        SizedBox(
                          height: 28,
                          child: ElevatedButton(
                            onPressed: () => widget.onAddToCart(drink, 1),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blue,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text(
                              'Pesan',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}