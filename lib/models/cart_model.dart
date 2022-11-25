import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../datas/cart_product.dart';

class CartModel extends Model {

  UserModel user;

  List<CartProduct> products = [];

  CartModel(this.user);

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct){
    products.add(cartProduct);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser.uid)
        .collection('cart')
        .add(cartProduct.toMap()).then((doc){
          cartProduct.cid = doc.id;
    });

        notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct){
    FirebaseFirestore.instance.collection('users')
        .doc(user.firebaseUser.uid)
        .collection('cart')
        .doc(cartProduct.cid).delete();

    products.remove(cartProduct);

    notifyListeners();
  }

}