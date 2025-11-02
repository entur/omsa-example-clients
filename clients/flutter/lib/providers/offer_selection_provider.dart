import 'package:flutter/foundation.dart';
import 'package:omsa_demo_app/models/travel_models.dart';

class OfferSelectionProvider extends ChangeNotifier {
  Offer? _selectedOffer;

  Offer? get selectedOffer => _selectedOffer;

  void selectOffer(Offer? offer) {
    _selectedOffer = offer;
    notifyListeners();
  }

  void clearSelection() {
    _selectedOffer = null;
    notifyListeners();
  }
}
