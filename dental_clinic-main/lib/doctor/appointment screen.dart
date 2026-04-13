import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/neon_panel.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Appointment Requests',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.text)),
                const Text('Manage your patient bookings',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
                
                const SizedBox(height: 25),

                // قسم الطلبات الجديدة (Pending)
                _buildSectionHeader("Pending Requests", Icons.pending_actions_rounded),
                const SizedBox(height: 12),
                _buildRequestCard(
                  name: "ADDAL MERIEM", 
                  type: "General Checkup", 
                  time: "10:30 AM", 
                  date: "Tomorrow",
                  isPending: true
                ),

                const SizedBox(height: 30),

                // قسم المواعيد المؤكدة (Confirmed)
                _buildSectionHeader("Confirmed Today", Icons.check_circle_outline_rounded),
                const SizedBox(height: 12),
                _buildRequestCard(
                  name: "Ahmed Rouai", 
                  type: "Teeth Cleaning", 
                  time: "02:00 PM", 
                  date: "Today",
                  isPending: false
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.neonCyan, size: 20),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildRequestCard({
    required String name, 
    required String type, 
    required String time, 
    required String date,
    required bool isPending
  }) {
    return NeonPanel(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.panel2,
                child: const Icon(Icons.person, color: AppColors.neonCyan),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
                    Text('$type • $date', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                  ],
                ),
              ),
              Text(time, style: const TextStyle(color: AppColors.neonCyan, fontWeight: FontWeight.bold)),
            ],
          ),
          if (isPending) ...[
            const SizedBox(height: 16),
            const Divider(color: AppColors.stroke, height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.redAccent),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Reject", style: TextStyle(color: Colors.redAccent)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.neonTeal,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Accept", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}