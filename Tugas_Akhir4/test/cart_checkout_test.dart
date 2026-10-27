import 'package:challenge3/models/cart_item.dart';
import 'package:challenge3/models/drink.dart';
import 'package:challenge3/screens/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final cartItems = [
    CartItem(
      drink: Drink(
        id: '1',
        name: 'Espresso',
        price: 18000,
        imageUrl: 'assets/espresso.png',
      ),
    ),
  ];

  Widget buildCartPage({
    required List<CartItem> items,
    required VoidCallback onClearCart,
  }) {
    return MaterialApp(
      home: CartPage(
        cartItems: items,
        onRemoveFromCart: (_) {},
        onClearCart: onClearCart,
      ),
    );
  }

  Future<void> tapCheckout(WidgetTester tester) async {
    await tester.ensureVisible(find.text('Checkout'));
    await tester.tap(find.text('Checkout'));
    await tester.pumpAndSettle();
  }

  testWidgets('checkout fields appear only when the cart has items', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildCartPage(items: [], onClearCart: () {}));

    expect(find.text('Keranjang Anda Kosong'), findsOneWidget);
    expect(find.text('Nama Pemesan'), findsNothing);
    expect(find.text('Nomor Meja'), findsNothing);
    expect(find.text('Checkout'), findsNothing);

    await tester.pumpWidget(
      buildCartPage(items: cartItems, onClearCart: () {}),
    );

    expect(find.text('Nama Pemesan'), findsOneWidget);
    expect(find.text('Nomor Meja'), findsOneWidget);
    expect(find.text('Checkout'), findsOneWidget);
  });

  testWidgets('checkout validates required name and table number', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildCartPage(items: cartItems, onClearCart: () {}),
    );

    await tapCheckout(tester);
    expect(find.text('Nama Pemesan tidak boleh kosong'), findsOneWidget);
    expect(find.text('Nomor Meja tidak boleh kosong'), findsOneWidget);
    expect(find.text('Checkout Berhasil'), findsNothing);

    await tester.enterText(find.byType(TextFormField).at(0), 'Budi');
    await tester.enterText(find.byType(TextFormField).at(1), 'abc');
    await tapCheckout(tester);
    expect(find.text('Nomor Meja harus berupa angka'), findsOneWidget);
    expect(find.text('Checkout Berhasil'), findsNothing);

    await tester.enterText(find.byType(TextFormField).at(1), '0');
    await tapCheckout(tester);
    expect(find.text('Nomor Meja harus antara 1 -20'), findsOneWidget);
    expect(find.text('Checkout Berhasil'), findsNothing);

    await tester.enterText(find.byType(TextFormField).at(1), '21');
    await tapCheckout(tester);
    expect(find.text('Nomor Meja harus antara 1 -20'), findsOneWidget);
    expect(find.text('Checkout Berhasil'), findsNothing);
  });

  testWidgets('valid details show success and allow clearing the cart', (
    WidgetTester tester,
  ) async {
    var cartCleared = false;
    await tester.pumpWidget(
      buildCartPage(items: cartItems, onClearCart: () => cartCleared = true),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'Budi');
    await tester.enterText(find.byType(TextFormField).at(1), '20');
    await tapCheckout(tester);

    expect(find.text('Checkout Berhasil'), findsOneWidget);
    expect(
      find.text(
        'Pesanan atas nama Budi untuk meja 20 berhasil checkout dengan total '
        'belanja Rp 18000.',
      ),
      findsOneWidget,
    );
    expect(cartCleared, isFalse);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(cartCleared, isTrue);
  });
}
