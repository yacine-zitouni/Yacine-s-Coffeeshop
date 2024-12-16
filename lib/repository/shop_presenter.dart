import 'package:flutter/material.dart';
import 'package:yacine_coffeeshop/model/order.dart';

abstract class ShopPresenter extends ChangeNotifier {
  abstract Map<DrinkType, Map<DrinkSize, double>> drinks;

  void setType(Order drink, DrinkType type);
  void setSize(Order drink, DrinkSize size);
  void setHasSugar(Order drink, bool hasSugar);
  void setHasWhippedCream(Order drink, bool hasWhippedCream);
  bool isAffordable(Order drink, double credit);
  
}
