import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DoctorHome extends StatelessWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Doctor',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Dashboard (coming next)',
                  style: TextStyle(color: AppColors.textMuted),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.panel.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                        color: AppColors.neonCyan.withValues(alpha: 0.4), width: 1),
                  ),
                  child: const Text(
                    'هنا سنضيف: قائمة المرضى + طلبات المواعيد (قبول/رفض) + dossier medical.',
                    style: TextStyle(height: 1.35),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

