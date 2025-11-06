import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../text_styles.dart';
import '../utils.dart';

class LoginHeaderWidget extends StatelessWidget {
  final String? imagePath;
  final String? logoImagePath;
  final String? logoText;
  final IconData? logoIcon;
  final bool useImageLogo;
  final String title1;
  final String title2;
  final String title3;
  final String description;

  const LoginHeaderWidget({
    Key? key,
    this.imagePath,
    this.logoImagePath,
    this.logoText,
    this.logoIcon,
    this.useImageLogo = false,
    this.title1 = 'Event',
    this.title2 = 'Management',
    this.title3 = 'System',
    this.description = 'Satu sistem, semua event terkendali. Dari\nperencanaan hingga laporan, semuanya\njadi lebih cepat dan teratur.',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final headerHeight = screenHeight * 0.40;
    final titleFontSize = screenWidth * 0.105;
    final descFontSize = screenWidth * 0.032;
    final logoFontSize = screenWidth * 0.022;
    
    return Container(
      width: double.infinity,
      height: headerHeight,
      color: Colors.white,
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              if (imagePath != null)
                Positioned.fill(
                  child: Image.asset(
                    imagePath!,
                    fit: BoxFit.cover,
                  ),
                ),
              
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
              ),
              
              Positioned(
                left: screenWidth * 0.04,
                top: screenHeight * 0.025,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.08, 
                    vertical: screenHeight * 0.008,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFCEE4F2), 
                    borderRadius: BorderRadius.circular(35), 
                  ),
                  child: _buildLogoContent(screenWidth, logoFontSize),
                ),  
              ),
              
              Positioned(
                left: screenWidth * 0.06,
                right: screenWidth * 0.06,
                bottom: screenHeight * 0.04,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title1,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      title2,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      title3,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: 0.5,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.012),
                    
                    // Description
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: descFontSize,
                        color: Colors.white,
                        height: 1.4,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 8,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoContent(double screenWidth, double logoFontSize) {
    if (useImageLogo && logoImagePath != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              logoImagePath!,
              height: screenWidth * 0.07,
              width: screenWidth * 0.07,
              fit: BoxFit.cover,
            ),
          ),
          if (logoText != null) ...[
            SizedBox(height: screenWidth * 0.01),
            Text(
              logoText!,
              style: TextStyle(
                fontSize: logoFontSize,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (logoIcon != null)
            Icon(
              logoIcon,
              color: Color(0xFF0D47A1),
              size: screenWidth * 0.07,
            ),
          if (logoText != null && logoIcon != null)
            SizedBox(height: screenWidth * 0.005),
          if (logoText != null)
            Text(
              logoText!,
              style: TextStyle(
                fontSize: logoFontSize,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0D47A1),
              ),
              textAlign: TextAlign.center,
            ),
        ],
      );
    }
  }
}