import 'dart:collection';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rex/screens/cart_screen/cart_data.dart';
import 'package:rex/screens/cart_screen/cart_tile.dart';

import 'cart.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartData>(
      builder: (context, cartdata, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final cart = cartdata.carts[index];
            return const CartTile();
          },
          itemCount: cartdata.cartCount,
        );
      },
    );
  }
}

class CartData extends ChangeNotifier {
  final List<Cart> _carts = [];

  UnmodifiableListView<Cart> get carts {
    return UnmodifiableListView(_carts);
  }

  int get cartCount {
    return _carts.length;
  }

  void addCart(String newCart) {
    final cart = Cart(name: newCart);
    _carts.add(cart);
    notifyListeners();
  }

  void updateCart(Cart cart) {
    cart.toggler();
    notifyListeners();
  }

  void deleteCart(Cart cart) {
    _carts.remove(cart);
    notifyListeners();
  }
}
