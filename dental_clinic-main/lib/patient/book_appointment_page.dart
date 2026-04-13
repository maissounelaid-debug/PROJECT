
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BookAppointmentPage extends StatefulWidget {
  final String? preselectedDoctor;
  const BookAppointmentPage({super.key, this.preselectedDoctor});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  late String? _selectedDoctor;
  String? _selectedType;
  DateTime? _selectedDate;
  String? _selectedTime;

  final _doctors = [
    'Dr. Ahmed Benali', 'Dr. Sara Meziane', 'Dr. Karim Hadj',
  ];
  final _types = [
    'General Checkup', 'Teeth Cleaning', 'X-Ray',
    'Surgery Consultation', 'Follow-up',
  ];
  final _times = [
    '09:00 AM', '10:00 AM', '11:00 AM',
    '01:00 PM', '02:00 PM', '03:00 PM', '04:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDoctor = widget.preselectedDoctor;
  }

  bool get _canConfirm =>
      _selectedDoctor != null && _selectedType != null &&
      _selectedDate != null && _selectedTime != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text('Book Appointment'),
  backgroundColor: Colors.transparent,
  elevation: 0,
),
body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Column(
            children: [
            
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Select Doctor'),
                      const SizedBox(height: 10),
                      ..._doctors.map(_doctorTile),

                      const SizedBox(height: 22),
                      _label('Appointment Type'),
                      const SizedBox(height: 10),
                      Wrap(spacing: 8, runSpacing: 8,
                          children: _types.map((t) =>
                              _chip(t, _selectedType == t,
                                  () => setState(() => _selectedType = t))
                          ).toList()),

                      const SizedBox(height: 22),
                      _label('Select Date'),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          final d = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now()
                                .add(const Duration(days: 1)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now()
                                .add(const Duration(days: 60)),
                          );
                          if (d != null) setState(() => _selectedDate = d);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: AppColors.cardDecoration,
                          child: Row(children: [
                            const Icon(Icons.calendar_today_rounded,
                                color: AppColors.neonCyan),
                            const SizedBox(width: 12),
                            Text(
                              _selectedDate == null ? 'Pick a date'
                                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                              style: TextStyle(
                                color: _selectedDate == null
                                    ? AppColors.textMuted : AppColors.text,
                                fontSize: 15,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                size: 14, color: AppColors.textMuted),
                          ]),
                        ),
                      ),

                      const SizedBox(height: 22),
                      _label('Select Time'),
                      const SizedBox(height: 10),
                      Wrap(spacing: 8, runSpacing: 8,
                          children: _times.map((t) =>
                              _chip(t, _selectedTime == t,
                                  () => setState(() => _selectedTime = t))
                          ).toList()),

                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity, height: 54,
                        child: ElevatedButton(
                          onPressed: _canConfirm ? _showConfirm : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.neonTeal,
                            foregroundColor: Colors.black,
                            disabledBackgroundColor: AppColors.stroke,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text('Confirm Appointment',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirm() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppColors.panel,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.neonTeal.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    color: AppColors.neonTeal, size: 52),
              ),
              const SizedBox(height: 16),
              const Text('Request Sent!',
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold, color: AppColors.text)),
              const SizedBox(height: 8),
              const Text(
                'Your appointment request has been sent.\nWaiting for doctor confirmation.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.panel2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(children: [
                  _confirmRow('Doctor', _selectedDoctor!),
                  _confirmRow('Type', _selectedType!),
                  _confirmRow('Date',
                      '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                  _confirmRow('Time', _selectedTime!),
                ]),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.neonTeal,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Back to Home',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _confirmRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Text('$label: ', style: const TextStyle(
            color: AppColors.textMuted, fontSize: 13)),
        Text(value, style: const TextStyle(
            color: AppColors.text,
            fontWeight: FontWeight.w600, fontSize: 13)),
      ]),
    );
  }

  Widget _doctorTile(String name) {
    final sel = _selectedDoctor == name;
    return GestureDetector(
      onTap: () => setState(() => _selectedDoctor = name),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: sel ? AppColors.neonTeal.withValues(alpha: 0.1) : AppColors.panel,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: sel ? AppColors.neonTeal : AppColors.stroke,
            width: sel ? 1.5 : 0.8,
          ),
        ),
        child: Row(children: [
          Icon(Icons.person_rounded,
              color: sel ? AppColors.neonTeal : AppColors.textMuted),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: TextStyle(
              color: sel ? AppColors.neonTeal : AppColors.text,
              fontWeight: sel ? FontWeight.bold : FontWeight.normal))),
          if (sel) const Icon(Icons.check_circle_rounded,
              color: AppColors.neonTeal, size: 18),
        ]),
      ),
    );
  }

  Widget _chip(String label, bool sel, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: sel ? AppColors.neonTeal.withValues(alpha: 0.12) : AppColors.panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: sel ? AppColors.neonTeal : AppColors.stroke),
        ),
        child: Text(label, style: TextStyle(
            color: sel ? AppColors.neonTeal : AppColors.textMuted,
            fontSize: 13,
            fontWeight: sel ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }

  Widget _label(String t) => Text(t, style: const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.text));
}