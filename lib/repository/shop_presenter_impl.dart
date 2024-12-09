import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:yacine_coffeeshop/model/drink.dart';
import 'package:yacine_coffeeshop/repository/shop_presenter.dart';
import 'package:yacine_coffeeshop/repository/repository.dart';

class ShopPresenterImpl extends ShopPresenter {

  @override
  Map<DrinkType, Map<DrinkSize, double>> drinks = GetIt.instance<Repository>().drinks;

  @override
  void setHasSugar(Drink drink,bool hasSugar) {
    drink.hasSugar = hasSugar;
    notifyListeners();
  }

  @override
  void setHasWhippedCream(Drink drink,bool hasWhippedCream) {
    drink.hasWhippedCream = hasWhippedCream;
    _updatePrice(drink);
    notifyListeners();
  }

  @override
  void setSize(Drink drink, DrinkSize size) {
    drink.size = size;
    _updatePrice(drink);
    notifyListeners();
  }

  @override
  void setType(Drink drink, DrinkType type) {
    drink.type = type;
    _updatePrice(drink);
    notifyListeners();
  }
  // Check affordability
  @override
  bool isAffordable(Drink drink, double credit) => drink.totalCost  <= credit;

  // Private method to update the price
  void _updatePrice(Drink drink){
    drink.totalCost = drinks[drink.type]![drink.size]!;
    if (drink.hasWhippedCream) drink.totalCost += 1.5;
  }


}
