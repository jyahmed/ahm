import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'الإجراءات السريعة',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildQuickAction(
              context,
              icon: Icons.local_offer,
              label: 'العروض',
              color: AppColors.warning,
              onTap: () {
                // Navigate to offers
              },
            ),
            _buildQuickAction(
              context,
              icon: Icons.delivery_dining,
              label: 'توصيل سريع',
              color: AppColors.success,
              onTap: () {
                // Navigate to fast delivery
              },
            ),
            _buildQuickAction(
              context,
              icon: Icons.favorite,
              label: 'المفضلة',
              color: AppColors.favorite,
              onTap: () {
                // Navigate to favorites
              },
            ),
            _buildQuickAction(
              context,
              icon: Icons.history,
              label: 'الطلبات السابقة',
              color: AppColors.info,
              onTap: () {
                // Navigate to order history
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

