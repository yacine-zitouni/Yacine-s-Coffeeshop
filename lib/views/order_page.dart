import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yacine_coffeeshop/model/order.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final param =
        ModalRoute.of(context)?.settings.arguments as Map<String, Order>;

    final Order order = param['order']!;
    final double drinkPrice = order.cost; // Prix calculé

    // Méthode pour générer et envoyer l'email
    Future<void> _sendOrderEmail() async {
      final String email = 'coffee-m2sime@univ-rouen.fr';
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'coffee-m2sime@univ-rouen.fr',
        queryParameters: {
          'subject': 'Order Summary',
          'body': '''
      Order Details:
      Drink: ${param['order']!.type.toString().split('.').last} ${param['order']!.size.toString().split('.').last}
      Sugar: ${param['order']!.hasSugar ? "Yes" : "No"}
      Whipped Cream: ${param['order']!.hasWhippedCream ? "Yes (+1.5€)" : "No"}
      Total: ${param['order']!.cost.toStringAsFixed(2)}€
      '''
        },
      );


      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        // Gérer l'erreur si l'application d'email ne peut pas être lancée
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open the email app'),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Details:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Drink: ${order.type?.toString().split('.').last ?? "None"}'),
            Text('Size: ${order.size.toString().split('.').last}'),
            Text('Sugar: ${order.hasSugar ? "Yes" : "No"}'),
            Text('Whipped Cream: ${order.hasWhippedCream ? "Yes" : "No"}'),
            Text('Total Cost: ${order.cost.toStringAsFixed(2)}€'),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                _sendOrderEmail();
              },
              child: Text(
                  'Order now for ${order.cost.toStringAsFixed(2)}€'),
            ),
          ],
        ),
      ),
    );
  }
}
