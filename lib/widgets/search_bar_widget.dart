import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? hintText;
  final bool enabled;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText,
    this.enabled = true,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _isFocused 
                      ? AppColors.primary.withOpacity(0.2)
                      : AppColors.shadowLight,
                  blurRadius: _isFocused ? 12 : 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: widget.controller,
              enabled: widget.enabled,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'ابحث عن مطعم أو متجر...',
                hintStyle: TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: 16,
                ),
                prefixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.search,
                    color: _isFocused ? AppColors.primary : AppColors.textSecondary,
                    size: 24,
                  ),
                ),
                suffixIcon: widget.controller.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          widget.controller.clear();
                          widget.onChanged('');
                        },
                        icon: Icon(
                          Icons.clear,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              onChanged: (value) {
                widget.onChanged(value);
                setState(() {});
              },
              onTap: () {
                setState(() {
                  _isFocused = true;
                });
                _animationController.forward();
              },
              onTapOutside: (event) {
                setState(() {
                  _isFocused = false;
                });
                _animationController.reverse();
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        );
      },
    );
  }
}

