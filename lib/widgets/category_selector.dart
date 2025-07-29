import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final int? selectedCategory;
  final Function(int?) onSelectCategory;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onSelectCategory,
  });

  final List<Map<String, dynamic>> categories = const [
    {'id': 0, 'name': 'الكل', 'icon': Icons.restaurant},
    {'id': 1, 'name': 'برجر', 'icon': Icons.lunch_dining},
    {'id': 2, 'name': 'بيتزا', 'icon': Icons.local_pizza},
    {'id': 3, 'name': 'دجاج', 'icon': Icons.set_meal},
    {'id': 4, 'name': 'قهوة', 'icon': Icons.coffee},
    {'id': 5, 'name': 'حلويات', 'icon': Icons.cake},
    {'id': 6, 'name': 'صحي', 'icon': Icons.eco},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الفئات',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category['id'];
              
              return GestureDetector(
                onTap: () {
                  if (category['id'] == 0) {
                    onSelectCategory(null);
                  } else {
                    onSelectCategory(category['id']);
                  }
                },
                child: Container(
                  width: 70,
                  margin: const EdgeInsets.only(left: 12),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? const Color(0xFF3B82F6) 
                              : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected 
                                ? const Color(0xFF3B82F6) 
                                : Colors.grey[300]!,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          category['icon'],
                          color: isSelected ? Colors.white : Colors.grey[600],
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected 
                              ? FontWeight.bold 
                              : FontWeight.normal,
                          color: isSelected 
                              ? const Color(0xFF3B82F6) 
                              : Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

