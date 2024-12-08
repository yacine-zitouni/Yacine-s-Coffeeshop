export 'drink.dart';

class Drink {
  final DrinkType type;
  final DrinkSize size;
  final double price;

  Drink(this.type, this.size,this.price);
}

enum DrinkType {
  coffee,
  tea,
  chocolate
}

enum DrinkSize {
  small,
  medium,
  large
}