import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // صورة المنتج
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: product.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.fastfood,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // معلومات المنتج
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // السعر
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (product.discount != null)
                            Text(
                              '${product.price.toStringAsFixed(0)} ر.س',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Text(
                            '${product.finalPrice.toStringAsFixed(0)} ر.س',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3B82F6),
                            ),
                          ),
                        ],
                      ),
                      
                      // زر الإضافة للسلة
                      Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          final cartItem = cart.getItem(product.id);
                          
                          if (cartItem == null) {
                            return ElevatedButton(
                              onPressed: product.isAvailable
                                  ? () {
                                      cart.addItem(product);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('تم إضافة ${product.name} إلى السلة'),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(60, 32),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              child: const Text(
                                'إضافة',
                                style: TextStyle(fontSize: 12),
                              ),
                            );
                          }
                          
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (cartItem.quantity > 1) {
                                    cart.updateQuantity(
                                      product.id,
                                      cartItem.quantity - 1,
                                    );
                                  } else {
                                    cart.removeItem(product.id);
                                  }
                                },
                                icon: const Icon(Icons.remove),
                                iconSize: 16,
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                              ),
                              Text(
                                cartItem.quantity.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cart.updateQuantity(
                                    product.id,
                                    cartItem.quantity + 1,
                                  );
                                },
                                icon: const Icon(Icons.add),
                                iconSize: 16,
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

