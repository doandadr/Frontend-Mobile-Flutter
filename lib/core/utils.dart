import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  // Spacing constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 12.0;
  static const double spacingL = 16.0;
  static const double spacingXL = 20.0;
  static const double spacingXXL = 24.0;
  static const double spacing3XL = 30.0;
  
  // Border Radius constants
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  
  // Icon sizes
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;
  
  // Elevation constants
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  
  // Animation durations
  static const Duration durationShort = Duration(milliseconds: 200);
  static const Duration durationMedium = Duration(milliseconds: 300);
  static const Duration durationLong = Duration(milliseconds: 500);
  
  // Helper method untuk membuat shadow
  static BoxShadow createShadow({
    double opacity = 0.1,
    double blurRadius = 8.0,
    Offset offset = const Offset(0, 2),
  }) {
    return BoxShadow(
      color: Colors.black.withOpacity(opacity),
      blurRadius: blurRadius,
      offset: offset,
    );
  }
  
  // Helper method untuk membuat gradient overlay
  static Gradient createOverlayGradient({
    double topOpacity = 0.4,
    double bottomOpacity = 0.2,
  }) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black.withOpacity(topOpacity),
        Colors.black.withOpacity(bottomOpacity),
      ],
    );
  }
  
  // Screen size helpers
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }
  
  // Validation helpers
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    
    return null;
  }
  
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    return null;
  }
  
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  // Util converter untuk format:
  // - ISO: 2025-10-31T08:59:06.000000Z
  // - Non-ISO: 2025-11-08 20:09:39
  static DateTime? toDateTimeFlexible(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final iso = DateTime.tryParse(raw);
    if (iso != null) return iso;
    return DateTime.tryParse(raw.replaceFirst(' ', 'T'));
  }

  String? fromDateTimeIso(DateTime? dt) => dt?.toIso8601String();

  static DateTime dateTimeParse(String raw) {
    // Parsing "2025-10-31 03:01:28" dan ISO "2025-10-31T03:01:28Z"
    return DateTime.tryParse(raw) ??
        DateTime.parse(raw.replaceFirst(' ', 'T'));
  }

  static Future<void> openUrl(String? url) async {
    if (kDebugMode) {
      print('Opening URL: $url');
    }
    if (url == null || url.isEmpty) return;

    final uri = Uri.parse(url);

    if (!await canLaunchUrl(uri)) return;

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static DateTime? parseDate(dynamic date) {
    if (date == null) return null;
    if (date is DateTime) return date;
    if (date is String) {
      try {
        return DateTime.parse(date);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

}