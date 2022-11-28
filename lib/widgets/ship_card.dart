import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text('Calcular frete',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
          ),
        ),
        leading: const Icon(Icons.location_on),
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite seu CEP'
              ),
              initialValue: '',
              onFieldSubmitted: (text){

              },
            ),
          )
        ],
      ),
    );
  }
}
