import 'package:flutter/material.dart';
import 'package:yacine_coffeeshop/model/drink.dart';

abstract class ShopPresenter extends ChangeNotifier {
  abstract Map<DrinkType, Map<DrinkSize, double>> drinks;

  void setType(Drink drink, DrinkType type);
  void setSize(Drink drink, DrinkSize size);
  void setHasSugar(Drink drink, bool hasSugar);
  void setHasWhippedCream(Drink drink, bool hasWhippedCream);
  bool isAffordable(Drink drink, double credit);
}
