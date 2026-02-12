import 'package:flutter/foundation.dart';
import 'package:omsa_demo_app/models/travel_models.dart';

class OfferSelectionProvider extends ChangeNotifier {
  OfferCollection? _offerCollection;
  Offer? _selectedOffer;

  OfferCollection? get offerCollection => _offerCollection;
  Offer? get selectedOffer => _selectedOffer;

  void setOfferCollection(OfferCollection offers) {
    _offerCollection = offers;
    _selectedOffer = null;
    notifyListeners();
  }

  Offer? findOfferById(String offerId) {
    final offers = _offerCollection?.offers;
    if (offers == null) return null;
    for (final offer in offers) {
      if (offer.id == offerId) return offer;
    }
    return null;
  }

  void selectOffer(Offer? offer) {
    _selectedOffer = offer;
    notifyListeners();
  }

  void clearSelection() {
    _selectedOffer = null;
    notifyListeners();
  }
}
