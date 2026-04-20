
import 'package:flutter/material.dart';

class AppColors {
  static const Color bg0    = Color(0xFF0A0F1E);
  static const Color bg1    = Color(0xFF0E1730);
  static const Color panel  = Color(0xFF0F1A33);
  static const Color panel2 = Color(0xFF0D162D);

  static const Color neonCyan = Color(0xFF2EF3FF);
  static const Color neonTeal = Color(0xFF10D7C8);
  static const Color tealDeep = Color(0xFF0A7E8D);

  static const Color text      = Color(0xFFEAF2FF);
  static const Color textMuted = Color(0xFFA7B4D3);
  static const Color stroke    = Color(0xFF1A2A44);
  
static const Color bgDark1 = Color(0xFF060E1E);
static const Color bgDark2 = Color(0xFF0A1628);
static const Color warning = Color(0xFFF4A261);
static const Color danger  = Color(0xFFFF4D6A);

static const LinearGradient heroGradient = LinearGradient(
  colors: [Color(0xFF021B3A), Color(0xFF041228)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [bg0, bg1],
  );

  static  LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [neonTeal, tealDeep],
  );

  static BoxDecoration get cardDecoration => BoxDecoration(
    color: panel.withValues(alpha: 0.85),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: neonCyan.withValues(alpha: 0.18), width: 0.8),
  );


 static const LinearGradient registerBgGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color.fromARGB(255, 27, 38, 69), Color.fromARGB(255, 27, 40, 71)], 
);

}