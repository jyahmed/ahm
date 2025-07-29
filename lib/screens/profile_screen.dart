import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (!auth.isAuthenticated) {
            return _buildLoginPrompt(context);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // معلومات المستخدم
                Container(
                  padding: const EdgeInsets.all(20),
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
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xFF3B82F6),
                        child: Text(
                          auth.userName?.substring(0, 1).toUpperCase() ?? 'م',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auth.userName ?? 'المستخدم',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              auth.userEmail ?? '',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'عضو نشط',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // إحصائيات سريعة
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard('الطلبات', '12', Icons.receipt_long),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('النقاط', '250', Icons.stars),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard('الكوبونات', '3', Icons.local_offer),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // قائمة الخيارات
                _buildMenuSection([
                  _buildMenuItem(
                    icon: Icons.person_outline,
                    title: 'تعديل الملف الشخصي',
                    onTap: () => _showEditProfileDialog(context, auth),
                  ),
                  _buildMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'العناوين المحفوظة',
                    onTap: () => _showAddressesDialog(context),
                  ),
                  _buildMenuItem(
                    icon: Icons.payment_outlined,
                    title: 'طرق الدفع',
                    onTap: () => _showPaymentMethodsDialog(context),
                  ),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'الإشعارات',
                    onTap: () => _showNotificationSettings(context),
                  ),
                ]),

                const SizedBox(height: 16),

                _buildMenuSection([
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: 'المساعدة والدعم',
                    onTap: () => _showHelpDialog(context),
                  ),
                  _buildMenuItem(
                    icon: Icons.info_outline,
                    title: 'حول التطبيق',
                    onTap: () => _showAboutDialog(context),
                  ),
                  _buildMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'سياسة الخصوصية',
                    onTap: () => _showPrivacyDialog(context),
                  ),
                ]),

                const SizedBox(height: 16),

                _buildMenuSection([
                  _buildMenuItem(
                    icon: Icons.logout,
                    title: 'تسجيل الخروج',
                    onTap: () => _showLogoutDialog(context, auth),
                    isDestructive: true,
                  ),
                ]),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginPrompt(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_outline,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 24),
            const Text(
              'مرحباً بك!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'سجل دخولك للوصول إلى ملفك الشخصي وتتبع طلباتك',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          Icon(
            icon,
            color: const Color(0xFF3B82F6),
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3B82F6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(List<Widget> items) {
    return Container(
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
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : const Color(0xFF3B82F6),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  void _showEditProfileDialog(BuildContext context, AuthProvider auth) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل الملف الشخصي'),
        content: const Text('هذه الميزة ستكون متاحة قريباً'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showAddressesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('العناوين المحفوظة'),
        content: const Text('لم تقم بحفظ أي عناوين بعد'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('طرق الدفع'),
        content: const Text('لم تقم بإضافة أي طرق دفع بعد'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إعدادات الإشعارات'),
        content: const Text('هذه الميزة ستكون متاحة قريباً'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('المساعدة والدعم'),
        content: const Text('للمساعدة، يرجى التواصل معنا على:\nالهاتف: 920000000\nالبريد الإلكتروني: support@hometodoor.com'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حول التطبيق'),
        content: const Text('تطبيق توصيل من المنزل للباب\nالإصدار 1.0.0\n\nتطبيق توصيل طعام من المطاعم والمتاجر إلى بابك'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('سياسة الخصوصية'),
        content: const Text('نحن نحترم خصوصيتك ونحمي بياناتك الشخصية وفقاً لأعلى معايير الأمان'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider auth) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              auth.logout();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم تسجيل الخروج بنجاح'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}

