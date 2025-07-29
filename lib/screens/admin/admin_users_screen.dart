import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/admin/admin_sidebar.dart';

class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'الكل';
  
  final List<Map<String, dynamic>> _users = [
    {
      'id': '1',
      'name': 'أحمد محمد',
      'email': 'ahmed@example.com',
      'phone': '+966501234567',
      'joinDate': '2024-01-15',
      'status': 'نشط',
      'ordersCount': 25,
      'totalSpent': '1,250.00',
    },
    {
      'id': '2',
      'name': 'فاطمة علي',
      'email': 'fatima@example.com',
      'phone': '+966507654321',
      'joinDate': '2024-02-20',
      'status': 'نشط',
      'ordersCount': 18,
      'totalSpent': '890.50',
    },
    {
      'id': '3',
      'name': 'محمد سالم',
      'email': 'mohammed@example.com',
      'phone': '+966509876543',
      'joinDate': '2024-01-08',
      'status': 'معلق',
      'ordersCount': 12,
      'totalSpent': '675.25',
    },
    {
      'id': '4',
      'name': 'سارة أحمد',
      'email': 'sara@example.com',
      'phone': '+966502468135',
      'joinDate': '2024-03-10',
      'status': 'نشط',
      'ordersCount': 8,
      'totalSpent': '420.75',
    },
    {
      'id': '5',
      'name': 'عبدالله خالد',
      'email': 'abdullah@example.com',
      'phone': '+966508642097',
      'joinDate': '2024-02-05',
      'status': 'محظور',
      'ordersCount': 3,
      'totalSpent': '150.00',
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
                        Expanded(child: _buildUsersTable()),
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
            'إدارة المستخدمين',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {
              _showAddUserDialog();
            },
            icon: const Icon(Icons.add),
            label: const Text('إضافة مستخدم'),
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
              hintText: 'البحث عن مستخدم...',
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
            items: ['الكل', 'نشط', 'معلق', 'محظور']
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
      ],
    );
  }

  Widget _buildUsersTable() {
    final filteredUsers = _users.where((user) {
      final matchesSearch = user['name']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          user['email']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      
      final matchesFilter = _selectedFilter == 'الكل' || 
          user['status'] == _selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();

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
        children: [
          // رأس الجدول
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                _buildTableHeader('الاسم', flex: 2),
                _buildTableHeader('البريد الإلكتروني', flex: 2),
                _buildTableHeader('رقم الهاتف', flex: 2),
                _buildTableHeader('تاريخ التسجيل', flex: 1),
                _buildTableHeader('الحالة', flex: 1),
                _buildTableHeader('عدد الطلبات', flex: 1),
                _buildTableHeader('إجمالي الإنفاق', flex: 1),
                _buildTableHeader('الإجراءات', flex: 1),
              ],
            ),
          ),
          
          // محتوى الجدول
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return _buildUserRow(filteredUsers[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String title, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildUserRow(Map<String, dynamic> user, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // الاسم
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    user['name'][0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  user['name'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          
          // البريد الإلكتروني
          Expanded(
            flex: 2,
            child: Text(
              user['email'],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          
          // رقم الهاتف
          Expanded(
            flex: 2,
            child: Text(
              user['phone'],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          
          // تاريخ التسجيل
          Expanded(
            flex: 1,
            child: Text(
              user['joinDate'],
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          
          // الحالة
          Expanded(
            flex: 1,
            child: _buildStatusChip(user['status']),
          ),
          
          // عدد الطلبات
          Expanded(
            flex: 1,
            child: Text(
              user['ordersCount'].toString(),
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          
          // إجمالي الإنفاق
          Expanded(
            flex: 1,
            child: Text(
              '${user['totalSpent']} ر.س',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            ),
          ),
          
          // الإجراءات
          Expanded(
            flex: 1,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _showUserDetails(user),
                  icon: Icon(
                    Icons.visibility_outlined,
                    color: AppColors.info,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () => _showEditUserDialog(user),
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.warning,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () => _showDeleteUserDialog(user),
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.error,
                    size: 20,
                  ),
                ),
              ],
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
      case 'محظور':
        color = AppColors.error;
        break;
      default:
        color = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showAddUserDialog() {
    // تنفيذ حوار إضافة مستخدم جديد
  }

  void _showUserDetails(Map<String, dynamic> user) {
    // تنفيذ عرض تفاصيل المستخدم
  }

  void _showEditUserDialog(Map<String, dynamic> user) {
    // تنفيذ حوار تعديل المستخدم
  }

  void _showDeleteUserDialog(Map<String, dynamic> user) {
    // تنفيذ حوار حذف المستخدم
  }
}

