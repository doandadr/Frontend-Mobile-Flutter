// lib/modules/participant/activity/scan/scan_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:frontend_mobile_flutter/data/models/event/presence.dart';
import 'package:frontend_mobile_flutter/modules/participant/activity/activity_controller.dart';
import '../../../../data/models/event/scan_response.dart';
import '../../../main_container/main_controller.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with WidgetsBindingObserver {
  final ActivityController c = Get.find<ActivityController>();

  final MobileScannerController _scanner = MobileScannerController(
    facing: CameraFacing.back,
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
    autoZoom: true,
  );

  late final MainController _main;
  late final Worker _watchIndex; // listener reaktif untuk currentIndex

  bool _handled = false;

  // State hasil
  bool? _lastOk;                 // true/false/null
  String? _feedbackTitle;        // "Berhasil Absen" / "Sudah Absen" / "Gagal Absen" / dll
  String? _feedbackSubtitle;     // pesan dari API

  // Payload terakhir untuk ditampilkan sebagai QR di kotak
  String? _lastCode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _main = Get.find<MainController>();

    // Sinkron awal sesuai tab aktif saat ini
    _applyIndex(_main.currentIndex.value);

    // start/stop kamera SEGERA saat user ganti tab
    _watchIndex = ever<int>(_main.currentIndex, (i) => _applyIndex(i));
  }

  Future<void> _applyIndex(int i) async {
    if (i == 2) {
      // Tab Presensi aktif → hidupkan kamera
      try { await _scanner.start(); } catch (_) {}
    } else {
      // Bukan tab Presensi → matikan kamera (hindari buffer penuh)
      try { await _scanner.stop(); } catch (_) {}
      // Reset state scan agar bersih saat kembali
      _handled = false;
      _lastOk = null;
      _feedbackTitle = null;
      _feedbackSubtitle = null;
      _lastCode = null;
      if (mounted) setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Aman saat app background/foreground
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      try { _scanner.stop(); } catch (_) {}
    } else if (state == AppLifecycleState.resumed) {
      _applyIndex(_main.currentIndex.value);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _watchIndex.dispose(); // hentikan listener reaktif
    _scanner.dispose();
    super.dispose();
  }

  String _titleFrom(bool ok, String message) {
    final m = message.toLowerCase();
    if (!ok && m.contains('sudah')) return 'Sudah Absen';
    if (!ok && m.contains('belum dibuka')) return 'Presensi belum dibuka';
    return ok ? 'Berhasil Absen' : 'Gagal Absen';
  }

  Color _titleColor(bool? ok) {
    if (ok == null) return Colors.white;
    return ok ? const Color(0xFF049E67) : const Color(0xFFB42318);
  }

  Color _panelBg(bool? ok) {
    if (ok == null) return Colors.white24;
    return ok ? const Color(0xFFEFFFF9) : const Color(0xFFFFF1F0);
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handled) return;

    final code = capture.barcodes.first.rawValue;
    if (code == null || code.isEmpty) return;

    setState(() {
      _handled = true;
      _lastCode = code; // simpan payload untuk dirender sebagai QR
    });
    await _scanner.stop();

    final payload = Presence(kode: code);

    try {
      final ScanResponse res = await c.submitPresence(payload);
      final ok = res.status;
      final msg = res.message.isNotEmpty
          ? res.message
          : (ok ? 'Presensi berhasil' : 'Presensi gagal');

      setState(() {
        _lastOk = ok;
        _feedbackTitle = _titleFrom(ok, msg);
        _feedbackSubtitle = msg;
      });

      if (ok) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) Get.back(result: ok);
        });
      }
    } catch (e) {
      setState(() {
        _lastOk = false;
        _feedbackTitle = 'Gagal Absen';
        _feedbackSubtitle = 'Gagal memproses: $e';
      });
    }
  }

  Future<void> _restartScan() async {
    setState(() {
      _handled = false;
      _lastOk = null;
      _feedbackTitle = null;
      _feedbackSubtitle = null;
      _lastCode = null;
    });
    try {
      await _scanner.start();
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF0E3977);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Presensi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _scanner.toggleTorch(),
            tooltip: 'Senter',
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => _scanner.switchCamera(),
            tooltip: 'Ganti kamera',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Preview kamera
          MobileScanner(
            controller: _scanner,
            onDetect: _onDetect,
          ),

          // Judul di atas kotak
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'SCAN Barcode',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: navy,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Scan Barcode sebagai daftar hadir:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: navy,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Kotak target + (preview QR dari payload) + panel hasil + tombol ulang
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Kotak target
                SizedBox(
                  width: 260,
                  height: 260,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF0E3977),
                            width: 2,
                          ),
                        ),
                      ),

                      // Jika sudah kebaca, render QR dari payload
                      if (_lastCode != null)
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: QrImageView(
                              data: _lastCode!,
                              size: 200,
                              gapless: true,
                            ),
                          ),
                        ),

                      // corner guides
                      _CornerGuide.topLeft(),
                      _CornerGuide.topRight(),
                      _CornerGuide.bottomLeft(),
                      _CornerGuide.bottomRight(),
                    ],
                  ),
                ),

                // Panel hasil
                if (_feedbackTitle != null) ...[
                  const SizedBox(height: 18),
                  Container(
                    width: 260,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: _panelBg(_lastOk),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          _feedbackTitle!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: _titleColor(_lastOk),
                          ),
                        ),
                        if (_feedbackSubtitle != null && _feedbackSubtitle!.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            _feedbackSubtitle!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: _titleColor(_lastOk),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: _restartScan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF175FA4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text(
                    'Ulang Scan',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget helper untuk garis sudut kotak
class _CornerGuide extends StatelessWidget {
  final Alignment alignment;
  const _CornerGuide._(this.alignment);

  factory _CornerGuide.topLeft() => const _CornerGuide._(Alignment.topLeft);
  factory _CornerGuide.topRight() => const _CornerGuide._(Alignment.topRight);
  factory _CornerGuide.bottomLeft() => const _CornerGuide._(Alignment.bottomLeft);
  factory _CornerGuide.bottomRight() => const _CornerGuide._(Alignment.bottomRight);

  @override
  Widget build(BuildContext context) {
    const guideLen = 26.0;
    const guideThick = 4.0;
    const guideColor = Color(0xFF0E3977);

    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          width: guideLen,
          height: guideLen,
          child: Stack(
            children: [
              // garis horizontal
              Positioned(
                left: 0,
                right: alignment == Alignment.topLeft || alignment == Alignment.bottomLeft ? null : 0,
                top: alignment == Alignment.topLeft || alignment == Alignment.topRight ? 0 : null,
                bottom: alignment == Alignment.bottomLeft || alignment == Alignment.bottomRight ? 0 : null,
                child: Container(
                  width: guideLen,
                  height: guideThick,
                  color: guideColor,
                ),
              ),
              // garis vertikal
              Positioned(
                top: 0,
                bottom: alignment == Alignment.topLeft || alignment == Alignment.topRight ? null : 0,
                left: alignment == Alignment.topLeft || alignment == Alignment.bottomLeft ? 0 : null,
                right: alignment == Alignment.topRight || alignment == Alignment.bottomRight ? 0 : null,
                child: Container(
                  width: guideThick,
                  height: guideLen,
                  color: guideColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
