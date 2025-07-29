import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/app_colors.dart';
import '../../widgets/admin/admin_sidebar.dart';
import '../../widgets/admin/stats_card.dart';
import '../../widgets/admin/recent_orders_widget.dart';
import '../../widgets/admin/popular_restaurants_widget.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Row(
        children: [
          // الشريط الجانبي
          const AdminSidebar(),
          
          // المحتوى الرئيسي
          Expanded(
            child: Column(
              children: [
                // الهيدر
                _buildHeader(),
                
                // المحتوى
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // بطاقات الإحصائيات
                        _buildStatsCards(),
                        
                        const SizedBox(height: 32),
                        
                        // الرسوم البيانية والجداول
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // العمود الأيسر
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  _buildSalesChart(),
                                  const SizedBox(height: 24),
                                  _buildOrdersChart(),
                                ],
                              ),
                            ),
                            
                            const SizedBox(width: 24),
                            
                            // العمود الأيمن
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  const RecentOrdersWidget(),
                                  const SizedBox(height: 24),
                                  const PopularRestaurantsWidget(),
                                ],
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
            'لوحة القيادة',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          
          const Spacer(),
          
          // الإشعارات
          IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  size: 28,
                  color: AppColors.textSecondary,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // معلومات المسؤول
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary,
                child: const Text(
                  'أ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'أحمد محمد',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'مدير النظام',
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

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: StatsCard(
            title: 'إجمالي المستخدمين',
            value: '2,847',
            change: '+12%',
            isPositive: true,
            icon: Icons.people_outline,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatsCard(
            title: 'الطلبات اليوم',
            value: '156',
            change: '+8%',
            isPositive: true,
            icon: Icons.shopping_bag_outlined,
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatsCard(
            title: 'إجمالي الإيرادات',
            value: '45,280 ر.س',
            change: '+15%',
            isPositive: true,
            icon: Icons.attach_money,
            color: AppColors.warning,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: StatsCard(
            title: 'المطاعم النشطة',
            value: '89',
            change: '+3%',
            isPositive: true,
            icon: Icons.restaurant_outlined,
            color: AppColors.info,
          ),
        ),
      ],
    );
  }

  Widget _buildSalesChart() {
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
                'المبيعات الشهرية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              DropdownButton<String>(
                value: 'هذا الشهر',
                items: const [
                  DropdownMenuItem(value: 'هذا الشهر', child: Text('هذا الشهر')),
                  DropdownMenuItem(value: 'الشهر الماضي', child: Text('الشهر الماضي')),
                  DropdownMenuItem(value: 'آخر 3 أشهر', child: Text('آخر 3 أشهر')),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 3),
                      const FlSpot(2.6, 2),
                      const FlSpot(4.9, 5),
                      const FlSpot(6.8, 3.1),
                      const FlSpot(8, 4),
                      const FlSpot(9.5, 3),
                      const FlSpot(11, 4),
                    ],
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersChart() {
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
          Text(
            'توزيع الطلبات حسب الحالة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 40,
                    title: 'تم التوصيل',
                    color: AppColors.success,
                    radius: 60,
                  ),
                  PieChartSectionData(
                    value: 30,
                    title: 'قيد التجهيز',
                    color: AppColors.warning,
                    radius: 60,
                  ),
                  PieChartSectionData(
                    value: 20,
                    title: 'في الطريق',
                    color: AppColors.info,
                    radius: 60,
                  ),
                  PieChartSectionData(
                    value: 10,
                    title: 'ملغى',
                    color: AppColors.error,
                    radius: 60,
                  ),
                ],
                centerSpaceRadius: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

