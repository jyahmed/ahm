import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userToken;
  String? _userName;
  String? _userEmail;

  bool get isAuthenticated => _isAuthenticated;
  String? get userToken => _userToken;
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  Future<void> login(String email, String password) async {
    try {
      // هنا يمكن إضافة منطق تسجيل الدخول الفعلي
      // مؤقتاً سنقوم بمحاكاة تسجيل دخول ناجح
      
      _isAuthenticated = true;
      _userToken = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
      _userEmail = email;
      _userName = 'المستخدم'; // يمكن الحصول عليه من الخادم
      
      // حفظ بيانات المستخدم محلياً
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('userToken', _userToken!);
      await prefs.setString('userEmail', _userEmail!);
      await prefs.setString('userName', _userName!);
      
      notifyListeners();
    } catch (error) {
      throw Exception('فشل في تسجيل الدخول: $error');
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      // هنا يمكن إضافة منطق التسجيل الفعلي
      // مؤقتاً سنقوم بمحاكاة تسجيل ناجح
      
      _isAuthenticated = true;
      _userToken = 'dummy_token_${DateTime.now().millisecondsSinceEpoch}';
      _userEmail = email;
      _userName = name;
      
      // حفظ بيانات المستخدم محلياً
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('userToken', _userToken!);
      await prefs.setString('userEmail', _userEmail!);
      await prefs.setString('userName', _userName!);
      
      notifyListeners();
    } catch (error) {
      throw Exception('فشل في إنشاء الحساب: $error');
    }
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _userToken = null;
    _userName = null;
    _userEmail = null;
    
    // حذف بيانات المستخدم المحفوظة محلياً
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    
    notifyListeners();
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    
    if (!prefs.containsKey('isAuthenticated')) {
      return;
    }
    
    _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    _userToken = prefs.getString('userToken');
    _userEmail = prefs.getString('userEmail');
    _userName = prefs.getString('userName');
    
    if (_isAuthenticated) {
      notifyListeners();
    }
  }
}

