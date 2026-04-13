import 'package:flutter/material.dart';

void main() => runApp(const GoTuApp());

class GoTuApp extends StatelessWidget {
  const GoTuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
      ),
      // الشاشة الأولى التي تظهر عند فتح التطبيق
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // ألوان التطبيق بناءً على معاينة الواجهة التي أرفقتها
  static const Color primaryColor = Color(0xFF00D4C8);
  static const Color bgColor = Color(0xFF0D2B35);
  static const Color surfaceColor = Color(0xFF1A3A45);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              // الشعار (Logo) - يمثل عيادة الأسنان
              const Icon(Icons.medical_services_outlined, size: 80, color: primaryColor),
              const SizedBox(height: 20),
              const Text(
                "Dental Clinic",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const Text(
                "Login to your workspace",
                style: TextStyle(color: Color(0xFF8AACB8), fontSize: 14),
              ),
              const SizedBox(height: 60),
              
              // حقل الإدخال للإيميل
              _buildInput(Icons.email_outlined, "Email Address"),
              const SizedBox(height: 20),
              
              // حقل الإدخال لكلمة السر
              _buildInput(Icons.lock_outline, "Password", isPassword: true),
              
              const SizedBox(height: 40),
              
              // زر تسجيل الدخول
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // هنا سنضع لاحقاً الكود الذي ينقلك للواجهة الرئيسية (Dashboard)
                    print("Login Pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: bgColor, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(IconData icon, String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: primaryColor),
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF8AACB8)),
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}