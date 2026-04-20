import 'package:flutter/material.dart';
import 'patient_detail_screen.dart'; // لفتح صفحة التفاصيل
import 'dashboard_screen.dart';       // لاستيراد الألوان

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> patients = [
      {'name': 'Amira Benali', 'init': 'AB', 'color': Colors.purple},
      {'name': 'Youssef Khaldi', 'init': 'YK', 'color': Colors.cyan},
      {'name': 'Sara Meziane', 'init': 'SM', 'color': Colors.teal},
      {'name': 'Ahmed Toumi', 'init': 'AT', 'color': Colors.orange},
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('My Patients', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final p = patients[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: p['color'].withOpacity(0.2),
                child: Text(p['init'], style: TextStyle(color: p['color'], fontWeight: FontWeight.bold)),
              ),
              title: Text(p['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text('Last visit: 12 Apr 2026', style: TextStyle(color: Colors.white54, fontSize: 12)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientDetailScreen(
                      name: p['name'],
                      initials: p['init'],
                      avatarColor: p['color'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}