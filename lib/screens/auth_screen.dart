import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();
  
  // Login controllers
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  
  // Register controllers
  final _registerNameController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();
  final _registerConfirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscureLoginPassword = true;
  bool _obscureRegisterPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'تسجيل الدخول'),
            Tab(text: 'إنشاء حساب'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLoginForm(),
          _buildRegisterForm(),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            
            // شعار التطبيق
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.delivery_dining,
                size: 50,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 32),
            
            const Text(
              'مرحباً بعودتك!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'سجل دخولك للمتابعة',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),
            
            // حقل البريد الإلكتروني
            TextFormField(
              controller: _loginEmailController,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                if (!value.contains('@')) {
                  return 'يرجى إدخال بريد إلكتروني صحيح';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // حقل كلمة المرور
            TextFormField(
              controller: _loginPasswordController,
              obscureText: _obscureLoginPassword,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureLoginPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureLoginPassword = !_obscureLoginPassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال كلمة المرور';
                }
                if (value.length < 6) {
                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 8),
            
            // نسيت كلمة المرور
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  _showForgotPasswordDialog();
                },
                child: const Text('نسيت كلمة المرور؟'),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // زر تسجيل الدخول
            ElevatedButton(
              onPressed: _isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            
            const Text(
              'إنشاء حساب جديد',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'انضم إلينا واستمتع بالتوصيل السريع',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),
            
            // حقل الاسم
            TextFormField(
              controller: _registerNameController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'الاسم الكامل',
                prefixIcon: const Icon(Icons.person_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال الاسم';
                }
                if (value.length < 2) {
                  return 'الاسم يجب أن يكون حرفين على الأقل';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // حقل البريد الإلكتروني
            TextFormField(
              controller: _registerEmailController,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                if (!value.contains('@')) {
                  return 'يرجى إدخال بريد إلكتروني صحيح';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // حقل كلمة المرور
            TextFormField(
              controller: _registerPasswordController,
              obscureText: _obscureRegisterPassword,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureRegisterPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureRegisterPassword = !_obscureRegisterPassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال كلمة المرور';
                }
                if (value.length < 6) {
                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // حقل تأكيد كلمة المرور
            TextFormField(
              controller: _registerConfirmPasswordController,
              obscureText: _obscureConfirmPassword,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'تأكيد كلمة المرور',
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى تأكيد كلمة المرور';
                }
                if (value != _registerPasswordController.text) {
                  return 'كلمة المرور غير متطابقة';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 24),
            
            // زر إنشاء الحساب
            ElevatedButton(
              onPressed: _isLoading ? null : _handleRegister,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'إنشاء الحساب',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            
            const SizedBox(height: 16),
            
            // شروط الاستخدام
            Text(
              'بإنشاء حساب، أنت توافق على شروط الاستخدام وسياسة الخصوصية',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
        _loginEmailController.text.trim(),
        _loginPasswordController.text,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تسجيل الدخول بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleRegister() async {
    if (!_registerFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<AuthProvider>(context, listen: false).register(
        _registerNameController.text.trim(),
        _registerEmailController.text.trim(),
        _registerPasswordController.text,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إنشاء الحساب بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('نسيت كلمة المرور؟'),
        content: const Text('سيتم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إرسال رابط إعادة التعيين'),
                ),
              );
            },
            child: const Text('إرسال'),
          ),
        ],
      ),
    );
  }
}

