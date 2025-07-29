import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class RecentOrdersWidget extends StatelessWidget {
  const RecentOrdersWidget({super.key});

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
                'الطلبات الأخيرة',
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
          ...List.generate(5, (index) => _buildOrderItem(index)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(int index) {
    final orders = [
      {
        'id': '#12345',
        'customer': 'أحمد محمد',
        'restaurant': 'مطعم الشام',
        'amount': '85.50 ر.س',
        'status': 'تم التوصيل',
        'time': 'منذ 5 دقائق',
        'statusColor': AppColors.success,
      },
      {
        'id': '#12344',
        'customer': 'فاطمة علي',
        'restaurant': 'بيتزا هت',
        'amount': '120.00 ر.س',
        'status': 'في الطريق',
        'time': 'منذ 12 دقيقة',
        'statusColor': AppColors.info,
      },
      {
        'id': '#12343',
        'customer': 'محمد سالم',
        'restaurant': 'كنتاكي',
        'amount': '95.75 ر.س',
        'status': 'قيد التجهيز',
        'time': 'منذ 18 دقيقة',
        'statusColor': AppColors.warning,
      },
      {
        'id': '#12342',
        'customer': 'سارة أحمد',
        'restaurant': 'ماكدونالدز',
        'amount': '67.25 ر.س',
        'status': 'تم التوصيل',
        'time': 'منذ 25 دقيقة',
        'statusColor': AppColors.success,
      },
      {
        'id': '#12341',
        'customer': 'عبدالله خالد',
        'restaurant': 'مطعم البيك',
        'amount': '45.00 ر.س',
        'status': 'ملغى',
        'time': 'منذ 30 دقيقة',
        'statusColor': AppColors.error,
      },
    ];

    final order = orders[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order['id'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (order['statusColor'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order['status'] as String,
                  style: TextStyle(
                    color: order['statusColor'] as Color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['customer'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      order['restaurant'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    order['amount'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    order['time'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

