import 'package:flutter/material.dart';

// --- تعريف الألوان محلياً لضمان عدم وجود أخطاء في الاستدعاء ---
class AppColors {
  static const Color bgDark1 = Color(0xFF0F172A);
  static const Color bgDark2 = Color(0xFF1E293B);
  static const Color panel = Color(0xFF1E293B);
  static const Color text = Colors.white;
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color neonCyan = Color(0xFF22D3EE);
  static const Color neonTeal = Color(0xFF2DD4BF);
  static const Color danger = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  static const Gradient bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
  );
}

class PatientDetailScreen extends StatelessWidget {
  final String name;
  final String initials;
  final Color avatarColor;

  const PatientDetailScreen({
    super.key,
    required this.name,
    required this.initials,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark1,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildPatientHero(),
                    const SizedBox(height: 24),
                    _buildSectionHeader("Quick Info"),
                    const SizedBox(height: 12),
                    _buildInfoGrid(),
                    const SizedBox(height: 24),
                    _buildSectionHeader("Medical History (Timeline)"),
                    const SizedBox(height: 12),
                    _buildMedicalTimeline(),
                    const SizedBox(height: 24),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.text, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          const Text("Patient Profile", style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.w600)),
          const Spacer(),
          IconButton(icon: const Icon(Icons.edit_outlined, color: AppColors.neonCyan), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildPatientHero() {
    return Column(
      children: [
        Container(
          width: 90, height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [avatarColor, avatarColor.withOpacity(0.5)]),
            boxShadow: [BoxShadow(color: avatarColor.withOpacity(0.3), blurRadius: 20, spreadRadius: 2)],
          ),
          child: Center(
            child: Text(initials, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
        const SizedBox(height: 16),
        Text(name, style: const TextStyle(color: AppColors.text, fontSize: 24, fontWeight: FontWeight.bold)),
        const Text("Patient ID: #GT-2026-08", style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
      ],
    );
  }

  Widget _buildInfoGrid() {
    return Row(
      children: [
        Expanded(child: _buildInfoCard("Age", "24", Icons.cake_rounded, AppColors.neonCyan)),
        const SizedBox(width: 12),
        Expanded(child: _buildInfoCard("Blood", "A+", Icons.bloodtype_rounded, AppColors.danger)),
        const SizedBox(width: 12),
        Expanded(child: _buildInfoCard("Weight", "68kg", Icons.monitor_weight_rounded, AppColors.neonTeal)),
      ],
    );
  }

  Widget _buildInfoCard(String title, String val, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 8),
          Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildMedicalTimeline() {
    return Column(
      children: [
        _buildTimelineItem("12 Apr 2026", "Scaling & Polishing", "Completed", AppColors.neonTeal),
        _buildTimelineItem("28 Mar 2026", "Root Canal Therapy", "Follow-up", AppColors.warning),
        _buildTimelineItem("10 Jan 2026", "Initial Consultation", "Completed", AppColors.neonCyan),
      ],
    );
  }

  Widget _buildTimelineItem(String date, String title, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.panel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neonCyan.withOpacity(0.05)),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            width: 4, height: 40,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
          ),
          title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
          subtitle: Text(date, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title, style: const TextStyle(color: AppColors.text, fontSize: 15, fontWeight: FontWeight.bold));
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.neonCyan,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {},
            icon: const Icon(Icons.add_chart_rounded),
            label: const Text("Add Visit", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.panel,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.textMuted.withOpacity(0.2)),
          ),
          child: const Icon(Icons.share_rounded, color: Colors.white, size: 20),
        ),
      ],
    );
  }
}