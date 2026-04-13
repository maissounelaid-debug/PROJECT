import 'package:flutter/material.dart';
import '../theme/app_colors.dart'; // تأكدي من المسار حسب صورتك
import '../widgets/neon_panel.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Doctor Dashboard", 
                  style: TextStyle(color: AppColors.text, fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Welcome back, Dr. Benali", 
                  style: TextStyle(color: AppColors.textMuted, fontSize: 16)),
                
                const SizedBox(height: 30),
                
                // لوحة إحصائيات سريعة
                NeonPanel(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat("Patients", "24"),
                      _buildStat("Appointments", "8"),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                const Text("Recent Requests", 
                  style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold)),
                
                // هنا سنضيف لاحقاً قائمة المواعيد (قبول/رفض)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String title, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: AppColors.neonCyan, fontSize: 24, fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
      ],
    );
  }
}