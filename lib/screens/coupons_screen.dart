import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Coupon> availableCoupons = [
    Coupon(
      id: 'WELCOME20',
      title: 'خصم ترحيبي',
      description: 'خصم 20% على طلبك الأول',
      discount: 20,
      discountType: DiscountType.percentage,
      minOrderAmount: 50,
      expiryDate: DateTime.now().add(const Duration(days: 30)),
      isUsed: false,
    ),
    Coupon(
      id: 'SAVE15',
      title: 'وفر 15 ريال',
      description: 'خصم 15 ريال على الطلبات أكثر من 100 ريال',
      discount: 15,
      discountType: DiscountType.fixed,
      minOrderAmount: 100,
      expiryDate: DateTime.now().add(const Duration(days: 15)),
      isUsed: false,
    ),
    Coupon(
      id: 'DELIVERY',
      title: 'توصيل مجاني',
      description: 'توصيل مجاني على جميع الطلبات',
      discount: 0,
      discountType: DiscountType.freeDelivery,
      minOrderAmount: 30,
      expiryDate: DateTime.now().add(const Duration(days: 7)),
      isUsed: false,
    ),
  ];

  final List<Coupon> usedCoupons = [
    Coupon(
      id: 'FIRST10',
      title: 'خصم أول طلب',
      description: 'خصم 10% على أول طلب',
      discount: 10,
      discountType: DiscountType.percentage,
      minOrderAmount: 25,
      expiryDate: DateTime.now().subtract(const Duration(days: 5)),
      isUsed: true,
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
        title: const Text('الكوبونات'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'الكوبونات المتاحة'),
            Tab(text: 'الكوبونات المستخدمة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCouponsList(availableCoupons, false),
          _buildCouponsList(usedCoupons, true),
        ],
      ),
    );
  }

  Widget _buildCouponsList(List<Coupon> coupons, bool isUsed) {
    if (coupons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isUsed ? Icons.history : Icons.local_offer_outlined,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              isUsed ? 'لا توجد كوبونات مستخدمة' : 'لا توجد كوبونات متاحة',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isUsed 
                  ? 'ستظهر الكوبونات المستخدمة هنا'
                  : 'تحقق لاحقاً للحصول على عروض جديدة',
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
      itemCount: coupons.length,
      itemBuilder: (context, index) {
        final coupon = coupons[index];
        return _buildCouponCard(coupon);
      },
    );
  }

  Widget _buildCouponCard(Coupon coupon) {
    final isExpired = coupon.expiryDate.isBefore(DateTime.now());
    final isUsable = !coupon.isUsed && !isExpired;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: isUsable
            ? const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [Colors.grey[300]!, Colors.grey[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // نمط الخلفية
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // رأس الكوبون
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coupon.title,
                            style: TextStyle(
                              color: isUsable ? Colors.white : Colors.grey[600],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            coupon.description,
                            style: TextStyle(
                              color: isUsable ? Colors.white70 : Colors.grey[500],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // قيمة الخصم
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getDiscountText(coupon),
                        style: TextStyle(
                          color: isUsable ? const Color(0xFF3B82F6) : Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // معلومات إضافية
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الحد الأدنى: ${coupon.minOrderAmount.toStringAsFixed(0)} ر.س',
                      style: TextStyle(
                        color: isUsable ? Colors.white70 : Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'ينتهي: ${_formatDate(coupon.expiryDate)}',
                      style: TextStyle(
                        color: isUsable ? Colors.white70 : Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // كود الكوبون وزر النسخ
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        coupon.id,
                        style: TextStyle(
                          color: isUsable ? Colors.white : Colors.grey[600],
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      
                      if (isUsable)
                        GestureDetector(
                          onTap: () => _copyCouponCode(coupon.id),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.copy,
                                  size: 16,
                                  color: Color(0xFF3B82F6),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'نسخ',
                                  style: TextStyle(
                                    color: Color(0xFF3B82F6),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
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
          ),
          
          // شارة الحالة
          if (coupon.isUsed)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'مستخدم',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else if (isExpired)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'منتهي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getDiscountText(Coupon coupon) {
    switch (coupon.discountType) {
      case DiscountType.percentage:
        return '${coupon.discount.toStringAsFixed(0)}%';
      case DiscountType.fixed:
        return '${coupon.discount.toStringAsFixed(0)} ر.س';
      case DiscountType.freeDelivery:
        return 'توصيل مجاني';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _copyCouponCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم نسخ الكود: $code'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class Coupon {
  final String id;
  final String title;
  final String description;
  final double discount;
  final DiscountType discountType;
  final double minOrderAmount;
  final DateTime expiryDate;
  final bool isUsed;

  Coupon({
    required this.id,
    required this.title,
    required this.description,
    required this.discount,
    required this.discountType,
    required this.minOrderAmount,
    required this.expiryDate,
    required this.isUsed,
  });
}

enum DiscountType {
  percentage,
  fixed,
  freeDelivery,
}

