/*
  Muhamad Ridwan Pratama
  162024015
  Tugas Akhir 4
*/

import 'package:flutter/material.dart';
import '../models/drink.dart';

class DrinkDetailPage extends StatefulWidget {
  final Drink drink;
  final Function(Drink, int) onAddToCart;

  const DrinkDetailPage({
    super.key,
    required this.drink,
    required this.onAddToCart,
  });

  @override
  State<DrinkDetailPage> createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  int _quantity = 1;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Berhasil Ditambahkan', textAlign: TextAlign.center),
        content: Text(
          'Anda telah menambahkan ${widget.drink.name} ($_quantity) ke keranjang.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drink.name, style: const TextStyle(color: Colors.black, fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF2ECEF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.drink.imageUrl,
                      width: 65,
                      height: 65,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.coffee, size: 45, color: Colors.brown),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.drink.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Harga: Rp ${widget.drink.price}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Jumlah:',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _decrement,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.remove, color: Colors.white, size: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: _increment,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.add, color: Colors.white, size: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 34,
              child: ElevatedButton(
                onPressed: () {
                  widget.onAddToCart(widget.drink, _quantity);
                  _showSuccessDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2ECEF),
                  foregroundColor: const Color(0xFF5E548E),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                child: const Text(
                  'Tambah ke Keranjang',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}