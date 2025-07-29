import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductScreen extends StatefulWidget {
  final Product? product;

  const ProductScreen({super.key, this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Product product;
  int quantity = 1;
  String notes = '';
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    product = widget.product ?? Product(
      id: 1,
      name: 'بيج ماك',
      description: 'برجر لحم بقري طازج مع الخس والطماطم والبصل وصوص البيج ماك الخاص في خبز السمسم',
      price: 25.0,
      image: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3',
      restaurantId: 1,
      categories: ['برجر'],
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar مع صورة المنتج
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.fastfood,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          
          // محتوى المنتج
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المنتج
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // السعر
                  Row(
                    children: [
                      if (product.discount != null) ...[
                        Text(
                          '${product.price.toStringAsFixed(0)} ر.س',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${product.discount!.toStringAsFixed(0)}% خصم',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        '${product.finalPrice.toStringAsFixed(0)} ر.س',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // الوصف
                  const Text(
                    'الوصف',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // الفئات
                  const Text(
                    'الفئات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Wrap(
                    spacing: 8,
                    children: product.categories.map((category) {
                      return Chip(
                        label: Text(
                          category,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: const Color(0xFF3B82F6).withOpacity(0.1),
                        labelStyle: const TextStyle(
                          color: Color(0xFF3B82F6),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // الكمية
                  const Text(
                    'الكمية',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: quantity > 1 ? () {
                                setState(() {
                                  quantity--;
                                });
                              } : null,
                              icon: const Icon(Icons.remove),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      Text(
                        'المجموع: ${(product.finalPrice * quantity).toStringAsFixed(0)} ر.س',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // ملاحظات خاصة
                  const Text(
                    'ملاحظات خاصة (اختياري)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  TextField(
                    controller: _notesController,
                    maxLines: 3,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'أضف أي ملاحظات خاصة للطلب...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      notes = value;
                    },
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // زر الإضافة للسلة
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Consumer<CartProvider>(
          builder: (context, cart, child) {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: product.isAvailable ? () {
                  cart.addItem(
                    product,
                    quantity: quantity,
                    notes: notes.isNotEmpty ? notes : null,
                  );
                  
                  Navigator.pop(context);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم إضافة ${product.name} إلى السلة'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'عرض السلة',
                        textColor: Colors.white,
                        onPressed: () {
                          // يمكن إضافة التنقل إلى شاشة السلة هنا
                        },
                      ),
                    ),
                  );
                } : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: product.isAvailable 
                      ? const Color(0xFF3B82F6) 
                      : Colors.grey,
                ),
                child: Text(
                  product.isAvailable 
                      ? 'إضافة إلى السلة - ${(product.finalPrice * quantity).toStringAsFixed(0)} ر.س'
                      : 'غير متوفر حالياً',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

