import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/admin/admin_sidebar.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'الكل';
  
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '#12345',
      'customer': 'أحمد محمد',
      'restaurant': 'مطعم الشام',
      'items': ['شاورما لحم', 'فلافل', 'عصير برتقال'],
      'total': '85.50',
      'status': 'تم التوصيل',
      'orderTime': '2024-01-15 14:30',
      'deliveryTime': '2024-01-15 15:15',
      'address': 'الرياض، حي النخيل، شارع الملك فهد',
      'phone': '+966501234567',
      'paymentMethod': 'بطاقة ائتمان',
    },
    {
      'id': '#12344',
      'customer': 'فاطمة علي',
      'restaurant': 'بيتزا هت',
      'items': ['بيتزا مارجريتا كبيرة', 'أجنحة دجاج', 'كوكاكولا'],
      'total': '120.00',
      'status': 'في الطريق',
      'orderTime': '2024-01-15 13:45',
      'deliveryTime': null,
      'address': 'الرياض، حي العليا، شارع التحلية',
      'phone': '+966507654321',
      'paymentMethod': 'نقداً عند التوصيل',
    },
    {
      'id': '#12343',
      'customer': 'محمد سالم',
      'restaurant': 'كنتاكي',
      'items': ['وجبة زنجر', 'بطاطس مقلية', 'بيبسي'],
      'total': '95.75',
      'status': 'قيد التجهيز',
      'orderTime': '2024-01-15 13:20',
      'deliveryTime': null,
      'address': 'الرياض، حي الملز، شارع الأمير محمد بن عبدالعزيز',
      'phone': '+966509876543',
      'paymentMethod': 'بطاقة ائتمان',
    },
    {
      'id': '#12342',
      'customer': 'سارة أحمد',
      'restaurant': 'ماكدونالدز',
      'items': ['بيج ماك', 'بطاطس كبيرة', 'شيك فانيلا'],
      'total': '67.25',
      'status': 'قيد الانتظار',
      'orderTime': '2024-01-15 13:10',
      'deliveryTime': null,
      'address': 'الرياض، حي السليمانية، شارع العروبة',
      'phone': '+966502468135',
      'paymentMethod': 'محفظة رقمية',
    },
    {
      'id': '#12341',
      'customer': 'عبدالله خالد',
      'restaurant': 'مطعم البيك',
      'items': ['برجر دجاج', 'بطاطس', 'عصير تفاح'],
      'total': '45.00',
      'status': 'ملغى',
      'orderTime': '2024-01-15 12:50',
      'deliveryTime': null,
      'address': 'الرياض، حي الورود، شارع الأمير سلطان',
      'phone': '+966508642097',
      'paymentMethod': 'نقداً عند التوصيل',
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
                        Expanded(child: _buildOrdersList()),
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
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'إدارة الطلبات',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          // إحصائيات سريعة
          _buildQuickStat('إجمالي الطلبات', '1,247', AppColors.primary),
          const SizedBox(width: 24),
          _buildQuickStat('طلبات اليوم', '156', AppColors.success),
          const SizedBox(width: 24),
          _buildQuickStat('قيد التجهيز', '23', AppColors.warning),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
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
              hintText: 'البحث برقم الطلب أو اسم العميل...',
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
            items: ['الكل', 'قيد الانتظار', 'قيد التجهيز', 'في الطريق', 'تم التوصيل', 'ملغى']
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
        
        // فلتر التاريخ
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButton<String>(
            value: 'اليوم',
            underline: const SizedBox(),
            items: ['اليوم', 'أمس', 'آخر 7 أيام', 'آخر 30 يوم']
                .map((period) => DropdownMenuItem(
                      value: period,
                      child: Text(period),
                    ))
                .toList(),
            onChanged: (value) {
              // تطبيق فلتر التاريخ
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersList() {
    final filteredOrders = _orders.where((order) {
      final matchesSearch = order['id']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          order['customer']
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      
      final matchesFilter = _selectedFilter == 'الكل' || 
          order['status'] == _selectedFilter;
      
      return matchesSearch && matchesFilter;
    }).toList();

    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(filteredOrders[index]);
      },
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          // رأس البطاقة
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                // رقم الطلب
                Text(
                  order['id'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                
                const Spacer(),
                
                // حالة الطلب
                _buildStatusChip(order['status']),
                
                const SizedBox(width: 16),
                
                // إجمالي المبلغ
                Text(
                  '${order['total']} ر.س',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
          
          // محتوى البطاقة
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // معلومات العميل والمطعم
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'العميل',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order['customer'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order['phone'],
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'المطعم',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order['restaurant'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'وقت الطلب',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order['orderTime'],
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // العنوان
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        order['address'],
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // المنتجات
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'المنتجات المطلوبة:',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...order['items'].map<Widget>((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // طريقة الدفع والإجراءات
                Row(
                  children: [
                    // طريقة الدفع
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.payment,
                            size: 16,
                            color: AppColors.info,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            order['paymentMethod'],
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.info,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // أزرار الإجراءات
                    if (order['status'] == 'قيد الانتظار') ...[
                      ElevatedButton(
                        onPressed: () => _updateOrderStatus(order['id'], 'قيد التجهيز'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.warning,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text('قبول الطلب'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () => _updateOrderStatus(order['id'], 'ملغى'),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.error),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: Text(
                          'إلغاء',
                          style: TextStyle(color: AppColors.error),
                        ),
                      ),
                    ] else if (order['status'] == 'قيد التجهيز') ...[
                      ElevatedButton(
                        onPressed: () => _updateOrderStatus(order['id'], 'في الطريق'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.info,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text('إرسال للتوصيل'),
                      ),
                    ] else if (order['status'] == 'في الطريق') ...[
                      ElevatedButton(
                        onPressed: () => _updateOrderStatus(order['id'], 'تم التوصيل'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text('تأكيد التوصيل'),
                      ),
                    ],
                    
                    const SizedBox(width: 8),
                    
                    IconButton(
                      onPressed: () => _showOrderDetails(order),
                      icon: Icon(
                        Icons.visibility_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
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
      case 'قيد الانتظار':
        color = AppColors.warning;
        break;
      case 'قيد التجهيز':
        color = AppColors.info;
        break;
      case 'في الطريق':
        color = AppColors.primary;
        break;
      case 'تم التوصيل':
        color = AppColors.success;
        break;
      case 'ملغى':
        color = AppColors.error;
        break;
      default:
        color = AppColors.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _updateOrderStatus(String orderId, String newStatus) {
    setState(() {
      final orderIndex = _orders.indexWhere((order) => order['id'] == orderId);
      if (orderIndex != -1) {
        _orders[orderIndex]['status'] = newStatus;
        if (newStatus == 'تم التوصيل') {
          _orders[orderIndex]['deliveryTime'] = DateTime.now().toString();
        }
      }
    });
    
    // إظهار رسالة تأكيد
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم تحديث حالة الطلب $orderId إلى $newStatus'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    // تنفيذ عرض تفاصيل الطلب
  }
}

