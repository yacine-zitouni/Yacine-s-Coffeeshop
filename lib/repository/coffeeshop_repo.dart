import 'package:yacine_coffeeshop/model/order.dart';
import 'package:yacine_coffeeshop/repository/repository.dart';

class CoffeeshopRepo implements Repository{

  @override
  Map<DrinkType, Map<DrinkSize, double>> drinks = {
      DrinkType.coffee: {
        DrinkSize.small: 2.1,
        DrinkSize.medium: 2.9,
        DrinkSize.large: 3.2
      },
      DrinkType.tea: {
        DrinkSize.small: 2.3,
        DrinkSize.medium: 3.1,
        DrinkSize.large: 4.3
      },
      DrinkType.chocolate: {
        DrinkSize.small: 2.5,
        DrinkSize.medium: 3.3,
        DrinkSize.large: 5.1
      }
    };
    
}