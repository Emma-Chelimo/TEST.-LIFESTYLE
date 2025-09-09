import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlutterFlowTheme {
  final BuildContext context;

  FlutterFlowTheme(this.context);

  static FlutterFlowTheme of(BuildContext context) => FlutterFlowTheme(context);

  Color get primary => const Color(0xFFB8172D);
  Color get primaryBackground => Colors.white;
  Color get secondaryBackground => const Color(0xFFF6F1F3);
  Color get primaryText => Colors.black;
  Color get richBlackFOGRA39 => const Color(0xFF21005D);
  Color get secondaryText => const Color(0xFF6B7280);
  Color get alternate => const Color(0xFFBF5AF2);
  Color get error => const Color(0xFFE11D48);
  Color get cerise => const Color(0xFFEF39AA);
  Color get secondary => const Color(0xFFB8172D);
  Color get info => Colors.white;

  TextStyle get headlineMedium => GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: primary,
      );

  TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: primaryText,
      );

  // Add more getters as needed

  static ThemeData get themeData => ThemeData(
        primaryColor: const Color(0xFFB8172D),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFB8172D),
        ),
      );

  static TextStyle get staticheadlineMedium => GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFB8172D),
      );

  static TextStyle get staticbodyMedium => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      );

  // Add more styles as needed
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    Color? color,
    double? fontSize,
    double? letterSpacing,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    TextStyle merged = this;
    if (font != null) {
      merged = font.merge(this);
    }
    return merged.copyWith(
      color: color ?? merged.color,
      fontSize: fontSize ?? merged.fontSize,
      letterSpacing: letterSpacing ?? merged.letterSpacing,
      fontWeight: fontWeight ?? merged.fontWeight,
      fontStyle: fontStyle ?? merged.fontStyle,
    );
  }
}
