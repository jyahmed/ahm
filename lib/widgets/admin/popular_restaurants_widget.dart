import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class PopularRestaurantsWidget extends StatelessWidget {
  const PopularRestaurantsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المطاعم الأكثر شعبية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'عرض الكل',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(5, (index) => _buildRestaurantItem(index)),
        ],
      ),
    );
  }

  Widget _buildRestaurantItem(int index) {
    final restaurants = [
      {
        'name': 'مطعم الشام',
        'orders': '245',
        'rating': '4.8',
        'revenue': '12,450 ر.س',
        'image': 'https://via.placeholder.com/50',
      },
      {
        'name': 'بيتزا هت',
        'orders': '198',
        'rating': '4.6',
        'revenue': '9,870 ر.س',
        'image': 'https://via.placeholder.com/50',
      },
      {
        'name': 'كنتاكي',
        'orders': '176',
        'rating': '4.5',
        'revenue': '8,920 ر.س',
        'image': 'https://via.placeholder.com/50',
      },
      {
        'name': 'ماكدونالدز',
        'orders': '165',
        'rating': '4.4',
        'revenue': '7,650 ر.س',
        'image': 'https://via.placeholder.com/50',
      },
      {
        'name': 'مطعم البيك',
        'orders': '142',
        'rating': '4.7',
        'revenue': '6,890 ر.س',
        'image': 'https://via.placeholder.com/50',
      },
    ];

    final restaurant = restaurants[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // ترتيب المطعم
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: index < 3 ? AppColors.primary : AppColors.textSecondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // صورة المطعم
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(restaurant['image'] as String),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // معلومات المطعم
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant['name'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${restaurant['orders']} طلب',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.star,
                      size: 14,
                      color: AppColors.rating,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      restaurant['rating'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // الإيرادات
          Text(
            restaurant['revenue'] as String,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}

