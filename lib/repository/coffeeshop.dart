import 'package:yacine_coffeeshop/data/drink.dart';
import 'package:yacine_coffeeshop/repository/repository.dart';

class Coffeeshop implements Repository{

  @override
   List<Drink> drinks = [
    Drink(DrinkType.coffee, DrinkSize.small, 2.1),
    Drink(DrinkType.coffee, DrinkSize.medium, 2.9),
    Drink(DrinkType.coffee, DrinkSize.large, 3.2),
    Drink(DrinkType.tea, DrinkSize.small, 2.3),
    Drink(DrinkType.tea, DrinkSize.medium, 3.1),
    Drink(DrinkType.tea, DrinkSize.large, 4.3),
    Drink(DrinkType.chocolate, DrinkSize.small, 2.5),
    Drink(DrinkType.chocolate, DrinkSize.medium, 3.3),
    Drink(DrinkType.chocolate, DrinkSize.large, 5.1),
   ]
}