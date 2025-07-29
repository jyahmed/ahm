import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../utils/app_colors.dart';
import '../../widgets/admin/admin_sidebar.dart';

class AdminRestaurantsScreen extends StatefulWidget {
  const AdminRestaurantsScreen({super.key});

  @override
  State<AdminRestaurantsScreen> createState() => _AdminRestaurantsScreenState();
}

class _AdminRestaurantsScreenState extends State<AdminRestaurantsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'الكل';
  
  final List<Map<String, dynamic>> _restaurants = [
    {
      'id': '1',
      'name': 'مطعم الشام',
      'category': 'شرقي',
      'phone': '+966501234567',
      'email': 'alsham@example.com',
      'address': 'الرياض، حي النخيل',
      'rating': 4.8,
      'status': 'نشط',
      'ordersCount': 245,
      'revenue': '12,450.00',
      'image': 'https://via.placeholder.com/60',
      'deliveryTime': '25-35 دقيقة',
      'deliveryFee': '5.00',
    },
    {
      'id': '2',
      'name': 'بيتزا هت',
      'category': 'إيطالي',
      'phone': '+966507654321',
      'email': 'pizzahut@example.com',
      'address': 'الرياض، حي العليا',
      'rating': 4.6,
      'status': 'نشط',
      'ordersCount': 198,
      'revenue': '9,870.50',
      'image': 'https://via.placeholder.com/60',
      'deliveryTime': '30-40 دقيقة',
      'deliveryFee': '7.50',
    },
    {
      'id': '3',
      'name': 'كنتاكي',
      'category': 'وجبات سريعة',
      'phone': '+966509876543',
      'email': 'kfc@example.com',
      'address': 'الرياض، حي الملز',
      'rating': 4.5,
      'status': 'معلق',
      'ordersCount': 176,
      'revenue': '8,920.25',
      'image': 'https://via.placeholder.com/60',
      'deliveryTime': '20-30 دقيقة',
      'deliveryFee': '6.00',
    },
    {
      'id': '4',
      'name': 'ماكدونالدز',
      'category': 'وجبات سريعة',
      'phone': '+966502468135',
      'email': 'mcdonalds@example.com',
      'address': 'الرياض، حي السليمانية',
      'rating': 4.4,
      'status': 'نشط',
      'ordersCount': 165,
      'revenue': '7,650.75',
      'image': 'https://via.placeholder.com/60',
      'deliveryTime': '15-25 دقيقة',
      'deliveryFee': '5.50',
    },
    {
      'id': '5',
      'name': 'مطعم البيك',
      'category': 'وجبات سريعة',
      'phone': '+966508642097',
      'email': 'albaik@example.com',
      'address': 'الرياض، حي الورود',
      'rating': 4.7,
      'status': 'نشط',
      'ordersCount': 142,
      'revenue': '6,890.00',
      'image': 'https://via.placeholder.com/60',
      'deliveryTime': '20-30 دقيقة',
      'deliveryFee': '4.00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          const AdminSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _buildFiltersAndSearch(),
                        const SizedBox(height: 24),
                        Expanded(child: _buildRestaurantsGrid()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'إدارة المطاعم',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {
              _showAddRestaurantDialog();
            },
            icon: const Icon(Icons.add),
            label: const Text('إضافة مطعم'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersAndSearch() {
    return Row(
      children: [
        // البحث
        Expanded(
          flex: 2,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'البحث عن مطعم...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        
        const SizedBox(width: 16),
        
        // فلتر الحالة
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButton<String>(
            value: _selectedFilter,
            underline: const SizedBox(),
            items: ['الكل', 'نشط', 'معلق', 'مغلق']
                .map((filter) => DropdownMenuItem(
                      value: filter,
                      child: Text(filter),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedFilter = value!;
              });
            },
          ),
        ),
        
        const SizedBox(width: 16),
        
        // فلتر الفئة
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButton<String>(
            value: 'جميع الفئات',
            underline: const SizedBox(),
            items: ['جميع الفئات', 'شرقي', 'إيطالي', 'وجبات سريعة', 'صيني']
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
            onChanged: (value) {
              // تطبيق فلتر الفئة
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantsGrid() {
    final filteredRestaurants = _restaurants.where((restaurant) {
      final matchesSearch = restaurant['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          restaurant['category']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      
      final matchesFilter = _selectedFilter == 'الكل' || 
          restaurant['status'] == _selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.2,
      ),
      itemCount: filteredRestaurants.length,
      itemBuilder: (context, index) {
        return _buildRestaurantCard(filteredRestaurants[index]);
      },
    );
  }

  Widget _buildRestaurantCard(Map<String, dynamic> restaurant) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة المطعم
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: restaurant['image'],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.surfaceVariant,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.surfaceVariant,
                      child: Icon(
                        Icons.restaurant,
                        size: 40,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
                
                // شارة الحالة
                Positioned(
                  top: 12,
                  right: 12,
                  child: _buildStatusChip(restaurant['status']),
                ),
                
                // التقييم
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          restaurant['rating'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.star,
                          color: AppColors.rating,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // معلومات المطعم
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المطعم والفئة
                  Text(
                    restaurant['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  Text(
                    restaurant['category'],
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // العنوان
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          restaurant['address'],
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // معلومات التوصيل
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoChip(
                          icon: Icons.access_time,
                          text: restaurant['deliveryTime'],
                          color: AppColors.info,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildInfoChip(
                          icon: Icons.delivery_dining,
                          text: '${restaurant['deliveryFee']} ر.س',
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // الإحصائيات
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${restaurant['ordersCount']} طلب',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'إجمالي الطلبات',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${restaurant['revenue']} ر.س',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                          Text(
                            'الإيرادات',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // أزرار الإجراءات
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _showRestaurantDetails(restaurant),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'عرض',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showEditRestaurantDialog(restaurant),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'تعديل',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'نشط':
        color = AppColors.success;
        break;
      case 'معلق':
        color = AppColors.warning;
        break;
      case 'مغلق':
        color = AppColors.error;
        break;
      default:
        color = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color,
            size: 10,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddRestaurantDialog() {
    // تنفيذ حوار إضافة مطعم جديد
  }

  void _showRestaurantDetails(Map<String, dynamic> restaurant) {
    // تنفيذ عرض تفاصيل المطعم
  }

  void _showEditRestaurantDialog(Map<String, dynamic> restaurant) {
    // تنفيذ حوار تعديل المطعم
  }
}

