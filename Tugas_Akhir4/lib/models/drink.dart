/*
  Muhamad Ridwan Pratama
  162024015
  Tugas Akhir 4
*/

class Drink {
  final String id;
  final String name;
  final int price;
  final String imageUrl;

  Drink({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl = 'assets/cafe.png',
  });
}