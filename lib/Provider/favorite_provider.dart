import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> get favorites => _favoriteIds;
  FavoriteProvider() {
    loadFavorite();
  }
  // toggle
  void toggle(DocumentSnapshot product) async {
    String productId = product.id;

    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      await _removeFavorite(productId);
    } else {
      _favoriteIds.add(productId);
      await _addFavorite(productId);
    }
    notifyListeners();
  }

  // for check is favorite is exist
  bool isExist(DocumentSnapshot produc) {
    return _favoriteIds.contains(produc.id);
  }

  //add favorite

  Future<void> _addFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).set({
        "isFavorite": true,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //remove favorite
  Future<void> _removeFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
  //for load favorite if favorite or not

  Future<void> loadFavorite() async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection("userFavorite").get();
      _favoriteIds = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  //static method to acces the provider from any context
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of(context, listen: listen);
  }
}
