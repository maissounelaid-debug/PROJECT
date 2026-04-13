import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/neon_panel.dart';
import 'patient_detail_screen.dart'; // هذا السطر هو مفتاح الربط

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  // قائمة المرضى (بيانات تجريبية)
  final List<Map<String, String>> patients = [
    {"name": "Addal Meriem", "age": "22", "lastVisit": "2026-03-12", "id": "GT-88"},
    {"name": "Ahmed Rouai", "age": "30", "lastVisit": "2026-04-01", "id": "GT-92"},
    {"name": "Lydia Mansouri", "age": "25", "lastVisit": "2026-02-15", "id": "GT-45"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text("My Patients", 
                  style: TextStyle(color: AppColors.text, fontSize: 26, fontWeight: FontWeight.bold)),
                const Text("Manage patient records and history", 
                  style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                
                const SizedBox(height: 20),

                // شريط البحث بستايل نيومورفيزم
                TextField(
                  style: const TextStyle(color: AppColors.text),
                  decoration: InputDecoration(
                    hintText: "Search by name...",
                    hintStyle: const TextStyle(color: AppColors.textMuted),
                    prefixIcon: const Icon(Icons.search, color: AppColors.neonCyan),
                    filled: true,
                    fillColor: AppColors.panel,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: AppColors.stroke),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: AppColors.stroke),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // عرض القائمة
                Expanded(
                  child: ListView.builder(
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: _buildPatientCard(patients[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPatientCard(Map<String, String> patient) {
    return NeonPanel(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.panel2,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.neonCyan.withOpacity(0.3)),
          ),
          child: const Icon(Icons.person, color: AppColors.neonCyan),
        ),
        title: Text(patient['name']!, 
          style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
        subtitle: Text("ID: ${patient['id']} • Age: ${patient['age']}", 
          style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.neonCyan, size: 14),
        
        // هنا سحر الربط
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDetailScreen(patientName: patient['name']!),
            ),
          );
        },
      ),
    );
  }
}