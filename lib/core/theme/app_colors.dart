import 'package:flutter/material.dart';

class AppColors {
  // Ana renkler
  static const primary = Color(0xFF6366F1);
  static const accent = Color(0xFF818CF8);
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);

  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const warningGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const errorGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const purpleGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Status renkleri
  static const statusDraft = Color(0xFF94A3B8);
  static const statusActive = Color(0xFF3B82F6);
  static const statusPending = Color(0xFFF59E0B);
  static const statusCompleted = Color(0xFF10B981);
  static const statusCancelled = Color(0xFFEF4444);

  // Dark tema
  static const darkBg = Color(0xFF0F172A);
  static const darkCard = Color(0xFF1E293B);
  static const darkBorder = Color(0xFF334155);

  // Light tema
  static const lightBg = Color(0xFFF8FAFC);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightBorder = Color(0xFFE2E8F0);
}
