import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// -------------------- COLORS --------------------
class AppColors {
  static const primary = Color(0xFF0035FF);
  static const primaryLight = Color(0xFF0050FF); // if you need hover variations
  static const overlayGradientStart = Color.fromRGBO(3, 9, 35, 0.879);
  static const overlayGradient25 = Color.fromRGBO(3, 9, 35, 0.867);
  static const overlayGradient50 = Color.fromRGBO(3, 9, 35, 0.85);
  static const overlayGradient75 = Color.fromRGBO(3, 9, 35, 0.67);
  static const overlayGradientEnd = Color.fromRGBO(3, 9, 35, 0.6);
  static const iconBackground = Color(0xFFE6F0FF);
  static const iconColor = Color(0xFF0035FF);
  static const white = Colors.white;
  static const black = Colors.black;
}

// -------------------- FONT SIZES --------------------
class AppFontSizes {
  // Header / titles
  static const headerDesktop = 46.0;
  static const headerMobile = 26.0;
  static const subtitleDesktop = 20.0;
  static const subtitleMobile = 14.0;
  static const serviceTitleDesktop = 22.0;
  static const serviceTitleMobile = 20.0;
  static const serviceDescriptionmobile = 13.0;
  static const serviceDescriptiondesktop = 15.0;
  static const menuItem = 18.0;
  static const slashdesktop = 25.0;
  static const slashmobile = 18.0;
  static const slashtitledesktop = 22.0;
  static const slashtitlemobile = 16.0;
}

// -------------------- FONT WEIGHTS --------------------
class AppFontWeights {
  static const title = FontWeight.w700;
  static const subtitle = FontWeight.w400;
  static const serviceTitle = FontWeight.w600;
  static const menu = FontWeight.w500;
}

// -------------------- TEXT STYLES --------------------
class AppTextStyles {
  static TextStyle header({bool isMobile = false}) =>
      GoogleFonts.instrumentSans(
        fontSize: isMobile
            ? AppFontSizes.headerMobile
            : AppFontSizes.headerDesktop,
        fontWeight: AppFontWeights.title,
        color: AppColors.white,
        height: 1.2,
      );

  static TextStyle subtitle({bool isMobile = false}) => GoogleFonts.poppins(
    fontSize: isMobile
        ? AppFontSizes.subtitleMobile
        : AppFontSizes.subtitleDesktop,
    fontWeight: AppFontWeights.subtitle,
    color: AppColors.white,
    height: 1.5,
  );

  static TextStyle serviceTitle({bool isMobile = false}) =>
      GoogleFonts.instrumentSans(
        fontSize: isMobile
            ? AppFontSizes.serviceTitleMobile
            : AppFontSizes.serviceTitleDesktop,
        fontWeight: AppFontWeights.serviceTitle,
      );

  static TextStyle slash({bool isMobile = false}) => GoogleFonts.instrumentSans(
    fontSize: isMobile ? AppFontSizes.slashmobile : AppFontSizes.slashdesktop,
    fontWeight: FontWeight.w900,
    color: AppColors.primary,
  );
  static TextStyle slashTitle({bool isMobile = false}) =>
      GoogleFonts.instrumentSans(
        fontSize: isMobile
            ? AppFontSizes.slashtitlemobile
            : AppFontSizes.slashtitledesktop,
        fontWeight: FontWeight.w500,
      );

  static TextStyle servicedescription({bool isMobile = false}) =>
      GoogleFonts.instrumentSans(
        fontSize: isMobile
            ? AppFontSizes.serviceDescriptionmobile
            : AppFontSizes.serviceDescriptiondesktop,
      );
}

// -------------------- PADDINGS / MARGINS --------------------
class AppSpacings {
  static const horizontalPadding = 16.0;
  static const verticalPadding = 16.0;
  static const sectionSpacing = 20.0;
  static const cardPadding = 16.0;
  static const cardHeight = 130.0;
  static const cardBorderRadius = 14.0;
  static const buttonPaddingHorizontal = 25.0;
  static const buttonPaddingVertical = 15.0;
  static const buttonMinWidth = 205.0;
  static const buttonMinHeight = 54.0;
}

// -------------------- OTHER --------------------
class AppSizes {
  static const serviceCardWidth = 370.0;
  static const headerHeight = 810.0;
  static const scrollToTopSize = 30.0;
  static const scrollToTopIconSize = 24.0;
}
