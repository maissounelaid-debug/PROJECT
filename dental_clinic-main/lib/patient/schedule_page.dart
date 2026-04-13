import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/neon_panel.dart';
import '../widgets/neon_button.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedMonth = DateTime(2026, 3);
  DateTime? _selectedDate;

  final List<Map<String, dynamic>> _appointments = [
    {
      'date': DateTime(2026, 3, 17),
      'doctor': 'Dr. Ahmed Benali',
      'type': 'General Checkup',
      'time': '10:00 AM',
      'status': 'confirmed',
      'color': const Color(0xFF00897B),
    },
    {
      'date': DateTime(2026, 3, 21),
      'doctor': 'Dr. Sara Meziane',
      'type': 'Teeth Cleaning',
      'time': '2:00 PM',
      'status': 'pending',
      'color': const Color(0xFF00ACC1),
    },
    {
      'date': DateTime(2026, 3, 25),
      'doctor': 'Dr. Karim Hadj',
      'type': 'X-Ray',
      'time': '11:00 AM',
      'status': 'pending',
      'color': const Color(0xFF26A69A),
    },
    {
      'date': DateTime(2026, 4, 3),
      'doctor': 'Dr. Ahmed Benali',
      'type': 'Follow-up',
      'time': '9:00 AM',
      'status': 'confirmed',
      'color': const Color(0xFF00897B),
    },
  ];

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<Map<String, dynamic>> _getAppointmentsForDate(DateTime date) {
    return _appointments
        .where((a) => _isSameDay(a['date'] as DateTime, date))
        .toList();
  }

  List<Map<String, dynamic>> _getAppointmentsForMonth(DateTime month) {
    return _appointments
        .where((a) {
          final d = a['date'] as DateTime;
          return d.year == month.year && d.month == month.month;
        })
        .toList();
  }

  void _prevMonth() => setState(() =>
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1));

  void _nextMonth() => setState(() =>
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1));

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final selectedAppointments = _selectedDate != null
        ? _getAppointmentsForDate(_selectedDate!)
        : _getAppointmentsForMonth(_focusedMonth);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Schedule',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        Text('Manage your appointments',
                            style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
                      ],
                    ),
                    SizedBox(
                      width: 120,
                      child: NeonButton(
                        label: 'Book',
                        icon: Icons.add_rounded,
                        height: 44,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Calendar Card
              NeonPanel(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    // Month navigation
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _prevMonth,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0FFF8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.chevron_left_rounded,
                                  color: Color(0xFF00897B), size: 20),
                            ),
                          ),
                          Text(
                            '${_monthName(_focusedMonth.month)} ${_focusedMonth.year}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: _nextMonth,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0FFF8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.chevron_right_rounded,
                                  color: Color(0xFF00897B), size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Day headers
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                            .map((d) => SizedBox(
                                  width: 36,
                                  child: Center(
                                    child: Text(d,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Days grid
                    _buildDaysGrid(),

                    const SizedBox(height: 6),

                    // Stats row
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                      child: Row(
                        children: [
                          _buildMiniStat('Upcoming', '2', const Color(0xFF00897B)),
                          const SizedBox(width: 8),
                          _buildMiniStat('Pending', '1', const Color(0xFF00ACC1)),
                          const SizedBox(width: 8),
                          _buildMiniStat('Done', '5', Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Appointments title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate != null
                          ? '${_selectedDate!.day} ${_monthName(_selectedDate!.month)}'
                          : '${_monthName(_focusedMonth.month)} Appointments',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E)),
                    ),
                    if (_selectedDate != null)
                      GestureDetector(
                        onTap: () => setState(() => _selectedDate = null),
                        child: const Text('Show all',
                            style: TextStyle(
                                color: Color(0xFF00897B),
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Appointments list
              selectedAppointments.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(Icons.calendar_today_rounded,
                              size: 48, color: Colors.grey.withValues(alpha: 0.4)),
                          const SizedBox(height: 10),
                          const Text('No appointments',
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00897B),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('Book Now'),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: selectedAppointments.length,
                      itemBuilder: (context, index) {
                        return _buildAppointmentCard(
                            selectedAppointments[index]);
                      },
                    ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildDaysGrid() {
    final firstDay = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final daysInMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;
    final startWeekday = firstDay.weekday % 7;
    final today = DateTime.now();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 2.0,
        ),
        itemCount: startWeekday + daysInMonth,
        itemBuilder: (context, index) {
          if (index < startWeekday) return const SizedBox();
          final day = index - startWeekday + 1;
          final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
          final dayAppointments = _getAppointmentsForDate(date);
          final isToday = _isSameDay(date, today);
          final isSelected =
              _selectedDate != null && _isSameDay(date, _selectedDate!);
          final hasAppointment = dayAppointments.isNotEmpty;

          return GestureDetector(
            onTap: () => setState(() {
              _selectedDate = isSelected ? null : date;
            }),
            child: Container(
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: isToday
                    ? const Color(0xFF00897B)
                    : isSelected
                        ? const Color(0xFF00897B).withValues(alpha: 0.12)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: hasAppointment || isToday
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isToday
                          ? Colors.white
                          : isSelected
                              ? const Color(0xFF00897B)
                              : Colors.black87,
                    ),
                  ),
                  if (hasAppointment && !isToday)
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: dayAppointments[0]['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> apt) {
    final color = apt['color'] as Color;
    final status = apt['status'] as String;
    final date = apt['date'] as DateTime;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)
        ],
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.medical_services_rounded, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(apt['doctor'] as String,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(apt['type'] as String,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded, size: 12, color: color),
                    const SizedBox(width: 4),
                    Text(
                      '${apt['time']}  •  ${date.day} ${_monthName(date.month)}',
                      style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status[0].toUpperCase() + status.substring(1),
                  style: TextStyle(
                      color: color, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {},
                child: const Text('Cancel',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(count,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
