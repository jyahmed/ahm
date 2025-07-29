import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class AdminSidebar extends StatefulWidget {
  const AdminSidebar({super.key});

  @override
  State<AdminSidebar> createState() => _AdminSidebarState();
}

class _AdminSidebarState extends State<AdminSidebar> {
  int selectedIndex = 0;

  final List<SidebarItem> menuItems = [
    SidebarItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      title: 'لوحة القيادة',
      route: '/admin/dashboard',
    ),
    SidebarItem(
      icon: Icons.people_outline,
      selectedIcon: Icons.people,
      title: 'المستخدمين',
      route: '/admin/users',
    ),
    SidebarItem(
      icon: Icons.restaurant_outlined,
      selectedIcon: Icons.restaurant,
      title: 'المطاعم',
      route: '/admin/restaurants',
    ),
    SidebarItem(
      icon: Icons.inventory_2_outlined,
      selectedIcon: Icons.inventory_2,
      title: 'المنتجات',
      route: '/admin/products',
    ),
    SidebarItem(
      icon: Icons.shopping_bag_outlined,
      selectedIcon: Icons.shopping_bag,
      title: 'الطلبات',
      route: '/admin/orders',
    ),
    SidebarItem(
      icon: Icons.local_offer_outlined,
      selectedIcon: Icons.local_offer,
      title: 'الكوبونات',
      route: '/admin/coupons',
    ),
    SidebarItem(
      icon: Icons.category_outlined,
      selectedIcon: Icons.category,
      title: 'الفئات',
      route: '/admin/categories',
    ),
    SidebarItem(
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics,
      title: 'التقارير',
      route: '/admin/reports',
    ),
    SidebarItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      title: 'الإعدادات',
      route: '/admin/settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // شعار التطبيق
          _buildLogo(),
          
          // قائمة التنقل
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return _buildMenuItem(index);
              },
            ),
          ),
          
          // زر تسجيل الخروج
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.admin_panel_settings,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'لوحة التحكم',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'توصيل من المنزل للباب',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index) {
    final item = menuItems[index];
    final isSelected = selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            // التنقل إلى الصفحة المطلوبة
            // Navigator.pushNamed(context, item.route);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: AppColors.primary.withOpacity(0.3))
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? item.selectedIcon : item.icon,
                  color: isSelected ? AppColors.primary : Colors.white70,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: isSelected ? AppColors.primary : Colors.white70,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // تسجيل الخروج
            _showLogoutDialog();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 24,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'تسجيل الخروج',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد تسجيل الخروج'),
          content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // تنفيذ تسجيل الخروج
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'تسجيل الخروج',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SidebarItem {
  final IconData icon;
  final IconData selectedIcon;
  final String title;
  final String route;

  SidebarItem({
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.route,
  });
}

