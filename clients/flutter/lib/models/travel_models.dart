// Response models for OMSA API.
// Request-side DTOs have been replaced by the generated omsa_api package.

class ProductId {
  final String productId;
  final String name;

  ProductId({required this.productId, required this.name});

  factory ProductId.fromJson(Map<String, dynamic> json) {
    return ProductId(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Product {
  final String type;
  final ProductId productId;
  final String productName;

  Product({
    required this.type,
    required this.productId,
    required this.productName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      type: json['type'] ?? '',
      productId: ProductId.fromJson(json['productId'] ?? {}),
      productName: json['productName'] ?? '',
    );
  }
}

class Price {
  final double amount;
  final String currencyCode;
  final String vatCountryCode;

  Price({
    required this.amount,
    required this.currencyCode,
    required this.vatCountryCode,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: (json['amount'] ?? 0).toDouble(),
      currencyCode: json['currencyCode'] ?? '',
      vatCountryCode: json['vatCountryCode'] ?? '',
    );
  }
}

class Summary {
  final String name;
  final String description;
  final bool isRefundable;
  final bool isExchangeable;

  Summary({
    required this.name,
    required this.description,
    required this.isRefundable,
    required this.isExchangeable,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      isRefundable: json['isRefundable'] ?? false,
      isExchangeable: json['isExchangeable'] ?? false,
    );
  }
}

class OfferProperties {
  final List<Product> products;
  final Price price;
  final Summary summary;

  OfferProperties({
    required this.products,
    required this.price,
    required this.summary,
  });

  factory OfferProperties.fromJson(Map<String, dynamic> json) {
    return OfferProperties(
      products: (json['products'] as List<dynamic>? ?? [])
          .map((p) => Product.fromJson(p))
          .toList(),
      price: Price.fromJson(json['price'] ?? {}),
      summary: Summary.fromJson(json['summary'] ?? {}),
    );
  }
}

class Offer {
  final String id;
  final String type;
  final OfferProperties properties;

  Offer({required this.id, required this.type, required this.properties});

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      properties: OfferProperties.fromJson(json['properties'] ?? {}),
    );
  }
}

class OfferCollection {
  final String type;
  final List<Offer> offers;
  final int numberMatched;
  final int numberReturned;

  OfferCollection({
    required this.type,
    required this.offers,
    required this.numberMatched,
    required this.numberReturned,
  });

  factory OfferCollection.fromJson(Map<String, dynamic> json) {
    return OfferCollection(
      type: json['type'] ?? '',
      offers: (json['offers'] as List<dynamic>? ?? [])
          .map((o) => Offer.fromJson(o))
          .toList(),
      numberMatched: json['numberMatched'] ?? 0,
      numberReturned: json['numberReturned'] ?? 0,
    );
  }
}
