import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import '../tiles/cart_tile.dart';
import '../widgets/cart_price.dart';
import '../widgets/discount_card.dart';
import '../widgets/ship_card.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Carrinho'),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){
                int p = model.products.length;
                return Text('${p ?? 0} ${p == 1 ? 'Item' : 'Itens'}',
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model){
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()){
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart,
                    size: 80.0, color: Theme.of(context).primaryColor,),
                  const SizedBox(height: 16.0,),
                  const Text('Faça o login para adicionar produtos!',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0,),
                  RaisedButton(
                      child: Text('Entrar', style: TextStyle(fontSize: 18.0),),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>LoginScreen())
                        );
                      },
                  )
                ],
              ),
            );
          } else if (model.products == null || model.products.length == 0){
            return Center(
              child: Text('Nenhum produto no carrinho!',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map(
                      (product){
                        return CartTile(product);
                      }
                  ).toList(),
                ),
                DiscountCard(),
                ShipCard(),
                CartPrice(() async {
                  String orderId = await model.finishOrder();
                  if(orderId != null)
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context)=>OrderScreen(orderId))
                    );
                }),
              ],
            );
          }
        }
      ),
    );
  }
}
