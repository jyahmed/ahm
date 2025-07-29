import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Order> currentOrders = [
    Order(
      id: '12345',
      restaurantName: 'برجر كينج',
      items: ['بيج ماك', 'بطاطس مقلية', 'كوكا كولا'],
      total: 45.0,
      status: OrderStatus.preparing,
      orderTime: DateTime.now().subtract(const Duration(minutes: 15)),
      estimatedDelivery: DateTime.now().add(const Duration(minutes: 20)),
    ),
    Order(
      id: '12346',
      restaurantName: 'ستاربكس',
      items: ['لاتيه', 'كرواسان'],
      total: 28.0,
      status: OrderStatus.onTheWay,
      orderTime: DateTime.now().subtract(const Duration(minutes: 30)),
      estimatedDelivery: DateTime.now().add(const Duration(minutes: 5)),
    ),
  ];

  final List<Order> pastOrders = [
    Order(
      id: '12340',
      restaurantName: 'بيتزا هت',
      items: ['بيتزا مارجريتا', 'أجنحة دجاج'],
      total: 65.0,
      status: OrderStatus.delivered,
      orderTime: DateTime.now().subtract(const Duration(days: 1)),
      estimatedDelivery: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Order(
      id: '12341',
      restaurantName: 'كنتاكي',
      items: ['وجبة زنجر', 'بطاطس', 'بيبسي'],
      total: 38.0,
      status: OrderStatus.delivered,
      orderTime: DateTime.now().subtract(const Duration(days: 3)),
      estimatedDelivery: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلباتي'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'الطلبات الحالية'),
            Tab(text: 'الطلبات السابقة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(currentOrders, true),
          _buildOrdersList(pastOrders, false),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Order> orders, bool isCurrent) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isCurrent ? Icons.receipt_long_outlined : Icons.history,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              isCurrent ? 'لا توجد طلبات حالية' : 'لا توجد طلبات سابقة',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isCurrent 
                  ? 'اطلب الآن واستمتع بوجبتك المفضلة'
                  : 'ستظهر طلباتك المكتملة هنا',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order, isCurrent);
      },
    );
  }

  Widget _buildOrderCard(Order order, bool isCurrent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // رأس الطلب
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'طلب #${order.id}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(order.status),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // اسم المطعم
            Text(
              order.restaurantName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B82F6),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // العناصر
            Text(
              order.items.join(' • '),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // المعلومات السفلية
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'وقت الطلب',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(order.orderTime),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'المجموع',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${order.total.toStringAsFixed(0)} ر.س',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF3B82F6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            if (isCurrent && order.status != OrderStatus.delivered) ...[
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الوصول المتوقع: ${DateFormat('HH:mm').format(order.estimatedDelivery)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _showTrackingDialog(order);
                    },
                    child: const Text('تتبع الطلب'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case OrderStatus.preparing:
        color = Colors.orange;
        text = 'قيد التحضير';
        break;
      case OrderStatus.onTheWay:
        color = Colors.blue;
        text = 'في الطريق';
        break;
      case OrderStatus.delivered:
        color = Colors.green;
        text = 'تم التوصيل';
        break;
      case OrderStatus.cancelled:
        color = Colors.red;
        text = 'ملغي';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showTrackingDialog(Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تتبع الطلب #${order.id}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTrackingStep('تم استلام الطلب', true),
            _buildTrackingStep('قيد التحضير', order.status.index >= 0),
            _buildTrackingStep('في الطريق', order.status.index >= 1),
            _buildTrackingStep('تم التوصيل', order.status.index >= 2),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingStep(String title, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: isCompleted ? Colors.black : Colors.grey,
              fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class Order {
  final String id;
  final String restaurantName;
  final List<String> items;
  final double total;
  final OrderStatus status;
  final DateTime orderTime;
  final DateTime estimatedDelivery;

  Order({
    required this.id,
    required this.restaurantName,
    required this.items,
    required this.total,
    required this.status,
    required this.orderTime,
    required this.estimatedDelivery,
  });
}

enum OrderStatus {
  preparing,
  onTheWay,
  delivered,
  cancelled,
}

