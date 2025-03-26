import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/repository/event_repository/event_repository.dart';
import 'package:frontend/repository/cloudinary/cloudinary_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

class QRCodeDisplayWidget extends StatefulWidget {
  final GlobalKey qrKey;
  final String qrData;
  final String eventId;
  final VoidCallback onSave;
  final VoidCallback onShare;

  const QRCodeDisplayWidget({
    required this.qrKey,
    required this.qrData, 
    required this.eventId,
    required this.onSave, 
    required this.onShare,
  });

  @override
  _QRCodeDisplayWidgetState createState() =>  _QRCodeDisplayWidgetState();
}

class _QRCodeDisplayWidgetState extends State<QRCodeDisplayWidget> {

  bool _isUploading = false;
  String? _qrCodeUrl;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _uploadQrCodeToCloudinary();
    });
  }

  Future<void> _uploadQrCodeToCloudinary() async {
    setState(() {
      _isUploading = true;
    });

    try {
      // Capture QR code as image
      final imageBytes = await captureQrCode(widget.qrKey);

      if (imageBytes == null) {
        print("Failed to capture QR Code: image buytes is null");
        return;
      }

      final cloudinaryService = CloudinaryService();
      final qrCodeUrl = await cloudinaryService.uploadQRCode(imageBytes, widget.qrData);

      setState(() {
        _qrCodeUrl = qrCodeUrl;
      });
      print("QR Code uploaded to Cloudinary: $qrCodeUrl");

      await EventRepository.instance.storeQRCodeUrl(widget.eventId, qrCodeUrl);
  
    } catch (e) {
      print("Error uploading QR code to Cloudinary: $e");
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  static Future<Uint8List?> captureQrCode(GlobalKey qrKey) async {
    try {
      
      // final context = qrKey.currentContext;
      // if (context == null) {
      //   print("QR Key context is null");
      // }

      // final renderObject = context!.findRenderObject();
      // if (renderObject == null) {
      //   print('Render object is null');
      //   return null;
      // }

      // // Ensure the render object is a RenderRepaintBoundary
      // if (renderObject is! RenderRepaintBoundary) {
      //   print('Render object is not a RenderRepaintBoundary');
      //   return null;
      // }

      // final boundary = renderObject;
      // final image = await boundary.toImage();
      // final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      // return byteData?.buffer.asUint8List();

      RenderRepaintBoundary boundary = qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;

      // final boundary = qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // final image = await boundary.toImage();
      // final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      // return byteData?.buffer.asUint8List();
    } catch (e) {
      print("Error capturing QR code: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        RepaintBoundary(
          key: widget.qrKey,
          child: QrImageView(
            backgroundColor: Colors.white,
            data: widget.qrData,
            version: QrVersions.auto,
            size: 300,
          ),
        ),
        SizedBox(height: 20),
        if (_isUploading)
          CircularProgressIndicator()
        else if (_qrCodeUrl != null)
          Text('QR code uploaded successfully!')
        else
          Text('Failed to upload QR Code'),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: widget.onSave, 
              icon: Icon(Icons.save_alt_rounded),iconSize: 35),
            SizedBox(width: size.width * 0.3),
            IconButton(onPressed: widget.onShare, icon: Icon(Icons.share_rounded),iconSize: 35),
          ],
        ),
      ],
    );
  }
}