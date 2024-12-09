import 'package:yacine_coffeeshop/model/drink.dart';

abstract class Repository {
  //  La liste des boissons est représntée par un dictionnaire de dictionnaires
  abstract Map<DrinkType, Map<DrinkSize, double>> drinks;
}