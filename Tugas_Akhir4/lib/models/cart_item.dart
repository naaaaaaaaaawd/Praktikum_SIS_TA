/*
  Muhamad Ridwan Pratama
  162024015
  Tugas Akhir 4
*/

import 'drink.dart';

class CartItem {
  final Drink drink;
  int quantity;

  CartItem({
    required this.drink,
    this.quantity = 1,
  });
}