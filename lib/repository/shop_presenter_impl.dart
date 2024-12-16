import 'package:get_it/get_it.dart';
import 'package:yacine_coffeeshop/model/order.dart';
import 'package:yacine_coffeeshop/repository/shop_presenter.dart';
import 'package:yacine_coffeeshop/repository/repository.dart';

class ShopPresenterImpl extends ShopPresenter {

  @override
  Map<DrinkType, Map<DrinkSize, double>> drinks = GetIt.instance<Repository>().drinks;

  @override
  void setHasSugar(Order drink,bool hasSugar) {
    drink.hasSugar = hasSugar;
    notifyListeners();
  }

  @override
  void setHasWhippedCream(Order drink,bool hasWhippedCream) {
    drink.hasWhippedCream = hasWhippedCream;
    _updatePrice(drink);
    notifyListeners();
  }

  @override
  void setSize(Order drink, DrinkSize size) {
    drink.size = size;
    _updatePrice(drink);
    notifyListeners();
  }

  @override
  void setType(Order drink, DrinkType type) {
    drink.type = type;
    _updatePrice(drink);
    notifyListeners();
  }
  // Check affordability
  @override
  bool isAffordable(Order drink, double credit) => drink.cost  <= credit;

  // Private method to update the price
  void _updatePrice(Order drink){
    drink.cost = drinks[drink.type]![drink.size]!;
    if (drink.hasWhippedCream) drink.cost += 1.5;
  }


}
