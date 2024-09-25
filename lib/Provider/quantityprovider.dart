import 'package:flutter/material.dart';

class Quantityprovider extends ChangeNotifier {
  int _currentNumber = 1;
  List<double> _baseIngredientAmounts = [];
  int get currentNumber => _currentNumber;

  //set initial ingrediants amounts
  void setBaseIngredientAmount(List<double> amount) {
    _baseIngredientAmounts = amount;
    // notifyListeners();
  }

  //update ingredients amounts base on the quantity
  List<String> get updateIngredientAmounts {
    return _baseIngredientAmounts
        .map((amount) => (amount * _currentNumber).toStringAsFixed(1))
        .toList();
  }

  void IncreaseQuantity() {
    _currentNumber++;
    notifyListeners();
  }

  void DecreaseQuantity() {
    if (_currentNumber > 1) {
      _currentNumber--;
      notifyListeners();
    }
  }
}
