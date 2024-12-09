import 'package:flutter/material.dart';
import 'package:yacine_coffeeshop/model/drink.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderPage extends StatelessWidget {
  OrderPage();

  @override
  Widget build(BuildContext context) {
    final drink =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Details:', style: TextStyle(fontSize: 18)),
            Text('Drink: ${drink['type'].toString().split('.').last}'),
            Text('Size: ${drink['size'].toString().split('.').last}'),
            Text('Sugar: ${drink['sugar'] ? "Yes" : "No"}'),
            Text('Whipped Cream: ${drink['whippedCream'] ? "Yes" : "No"}'),
            Text('Total Cost: ${drink['totalCost'].toStringAsFixed(2)}€'),
            SizedBox(height: 16),
            ElevatedButton(
             onPressed: null,
              child: Text(
                  'Order now for ${drink['totalCost'].toStringAsFixed(2)}€'),
            ),
          ],
        ),
      ),
    );
  }
}
