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
    this.description =
    'Satu sistem, semua event terkendali. Dari\nperencanaan hingga laporan, semuanya\njadi lebih cepat dan teratur.',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // === Fixed constants (tidak tergantung layar) ===
    const double headerHeight = 340; // stabil di semua layar
    const EdgeInsets outerPad = EdgeInsets.all(16);
    const double innerPadH = 16;
    const double innerPadV = 16;

    // Typography & sizes
    const double titleFs = 36;   // judul besar
    const double descFs  = 14;   // deskripsi
    const double logoFs  = 12;   // teks di pill
    const double logoSide = 48;  // ukuran logo gambar/icon
    const double pillPadH = 28;  // pill lebih panjang
    const double pillPadV = 4;  // pill lebih tebal

    return Container(
      width: double.infinity,
      height: headerHeight,
      color: Colors.white,
      padding: outerPad,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              if (imagePath != null)
                Positioned.fill(
                  child: Image.asset(imagePath!, fit: BoxFit.cover),
                ),

              // overlay gelap tipis
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.25),
                        Colors.black.withOpacity(0.45),
                      ],
                    ),
                  ),
                ),
              ),

              // Konten kiri-atas (logo pill -> judul -> deskripsi)
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: innerPadH, vertical: innerPadV),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: pillPadH, vertical: pillPadV),
                        decoration: BoxDecoration(
                          color: const Color(0xFFCEE4F2),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: _buildLogoContent(
                          logoSide: logoSide,
                          logoFontSize: logoFs,
                        ),
                      ),

                      SizedBox(height: 15,),

                      _shadowText(title1, titleFs),
                      _shadowText(title2, titleFs),
                      _shadowText(title3, titleFs),
                      SizedBox(height: 15,),

                      // Deskripsi (wrap otomatis)
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: descFs,
                          color: Colors.white,
                          height: 1.35,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.55),
                              blurRadius: 8,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),


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

  Text _shadowText(String s, double fs) {
    return Text(
      s,
      style: TextStyle(
        fontSize: fs,
        fontWeight: FontWeight.w900,
        color: Colors.white,
        height: 1.0,
        letterSpacing: 0.5,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  // TEKS DI BAWAH LOGO (BUKAN DI SAMPING)
  Widget _buildLogoContent({
    required double logoSide,
    required double logoFontSize,
  }) {
    if (useImageLogo && logoImagePath != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              logoImagePath!,
              height: logoSide,
              width: logoSide,
              fit: BoxFit.cover,
            ),
          ),
          if (logoText != null) ...[
            const SizedBox(height: 6),
            Text(
              logoText!,
              style: TextStyle(
                fontSize: logoFontSize,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF000000),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (logoIcon != null)
            Icon(
              logoIcon,
              color: const Color(0xFF0D47A1),
              size: logoSide,
            ),
          if (logoText != null) ...[
            const SizedBox(height: 6),
            Text(
              logoText!,
              style: TextStyle(
                fontSize: logoFontSize,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0D47A1),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      );
    }
  }
}
