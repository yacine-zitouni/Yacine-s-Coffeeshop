import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:yacine_coffeeshop/model/order.dart';
import 'package:yacine_coffeeshop/repository/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final drinks = GetIt.instance<Repository>().drinks;

  Order order = Order();
  final double _userBalance = 5.0; // Montant disponible sur la carte.

  bool get _isAffordable => order.cost <= _userBalance;

  double get _calculateCost {
    if (order.type == null) return 0.0;
    double baseCost = drinks[order.type]![order.size]!;
    if (order.hasWhippedCream) baseCost += 1.5;
    return baseCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Drink'),
        centerTitle: true,
        backgroundColor: Colors.brown[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select a Drink:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              // Options de boissons avec icônes
              _buildDrinkOptions(),

              const SizedBox(height: 16),
              const Text('Select the Size:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _buildSizeSlider(),

              const SizedBox(height: 16),
              const Text('Add Supplements:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _buildSupplements(),

              const SizedBox(height: 16),
              _buildOrderSummary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrinkOptions() {
    return Wrap(
      spacing: 8,
      children: DrinkType.values.map((drink) {
        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getDrinkIcon(drink),
              const SizedBox(width: 4),
              Text(drink.toString().split('.').last),
            ],
          ),
          selected: order.type == drink,
          onSelected: (bool selected) {
            setState(() {
              order.type = selected ? drink : null;
              order.cost = _calculateCost;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildSizeSlider() {
    return Slider(
      value: order.size.index.toDouble(),
      min: 0,
      max: DrinkSize.values.length - 1.0,
      divisions: 2,
      label: order.size.toString().split('.').last,
      activeColor: Colors.brown,
      inactiveColor: Colors.brown.shade200,
      onChanged: (value) {
        setState(() {
          order.size = DrinkSize.values[value.toInt()];
          order.cost = _calculateCost;
        });
      },
    );
  }

  Widget _buildSupplements() {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text('Sugar (Free)'),
          value: order.hasSugar,
          enabled: order.type != DrinkType.chocolate,
          onChanged: (bool? value) {
            setState(() {
              order.hasSugar = value ?? false;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          title: const Text('Whipped Cream (1.5€)'),
          value: order.hasWhippedCream,
          onChanged: (bool? value) {
            setState(() {
              order.hasWhippedCream = value ?? false;
              order.cost = _calculateCost;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Card(
      elevation: 4,
      color: Colors.brown.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            Text('Total Cost: ${order.cost.toStringAsFixed(2)}€', style: const TextStyle(fontSize: 16)),
            if (!_isAffordable)
              const Text('Insufficient balance!', style: TextStyle(color: Colors.red, fontSize: 16)),
            Text('Your Balance: ${_userBalance.toStringAsFixed(2)}€', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
                foregroundColor: Colors.white,
              ),
              onPressed: order.type != null && _isAffordable
                  ? () {
                      Navigator.pushNamed(context, '/order', arguments: {'order': order});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Order placed for ${order.cost.toStringAsFixed(2)}€!'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  : null,
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }

  // Retourne une icône pour chaque boisson
  Widget _getDrinkIcon(DrinkType type) {
    switch (type) {
      case DrinkType.coffee:
        return const Icon(Icons.coffee, color: Colors.brown);
      case DrinkType.tea:
        return const Icon(Icons.emoji_food_beverage, color: Colors.green);
      case DrinkType.chocolate:
        return const Icon(Icons.cake, color: Colors.orange);
      default:
        return const Icon(Icons.local_drink, color: Colors.blueGrey);
    }
  }
}
