import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDisplayWidget extends StatelessWidget {
  final GlobalKey qrKey;
  final String qrData;
  final VoidCallback onSave;
  final VoidCallback onShare;

  const QRCodeDisplayWidget({
    required this.qrKey,
    required this.qrData,
    required this.onSave,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        RepaintBoundary(
          key: qrKey,
          child: QrImageView(
            backgroundColor: Colors.white,
            data: qrData,
            version: QrVersions.auto,
            size: 300,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: onSave, icon: Icon(Icons.save_alt_rounded),iconSize: 35),
            SizedBox(width: size.width * 0.3),
            IconButton(onPressed: onShare, icon: Icon(Icons.share_rounded),iconSize: 35),
          ],
        ),
      ],
    );
  }
}