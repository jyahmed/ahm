import 'package:flutter/material.dart';
import 'package:home_to_door_shopping_flutter/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/category_selector.dart';
import '../widgets/cart_button.dart';
import '../widgets/hero_section.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/quick_actions.dart';
import '../models/restaurant.dart';
import '../providers/cart_provider.dart';
import '../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int? selectedCategory;
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Restaurant> dummyRestaurants = [
    Restaurant(
      id: 1,
      name: 'برجر كينج',
      image: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGJ1cmdlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=600&q=60',
      rating: 4.8,
      deliveryTime: '25-35 دقيقة',
      deliveryFee: '5 ر.س',
      categories: ['برجر', 'وجبات سريعة'],
      isNew: true,
    ),
    Restaurant(
      id: 2,
      name: 'بيتزا هت',
      image: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGl6emF8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60',
      rating: 4.5,
      deliveryTime: '20-30 دقيقة',
      deliveryFee: '8 ر.س',
      categories: ['بيتزا', 'إيطالي'],
      isFavorite: true,
    ),
    Restaurant(
      id: 3,
      name: 'كنتاكي',
      image: 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZnJpZWQlMjBjaGlja2VufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
      rating: 4.2,
      deliveryTime: '30-40 دقيقة',
      deliveryFee: '7 ر.س',
      categories: ['دجاج', 'وجبات سريعة'],
    ),
    Restaurant(
      id: 4,
      name: 'صبواي',
      image: 'https://images.unsplash.com/photo-1509722747041-616f39b57569?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2FuZHdpY2h8ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60',
      rating: 4.0,
      deliveryTime: '15-25 دقيقة',
      deliveryFee: '4 ر.س',
      categories: ['سندويتشات', 'صحي'],
    ),
    Restaurant(
      id: 5,
      name: 'ستاربكس',
      image: 'https://images.unsplash.com/photo-1504753793650-d4a2b783c15e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y29mZmVlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60',
      rating: 4.7,
      deliveryTime: '10-20 دقيقة',
      deliveryFee: '9 ر.س',
      categories: ['قهوة', 'مشروبات'],
      isNew: true,
    ),
    Restaurant(
      id: 6,
      name: 'البيك',
      image: 'https://images.unsplash.com/photo-1632778149955-e80f8ceca2e8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fGNoaWNrZW58ZW58MHx8MHx8&auto=format&fit=crop&w=600&q=60',
      rating: 4.9,
      deliveryTime: '25-40 دقيقة',
      deliveryFee: '6 ر.س',
      categories: ['دجاج', 'وجبات سريعة'],
      isFavorite: true,
    ),
  ];

  List<Restaurant> get filteredRestaurants {
    return dummyRestaurants.where((restaurant) {
      final matchesSearch = restaurant.name.contains(searchQuery);
      final matchesCategory = selectedCategory == null || 
          restaurant.categories.any((cat) => cat.contains(_getCategoryName(selectedCategory!)));
      return matchesSearch && matchesCategory;
    }).toList();
  }

  String _getCategoryName(int categoryId) {
    const categories = ['', 'برجر', 'بيتزا', 'دجاج', 'قهوة', 'حلويات', 'صحي'];
    return categoryId < categories.length ? categories[categoryId] : '';
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                       context,
                        MaterialPageRoute(
                       builder: (context) => const SettingsScreen(),
                     ),
                    );
            }
      ),]
      ),
// Widget build(BuildContext context) {
//     return ChangeNotifierProvider<DashboardData>(
//       create: (BuildContext context) => DashboardData(),
//       builder: (BuildContext context, Widget? child) {
//         return MaterialApp(
//           title: 'Application Dashboard',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             visualDensity: VisualDensity.adaptivePlatformDensity,
//           ),
//           home: const DashboardScreen(),
//         );
//       },
//     );
  // }
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            slivers: [
              // App Bar مخصص
              
             
              SliverAppBar(
                expandedHeight: 120,
                floating: true,
                pinned: false,
                backgroundColor: AppColors.primary,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          Text(
                            'مرحباً بك!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'ماذا تريد أن تطلب اليوم؟',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // المحتوى الرئيسي
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // قسم البحث والإجراءات السريعة
                    Container(
                      color: AppColors.primary,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // شريط البحث
                              SearchBarWidget(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                  });
                                },
                              ),
                              
                              const SizedBox(height: 24),
                              
                              // الإجراءات السريعة
                              const QuickActions(),
                              
                              const SizedBox(height: 24),
                              
                              // الفئات
                              CategorySelector(
                                selectedCategory: selectedCategory,
                                onSelectCategory: (category) {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // قسم المطاعم
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // عنوان القسم
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                ),
                                label: const Text('عرض المزيد'),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                ),
                              ),
                              Text(
                                'المطاعم والمتاجر',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // شبكة المطاعم
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: filteredRestaurants.isEmpty
                                ? _buildEmptyState()
                                : _buildRestaurantGrid(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const CartButton(),
    );
  }

  Widget _buildRestaurantGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredRestaurants.length,
      itemBuilder: (context, index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300 + (index * 100)),
          curve: Curves.easeOutBack,
          child: RestaurantCard(
            restaurant: filteredRestaurants[index],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            'لم نجد نتائج',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'جرب البحث بكلمات مختلفة أو تصفح الفئات',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

