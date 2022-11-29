import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {

  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text('Resumo do pedido',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Subtotal'),
                    Text('R\$ 0.00')
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Desconto'),
                    Text('R\$ 0.00')
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Entrega'),
                    Text('R\$ 0.00')
                  ],
                ),
                const Divider(),
                const SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Total',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text('R\$ 0.00',
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),
                    )
                  ],
                ),
                const SizedBox(height: 12.0,),
                RaisedButton(
                    child: Text('Finalizar pedido'),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: buy,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
