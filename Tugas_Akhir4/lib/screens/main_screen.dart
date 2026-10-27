/*
  Muhamad Ridwan Pratama
  162024015
  Tugas Akhir 4
*/

import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../models/cart_item.dart';
import 'home_page.dart';
import 'cart_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<CartItem> _cartItems = [];

    final List<Drink> _drinkList = [
    Drink(id: '1', name: 'Espresso', price: 18000, imageUrl: 'espresso.png'),
    Drink(id: '2', name: 'Americano', price: 20000, imageUrl: 'americano.png'),
    Drink(id: '3', name: 'Matcha Latte', price: 25000, imageUrl: 'matcha.png'),
    Drink(id: '4', name: 'Chocolate Frappe', price: 28000, imageUrl: 'chocolate.png'),
  ];

  void _addToCart(Drink drink, int quantity) {
    setState(() {
      int index = _cartItems.indexWhere((item) => item.drink.id == drink.id);
      if (index != -1) {
        _cartItems[index].quantity += quantity;
      } else {
        _cartItems.add(CartItem(drink: drink, quantity: quantity));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${drink.name} telah ditambahkan ke keranjang'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeFromCart(String drinkId) {
    setState(() {
      _cartItems.removeWhere((item) => item.drink.id == drinkId);
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        drinkList: _drinkList,
        onAddToCart: _addToCart,
      ),
      CartPage(
        cartItems: _cartItems,
        onRemoveFromCart: _removeFromCart,
        onClearCart: _clearCart,
      ),
    ];

    int totalCartBadge = _cartItems.fold(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text('$totalCartBadge'),
              isLabelVisible: totalCartBadge > 0,
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}