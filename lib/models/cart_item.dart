import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String? notes;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.notes,
  });

  double get totalPrice => product.finalPrice * quantity;

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? notes,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'notes': notes,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
      notes: json['notes'],
    );
  }
}

