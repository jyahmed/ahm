import 'package:flutter/material.dart';
import '../widgets/restaurant_card.dart';
import '../models/restaurant.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Restaurant> allStores = [
    Restaurant(
      id: 7,
      name: 'كارفور',
      image: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?ixlib=rb-4.0.3',
      rating: 4.3,
      deliveryTime: '45-60 دقيقة',
      deliveryFee: '10 ر.س',
      categories: ['سوبر ماركت', 'بقالة'],
    ),
    Restaurant(
      id: 8,
      name: 'صيدلية النهدي',
      image: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?ixlib=rb-4.0.3',
      rating: 4.6,
      deliveryTime: '20-30 دقيقة',
      deliveryFee: '8 ر.س',
      categories: ['صيدلية', 'صحة'],
    ),
    Restaurant(
      id: 9,
      name: 'متجر الكتب',
      image: 'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-4.0.3',
      rating: 4.1,
      deliveryTime: '30-45 دقيقة',
      deliveryFee: '12 ر.س',
      categories: ['كتب', 'قرطاسية'],
    ),
    Restaurant(
      id: 10,
      name: 'متجر الإلكترونيات',
      image: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3',
      rating: 4.4,
      deliveryTime: '60-90 دقيقة',
      deliveryFee: '15 ر.س',
      categories: ['إلكترونيات', 'تقنية'],
    ),
    Restaurant(
      id: 11,
      name: 'محل الورود',
      image: 'https://images.unsplash.com/photo-1490750967868-88aa4486c946?ixlib=rb-4.0.3',
      rating: 4.7,
      deliveryTime: '25-40 دقيقة',
      deliveryFee: '7 ر.س',
      categories: ['ورود', 'هدايا'],
    ),
    Restaurant(
      id: 12,
      name: 'متجر الملابس',
      image: 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?ixlib=rb-4.0.3',
      rating: 4.2,
      deliveryTime: '40-60 دقيقة',
      deliveryFee: '12 ر.س',
      categories: ['ملابس', 'أزياء'],
    ),
  ];

  List<Restaurant> get filteredStores {
    return allStores.where((store) {
      return store.name.contains(searchQuery) ||
          store.categories.any((category) => category.contains(searchQuery));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المتاجر'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // شريط البحث
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'ابحث عن متجر...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          
          // فئات المتاجر
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryChip('الكل', null),
                _buildCategoryChip('سوبر ماركت', 'سوبر ماركت'),
                _buildCategoryChip('صيدلية', 'صيدلية'),
                _buildCategoryChip('إلكترونيات', 'إلكترونيات'),
                _buildCategoryChip('ملابس', 'ملابس'),
                _buildCategoryChip('كتب', 'كتب'),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // قائمة المتاجر
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredStores.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                  restaurant: filteredStores[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, String? category) {
    final isSelected = category == null ? searchQuery.isEmpty : searchQuery == category;
    
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            searchQuery = selected && category != null ? category : '';
            _searchController.text = searchQuery;
          });
        },
        selectedColor: const Color(0xFF3B82F6).withOpacity(0.2),
        checkmarkColor: const Color(0xFF3B82F6),
      ),
    );
  }
}

