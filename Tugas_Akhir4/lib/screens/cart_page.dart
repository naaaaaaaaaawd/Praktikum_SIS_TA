/*
  Muhamad Ridwan Pratama
  162024015
  Tugas Akhir 4
*/

import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;
  final VoidCallback onClearCart;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onClearCart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _tableNumberController = TextEditingController();

  @override
  void dispose() {
    _customerNameController.dispose();
    _tableNumberController.dispose();
    super.dispose();
  }

  int get totalPrice {
    return widget.cartItems.fold(
      0,
      (sum, item) => sum + (item.drink.price * item.quantity),
    );
  }

  String? _validateCustomerName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama Pemesan tidak boleh kosong';
    }
    return null;
  }

  String? _validateTableNumber(String? value) {
    final tableNumber = value?.trim() ?? '';
    if (tableNumber.isEmpty) {
      return 'Nomor Meja tidak boleh kosong';
    }
    if (!RegExp(r'^\d+$').hasMatch(tableNumber)) {
      return 'Nomor Meja harus berupa angka';
    }

    final parsedTableNumber = int.tryParse(tableNumber);
    if (parsedTableNumber == null ||
        parsedTableNumber < 1 ||
        parsedTableNumber > 20) {
      return 'Nomor Meja harus antara 1 -20';
    }
    return null;
  }

  void _showCheckoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Checkout Berhasil', textAlign: TextAlign.center),
        content: Text(
          'Pesanan atas nama ${_customerNameController.text.trim()} untuk meja '
          '${_tableNumberController.text.trim()} berhasil checkout dengan total '
          'belanja Rp $totalPrice.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onClearCart();
            },
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
        title: const Text(
          'Keranjang Anda',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: const Color(0xFFFBF5F8),
        elevation: 0,
        centerTitle: true,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Keranjang Anda Kosong'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC3DFF8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                item.drink.imageUrl,
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.coffee, size: 30),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.drink.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Rp ${item.drink.price} x ${item.quantity}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20,
                              ),
                              onPressed: () =>
                                  widget.onRemoveFromCart(item.drink.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF5F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _customerNameController,
                              decoration: const InputDecoration(
                                labelText: 'Nama Pemesan',
                                border: OutlineInputBorder(),
                              ),
                              textCapitalization: TextCapitalization.words,
                              validator: _validateCustomerName,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _tableNumberController,
                              decoration: const InputDecoration(
                                labelText: 'Nomor Meja',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validator: _validateTableNumber,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Rp $totalPrice',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _showCheckoutDialog(context);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.5),
                            side: BorderSide(color: Colors.grey[300]!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF5E548E),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
