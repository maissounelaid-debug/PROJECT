import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/neon_panel.dart';

class PatientDetailScreen extends StatelessWidget {
  final String patientName;

  const PatientDetailScreen({super.key, required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(patientName, style: const TextStyle(color: AppColors.text)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.neonCyan),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // بطاقة معلومات المريض الشخصية
                _buildInfoSection(),
                
                const SizedBox(height: 25),
                
                // قسم التاريخ الطبي (Medical History)
                _buildSectionTitle("Medical History"),
                const SizedBox(height: 10),
                NeonPanel(
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    "• No known allergies.\n• Previous root canal on tooth #14.\n• Regular smoker.",
                    style: TextStyle(color: AppColors.textMuted, height: 1.5),
                  ),
                ),

                const SizedBox(height: 25),

                // قسم المرفقات والأشعة (X-Rays / Documents)
                _buildSectionTitle("Files & X-Rays"),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildFileThumbnail(Icons.image_outlined, "X-Ray_Upper.jpg"),
                    const SizedBox(width: 15),
                    _buildFileThumbnail(Icons.picture_as_pdf_outlined, "Lab_Results.pdf"),
                  ],
                ),

                const SizedBox(height: 25),

                // قسم الوصفات الطبية السابقة (Prescriptions)
                _buildSectionTitle("Past Prescriptions"),
                const SizedBox(height: 10),
                _buildPrescriptionItem("Amoxicillin 500mg", "2026-03-12"),
                _buildPrescriptionItem("Paracetamol 1g", "2026-03-12"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, 
      style: const TextStyle(color: AppColors.neonCyan, fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildInfoSection() {
    return NeonPanel(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.panel2,
            child: Icon(Icons.person, size: 35, color: AppColors.neonCyan),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("ID: #GT-2026-88", style: TextStyle(color: AppColors.neonTeal, fontSize: 12)),
              Text("Blood Type: O+", style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
              Text("Last Visit: 2 weeks ago", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFileThumbnail(IconData icon, String label) {
    return Column(
      children: [
        NeonPanel(
          padding: const EdgeInsets.all(20),
          child: Icon(icon, color: AppColors.text, size: 30),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
      ],
    );
  }

  Widget _buildPrescriptionItem(String med, String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: NeonPanel(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(med, style: const TextStyle(color: AppColors.text)),
            Text(date, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}