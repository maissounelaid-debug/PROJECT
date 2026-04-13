import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeonPanel extends StatelessWidget {
  const NeonPanel({
    super.key,
    required this.child,
    this.margin,
    this.borderRadius = 22,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final EdgeInsets? margin;
  final double borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.panel.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.neonCyan.withValues(alpha: 0.55), width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonCyan.withValues(alpha: 0.22),
            blurRadius: 22,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.55),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

