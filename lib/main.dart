import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:yacine_coffeeshop/data/drinks.dart';
import 'package:yacine_coffeeshop/repository/coffeeshop.dart';
import 'package:yacine_coffeeshop/repository/repository.dart';

void main() {
  GetIt.instance.registerSingleton<Repository>(Coffeeshop());
  runApp(DrinkOrderApp());
} 

class DrinkOrderApp extends StatelessWidget {
  Coffeeshop coffeeshop = Coffeeshop();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink Order',
      home: DrinkSelectionScreen(),
    );
  }
}

class DrinkSelectionScreen extends StatefulWidget {
  @override
  _DrinkSelectionScreenState createState() => _DrinkSelectionScreenState();
}

class _DrinkSelectionScreenState extends State<DrinkSelectionScreen> {
  
  final drinks = GetIt.instance<Repository>().drinks;

  DrinkType? _selectedDrink;
  DrinkSize _selectedSize = DrinkSize.small;
  bool _hasSugar = false;
  bool _hasWhippedCream = false;
  double _userBalance = 10.0; // Montant disponible sur la carte du client.

  double get _totalCost {
    if (_selectedDrink == null) return 0.0;
    double baseCost = drinks[_selectedDrink]![_selectedSize]!;
    if (_hasSugar) baseCost += 0.5;
    if (_hasWhippedCream) baseCost += 1.0;
    return baseCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your drink'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select your drink:', style: TextStyle(fontSize: 18)),
            Column(
              children: DrinkType.values.map((drink) {
                return RadioListTile<DrinkType>(
                  title: Text(drink.toString().split('.').last),
                  value: drink,
                  groupValue: _selectedDrink,
                  onChanged: (DrinkType? value) {
                    setState(() {
                      _selectedDrink = value;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('Select the size:', style: TextStyle(fontSize: 18)),
            Slider(
              value: _selectedSize.index.toDouble(),
              min: 0,
              max: DrinkSize.values.length - 1.0,
              divisions: 2,
              label: _selectedSize.toString().split('.').last,
              onChanged: (value) {
                setState(() {
                  _selectedSize = DrinkSize.values[value.toInt()];
                });
              },
            ),
            SizedBox(height: 16),
            Text('Add supplements:', style: TextStyle(fontSize: 18)),
            CheckboxListTile(
              title: Text('Sugar (0.5€)'),
              value: _hasSugar,
              onChanged: (bool? value) {
                setState(() {
                  _hasSugar = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Whipped Cream (1.0€)'),
              value: _hasWhippedCream,
              onChanged: (bool? value) {
                setState(() {
                  _hasWhippedCream = value ?? false;
                });
              },
            ),
            SizedBox(height: 16),
            Text('Total cost: ${_totalCost.toStringAsFixed(2)}€',
                style: TextStyle(fontSize: 18)),
            Text('Balance: ${_userBalance.toStringAsFixed(2)}€',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedDrink != null && _totalCost <= _userBalance
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationScreen(
                            drink: _selectedDrink!,
                            size: _selectedSize,
                            sugar: _hasSugar,
                            whippedCream: _hasWhippedCream,
                            totalCost: _totalCost,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Text('Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  final DrinkType drink;
  final DrinkSize size;
  final bool sugar;
  final bool whippedCream;
  final double totalCost;

  ConfirmationScreen({
    required this.drink,
    required this.size,
    required this.sugar,
    required this.whippedCream,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order Details:', style: TextStyle(fontSize: 18)),
            Text('Drink: ${drink.toString().split('.').last}'),
            Text('Size: ${size.toString().split('.').last}'),
            Text('Sugar: ${sugar ? "Yes" : "No"}'),
            Text('Whipped Cream: ${whippedCream ? "Yes" : "No"}'),
            Text('Total Cost: ${totalCost.toStringAsFixed(2)}€'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to menu'),
            ),
          ],
        ),
      ),
    );
  }
}
