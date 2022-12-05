import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {

  final String orderId;
  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore
              .instance
              .collection('orders')
              .doc(orderId)
              .snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Codigo do pedido: ${snapshot.data.id}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0,),
                  Text(
                    _buildProductsText(snapshot.data)
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
  String _buildProductsText(DocumentSnapshot snapshot){
    String text = 'Descrição:\n';
    for(LinkedHashMap p in snapshot['products']){
      text += '${p['quantity']} x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)})\n';
    }
    text += 'Total: R\$ ${snapshot['totalPrice'].toStringAsFixed(2)}';
    return text;
  }
}
