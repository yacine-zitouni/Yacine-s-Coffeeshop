enum DrinkType { coffee, tea, chocolate }

enum DrinkSize { small, medium, large }

class Order {

  DrinkType? type;
  DrinkSize size = DrinkSize.small;
  bool hasWhippedCream = false;
  bool hasSugar = false;
  double cost = 0;
  Order();
}
