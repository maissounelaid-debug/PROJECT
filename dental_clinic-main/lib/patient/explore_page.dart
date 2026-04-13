import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/neon_panel.dart';
import '../widgets/neon_button.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

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
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Good Morning!',
                          style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
                      const Text('Find Your Care',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.panel.withValues(alpha: 0.5),
                      border: Border.all(
                          color: AppColors.neonCyan.withValues(alpha: 0.35), width: 1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_rounded,
                        color: AppColors.neonCyan),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Search bar
              const NeonPanel(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search services, doctors...',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Banner
              NeonPanel(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Your Dental Health',
                              style: TextStyle(
                                  color: AppColors.textMuted, fontSize: 13)),
                          const SizedBox(height: 4),
                          const Text('Book an Appointment\nToday!',
                              style: TextStyle(
                                  color: AppColors.text,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 160,
                            child: NeonButton(
                              label: 'Book Now',
                              icon: Icons.calendar_today_rounded,
                              onPressed: () {},
                              height: 44,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Text('🦷', style: TextStyle(fontSize: 56)),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Services
              const Text('Our Services',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text)),
              const SizedBox(height: 16),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  _buildServiceCard('Checkup', Icons.search_rounded, const Color(0xFF00897B)),
                  _buildServiceCard('Cleaning', Icons.clean_hands_rounded, const Color(0xFF00ACC1)),
                  _buildServiceCard('X-Ray', Icons.image_rounded, const Color(0xFF26A69A)),
                  _buildServiceCard('Surgery', Icons.medical_services_rounded, const Color(0xFF00695C)),
                ],
              ),

              const SizedBox(height: 24),

              // Doctors
              const Text('Our Doctors',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text)),
              const SizedBox(height: 16),

              _buildDoctorCard('Dr. Ahmed Benali', 'General Dentist', '⭐ 4.9'),
              const SizedBox(height: 12),
              _buildDoctorCard('Dr. Sara Meziane', 'Orthodontist', '⭐ 4.8'),
              const SizedBox(height: 12),
              _buildDoctorCard('Dr. Karim Hadj', 'Oral Surgeon', '⭐ 4.7'),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildServiceCard(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildDoctorCard(String name, String specialty, String rating) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF00897B).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_rounded, color: Color(0xFF00897B)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                Text(specialty,
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          Text(rating, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}