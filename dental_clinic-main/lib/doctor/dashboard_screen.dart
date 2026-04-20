import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── الألوان المعتمدة (AppColors) ──────────────────────────────────────────────
class AppColors {
  static const Color bgDark1 = Color(0xFF0F172A);
  static const Color bgDark2 = Color(0xFF1E293B);
  static const Color panel = Color(0xFF1E293B);
  static const Color panel2 = Color(0xFF0F172A);
  static const Color neonCyan = Color(0xFF22D3EE);
  static const Color neonTeal = Color(0xFF2DD4BF);
  static const Color text = Colors.white;
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color danger = Color(0xFFF87171);
  static const Color warning = Color(0xFFFB923C);

  static const Gradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F172A), Color(0xFF020617)],
  );

  static const Gradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
  );
}

// ── كود الشاشة الرئيسي ──────────────────────────────────────────────────────
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedDay = 4;

  final List<Map<String, String>> _days = [
    {'label': 'Mon', 'num': '14'},
    {'label': 'Tue', 'num': '15'},
    {'label': 'Wed', 'num': '16'},
    {'label': 'Thu', 'num': '17'},
    {'label': 'Sun', 'num': '19'},
    {'label': 'Mon', 'num': '20'},
    {'label': 'Tue', 'num': '21'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark1,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildHero(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildStatsGrid(),
                    const SizedBox(height: 20),
                    _buildQuickActions(),
                    const SizedBox(height: 20),
                    _buildScheduleSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── HERO SECTION ──
  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: const BoxDecoration(
        gradient: AppColors.heroGradient,
        border: Border(bottom: BorderSide(color: Color(0xFF112240), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Good morning,', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  SizedBox(height: 2),
                  Text('Dr. Sadik Bessou', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.text)),
                ],
              ),
              const Spacer(),
              _buildNotifButton(),
            ],
          ),
          const SizedBox(height: 14),
          _buildFakeSearchBar(),
          const SizedBox(height: 12),
          _buildDateStrip(),
        ],
      ),
    );
  }

  Widget _buildNotifButton() {
    return Stack(
      children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: AppColors.neonCyan.withOpacity(0.08), shape: BoxShape.circle),
          child: const Icon(Icons.notifications_outlined, color: AppColors.neonCyan, size: 20),
        ),
        Positioned(right: 6, top: 6, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle))),
      ],
    );
  }

  Widget _buildFakeSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.bgDark2.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neonCyan.withOpacity(0.12)),
      ),
      child: Row(
        children: const [
          Icon(Icons.search_rounded, color: AppColors.textMuted, size: 16),
          SizedBox(width: 8),
          Text('Search patients, appointments...', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildDateStrip() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, i) {
          final isActive = _selectedDay == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedDay = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isActive ? AppColors.neonCyan.withOpacity(0.12) : AppColors.neonCyan.withOpacity(0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isActive ? AppColors.neonCyan.withOpacity(0.45) : AppColors.neonCyan.withOpacity(0.1)),
              ),
              child: Center(
                child: Text('${_days[i]['label']} ${_days[i]['num']}', 
                style: TextStyle(fontSize: 10, color: isActive ? AppColors.neonCyan : AppColors.textMuted, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── STATS GRID ──
  Widget _buildStatsGrid() {
    return Row(
      children: [
        _buildStatCard("128", "Total Patients", Icons.people_rounded, AppColors.neonCyan),
        const SizedBox(width: 10),
        _buildStatCard("12", "Today's Visits", Icons.calendar_today_rounded, AppColors.neonTeal),
      ],
    );
  }

  Widget _buildStatCard(String val, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: AppColors.panel, borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 10),
            Text(val, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  // ── QUICK ACTIONS ──
  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Quick actions", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionBtn(Icons.person_add, "Add\nPatient", AppColors.neonCyan),
            _buildActionBtn(Icons.calendar_month, "New\nAppt", AppColors.neonTeal),
            _buildActionBtn(Icons.note_add, "New\nRecord", const Color(0xFFA382FF)),
            _buildActionBtn(Icons.bar_chart, "Reports", AppColors.danger),
          ],
        ),
      ],
    );
  }

  Widget _buildActionBtn(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 55, height: 55,
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.2))),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
      ],
    );
  }

  // ── SCHEDULE ──
  Widget _buildScheduleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Today's schedule", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        _buildAptCard("Amira Benali", "09:30 AM", "Cleaning", AppColors.neonTeal),
        _buildAptCard("Youssef Khaldi", "11:00 AM", "Extraction", Colors.orangeAccent),
      ],
    );
  }

  Widget _buildAptCard(String name, String time, String type, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.panel, borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.1))),
      child: Row(
        children: [
          Container(width: 45, height: 45, decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle), child: Center(child: Text(name[0], style: TextStyle(color: color, fontWeight: FontWeight.bold)))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text(type, style: const TextStyle(color: AppColors.textMuted, fontSize: 12))])),
          Text(time, style: TextStyle(color: AppColors.neonCyan, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}