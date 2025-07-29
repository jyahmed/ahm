import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/restaurant.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant? restaurant;

  const RestaurantScreen({super.key, this.restaurant});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  late Restaurant restaurant;
  
  final List<Product> dummyProducts = [
    Product(
      id: 1,
      name: 'بيج ماك',
      description: 'برجر لحم بقري مع الخس والطماطم والبصل',
      price: 25.0,
      image: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3',
      restaurantId: 1,
      categories: ['برجر'],
    ),
    Product(
      id: 2,
      name: 'تشيز برجر',
      description: 'برجر لحم بقري مع الجبن والخس',
      price: 20.0,
      image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3',
      restaurantId: 1,
      categories: ['برجر'],
      discount: 10,
    ),
    Product(
      id: 3,
      name: 'بطاطس مقلية',
      description: 'بطاطس مقلية ذهبية ومقرمشة',
      price: 12.0,
      image: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?ixlib=rb-4.0.3',
      restaurantId: 1,
      categories: ['مقبلات'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    restaurant = widget.restaurant ?? Restaurant(
      id: 1,
      name: 'برجر كينج',
      image: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3',
      rating: 4.8,
      deliveryTime: '25-35 دقيقة',
      deliveryFee: '5 ر.س',
      categories: ['برجر', 'وجبات سريعة'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar مع صورة المطعم
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: restaurant.image,
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
                    Icons.restaurant,
                    size: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          
          // معلومات المطعم
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: restaurant.rating,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        restaurant.rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.deliveryTime,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.delivery_dining,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        restaurant.deliveryFee,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Wrap(
                    spacing: 8,
                    children: restaurant.categories.map((category) {
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
                ],
              ),
            ),
          ),
          
          // قائمة المنتجات
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'القائمة',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dummyProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: dummyProducts[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

