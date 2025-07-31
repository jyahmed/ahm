import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'العربية';
  String _selectedCurrency = 'ريال سعودي';
  
  final List<String> _languages = ['العربية', 'English'];
  final List<String> _currencies = ['ريال سعودي', 'دولار أمريكي', 'يورو'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      _locationEnabled = prefs.getBool('location_enabled') ?? true;
      _darkModeEnabled = prefs.getBool('dark_mode_enabled') ?? false;
      _selectedLanguage = prefs.getString('selected_language') ?? 'العربية';
      _selectedCurrency = prefs.getString('selected_currency') ?? 'ريال سعودي';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', _notificationsEnabled);
    await prefs.setBool('location_enabled', _locationEnabled);
    await prefs.setBool('dark_mode_enabled', _darkModeEnabled);
    await prefs.setString('selected_language', _selectedLanguage);
    await prefs.setString('selected_currency', _selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
        backgroundColor: const Color(0xFF3B82F6),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // إعدادات الإشعارات
            _buildSectionTitle('الإشعارات'),
            _buildSettingsCard([
              _buildSwitchTile(
                title: 'تفعيل الإشعارات',
                subtitle: 'استقبال إشعارات الطلبات والعروض',
                icon: Icons.notifications,
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                  _saveSettings();
                },
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'إعدادات الإشعارات المتقدمة',
                subtitle: 'تخصيص أنواع الإشعارات',
                icon: Icons.tune,
                onTap: () => _showNotificationSettings(),
              ),
            ]),

            const SizedBox(height: 20),

            // إعدادات الموقع
            _buildSectionTitle('الموقع والخصوصية'),
            _buildSettingsCard([
              _buildSwitchTile(
                title: 'تفعيل خدمات الموقع',
                subtitle: 'للحصول على أفضل تجربة توصيل',
                icon: Icons.location_on,
                value: _locationEnabled,
                onChanged: (value) {
                  setState(() {
                    _locationEnabled = value;
                  });
                  _saveSettings();
                },
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'إدارة العناوين',
                subtitle: 'إضافة وتعديل عناوين التوصيل',
                icon: Icons.home,
                onTap: () => _showAddressManagement(),
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'سياسة الخصوصية',
                subtitle: 'اطلع على كيفية استخدام بياناتك',
                icon: Icons.privacy_tip,
                onTap: () => _showPrivacyPolicy(),
              ),
            ]),

            const SizedBox(height: 20),

            // إعدادات التطبيق
            _buildSectionTitle('إعدادات التطبيق'),
            _buildSettingsCard([
              _buildSwitchTile(
                title: 'الوضع الليلي',
                subtitle: 'تفعيل المظهر الداكن',
                icon: Icons.dark_mode,
                value: _darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                  _saveSettings();
                },
              ),
              const Divider(height: 1),
              _buildDropdownTile(
                title: 'اللغة',
                subtitle: _selectedLanguage,
                icon: Icons.language,
                items: _languages,
                selectedValue: _selectedLanguage,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value;
                  });
                  _saveSettings();
                },
              ),
              const Divider(height: 1),
              _buildDropdownTile(
                title: 'العملة',
                subtitle: _selectedCurrency,
                icon: Icons.attach_money,
                items: _currencies,
                selectedValue: _selectedCurrency,
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value;
                  });
                  _saveSettings();
                },
              ),
            ]),

            const SizedBox(height: 20),

            // إعدادات الدفع
            _buildSectionTitle('الدفع والفواتير'),
            _buildSettingsCard([
              _buildListTile(
                title: 'طرق الدفع',
                subtitle: 'إدارة البطاقات والمحافظ الرقمية',
                icon: Icons.payment,
                onTap: () => _showPaymentMethods(),
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'تاريخ الفواتير',
                subtitle: 'عرض فواتير الطلبات السابقة',
                icon: Icons.receipt_long,
                onTap: () => _showBillingHistory(),
              ),
            ]),

            const SizedBox(height: 20),

            // المساعدة والدعم
            _buildSectionTitle('المساعدة والدعم'),
            _buildSettingsCard([
              _buildListTile(
                title: 'مركز المساعدة',
                subtitle: 'الأسئلة الشائعة والدعم',
                icon: Icons.help,
                onTap: () => _showHelpCenter(),
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'التواصل معنا',
                subtitle: 'خدمة العملاء والدعم الفني',
                icon: Icons.contact_support,
                onTap: () => _showContactSupport(),
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'تقييم التطبيق',
                subtitle: 'شاركنا رأيك في التطبيق',
                icon: Icons.star_rate,
                onTap: () => _showRateApp(),
              ),
            ]),

            const SizedBox(height: 20),

            // معلومات التطبيق
            _buildSectionTitle('معلومات التطبيق'),
            _buildSettingsCard([
              _buildListTile(
                title: 'الإصدار',
                subtitle: '1.0.0',
                icon: Icons.info,
                onTap: null,
              ),
              const Divider(height: 1),
              _buildListTile(
                title: 'شروط الاستخدام',
                subtitle: 'اطلع على شروط وأحكام الخدمة',
                icon: Icons.description,
                onTap: () => _showTermsOfService(),
              ),
            ]),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, right: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF3B82F6),
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
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
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3B82F6)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF3B82F6),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3B82F6)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle),
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<String> items,
    required String selectedValue,
    required ValueChanged<String> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF3B82F6)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle),
      trailing: DropdownButton<String>(
        value: selectedValue,
        underline: const SizedBox(),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }

  void _showNotificationSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إعدادات الإشعارات'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('يمكنك تخصيص أنواع الإشعارات التي تريد استقبالها:'),
            SizedBox(height: 16),
            Text('• إشعارات الطلبات'),
            Text('• إشعارات العروض والخصومات'),
            Text('• إشعارات التحديثات'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }

  void _showAddressManagement() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إدارة العناوين'),
        content: const Text('يمكنك إضافة وتعديل عناوين التوصيل الخاصة بك من هنا.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إضافة عنوان جديد'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('سياسة الخصوصية'),
        content: const SingleChildScrollView(
          child: Text(
            'نحن نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية. '
            'يتم استخدام بياناتك فقط لتحسين تجربة الاستخدام وتقديم خدمات أفضل.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethods() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('طرق الدفع'),
        content: const Text('يمكنك إدارة بطاقاتك الائتمانية والمحافظ الرقمية من هنا.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إضافة بطاقة جديدة'),
          ),
        ],
      ),
    );
  }

  void _showBillingHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تاريخ الفواتير'),
        content: const Text('يمكنك عرض جميع فواتير طلباتك السابقة من هنا.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }

  void _showHelpCenter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('مركز المساعدة'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الأسئلة الشائعة:'),
            SizedBox(height: 8),
            Text('• كيف أتتبع طلبي؟'),
            Text('• كيف أغير عنوان التوصيل؟'),
            Text('• كيف أستخدم الكوبونات؟'),
            Text('• كيف ألغي طلبي؟'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }

  void _showContactSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('التواصل معنا'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('يمكنك التواصل معنا عبر:'),
            SizedBox(height: 8),
            Text('📞 الهاتف: 920000000'),
            Text('📧 البريد: support@app.com'),
            Text('💬 الدردشة المباشرة'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }

  void _showRateApp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تقييم التطبيق'),
        content: const Text('نسعد بتقييمك للتطبيق ومشاركة تجربتك معنا!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('لاحقاً'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('شكراً لتقييمك!')),
              );
            },
            child: const Text('تقييم الآن'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('شروط الاستخدام'),
        content: const SingleChildScrollView(
          child: Text(
            'شروط وأحكام استخدام التطبيق:\n\n'
            '1. يجب استخدام التطبيق وفقاً للقوانين المحلية\n'
            '2. نحتفظ بحق تعديل الخدمات في أي وقت\n'
            '3. المستخدم مسؤول عن دقة المعلومات المقدمة\n'
            '4. نحن غير مسؤولين عن أي أضرار غير مباشرة',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }
}

