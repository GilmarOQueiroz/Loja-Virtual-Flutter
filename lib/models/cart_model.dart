import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../datas/cart_product.dart';

class CartModel extends Model {

  UserModel user;

  List<CartProduct> products = [];

  String couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItens();
  }

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

  void decProduct(CartProduct cartProduct){
    cartProduct.quantity--;

    FirebaseFirestore.instance.collection('users')
        .doc(user.firebaseUser.uid)
        .collection('cart').doc(cartProduct.cid)
        .update(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;

    FirebaseFirestore.instance.collection('users')
        .doc(user.firebaseUser.uid)
        .collection('cart').doc(cartProduct.cid)
        .update(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void _loadCartItens() async {

    QuerySnapshot querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.firebaseUser.uid)
        .collection('cart')
        .get();

    products = querySnapshot.docs.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();

  }

}