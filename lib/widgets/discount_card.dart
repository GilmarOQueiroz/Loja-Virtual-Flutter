import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text('Cupom de desconto',
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey[700]
          ),
        ),
        leading: const Icon(Icons.card_giftcard),
        trailing: const Icon(Icons.add),
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu Cupom'
              ),
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: (text){
                FirebaseFirestore.instance
                    .collection('coupons')
                    .doc(text)
                    .get()
                    .then((docSnap){
                  if(docSnap.data != null){
                    CartModel.of(context).setCoupon(text, docSnap.data()['percent']);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(
                            'Desconto de ${docSnap.data()['percent']}% aplicado!'),
                        backgroundColor: Theme.of(context).primaryColor,)
                    );
                  } else{
                      CartModel.of(context).setCoupon(null, 0);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text(
                              'Cupom não existente!'),
                            backgroundColor: Colors.redAccent,)
                      );
                    }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
