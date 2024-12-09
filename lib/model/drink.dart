enum DrinkType { coffee, tea, chocolate }

enum DrinkSize { small, medium, large }

class Drink {
  DrinkType? type;
  DrinkSize size = DrinkSize.small;
  bool hasSugar = false;
  bool hasWhippedCream = false;
  double totalCost = 0.0;

  Drink();
}
