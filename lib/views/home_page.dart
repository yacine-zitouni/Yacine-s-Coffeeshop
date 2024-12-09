
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:yacine_coffeeshop/model/drink.dart';
import 'package:yacine_coffeeshop/repository/repository.dart';
import 'package:yacine_coffeeshop/views/order_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final drinks = GetIt.instance<Repository>().drinks;

  DrinkType? _selectedDrink;
  DrinkSize _selectedSize = DrinkSize.small;
  bool _hasSugar = false;
  bool _hasWhippedCream = false;
  final double _userBalance = 5.0; // Montant disponible sur la carte du client.

  bool get _isAffordable => _totalCost <= _userBalance;

  double get _totalCost {
    if (_selectedDrink == null) return 0.0;
    double baseCost = drinks[_selectedDrink]![_selectedSize]!;
    if (_hasWhippedCream) baseCost += 1.5;
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
            Text('Drinks:', style: TextStyle(fontSize: 18)),
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
              title: Text('Sugar (Free)'),
              value: _hasSugar,
              enabled: _selectedDrink != DrinkType.chocolate, // Ne pas proposer de sucre pour le chocolat.
              onChanged: (bool? value) {
                setState(() {
                  _hasSugar = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Whipped Cream (1.5€)'),
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
            if (!_isAffordable)
            Text(
                'Insufficient balance!',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            Text('Balance: ${_userBalance.toStringAsFixed(2)}€',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedDrink != null && _isAffordable
                  ? () {
                    Navigator.pushNamed(
                      context,'/order',
                      arguments:{
                            'type': _selectedDrink!,
                            'size': _selectedSize,
                            'sugar': _hasSugar,
                            'whippedCream': _hasWhippedCream,
                            'totalCost': _totalCost
                      }
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
