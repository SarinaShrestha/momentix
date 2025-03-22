import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/features/core/widgets/events_widgets/event_creation_form_widget.dart';
import 'package:frontend/features/core/widgets/events_widgets/qr_display_widget.dart';
import 'package:frontend/repository/authentication_repository/event_repository/event_repository.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/widgets/common/thin_elevated_button_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;
import 'package:gallery_saver_plus/gallery_saver.dart';

class EventScreen extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventScreen> {
  int step = 0;
  bool isJoiningEvent = true;
  bool isQRCodeGenerated = false;
  bool dirExists = false;

  //Event Details
  String eventId ="";
  String eventName = "";
  String eventDate = "";
  String eventType = "";
  String qrData = "";


  GlobalKey _qrKey = GlobalKey();
  dynamic externalDir = '/Storage/Internal storage/Download/QR_Code';

  ScreenshotController screenshotController = ScreenshotController();

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  void toggleCreateEvent() {
    setState(() {
      isJoiningEvent = true;
    });
  }

  void toggleJoinEvent() {
    setState(() {
      isJoiningEvent = false;
      isQRCodeGenerated = false;
    });
  }
  void nextStep(String value) {
    setState(() {
      if (step == 0) {
        eventName = value;
      } else if (step == 1) {
        eventDate = value;
      } else if (step == 2) {
        eventType = value;
        qrData = "$eventName\n$eventDate\n$eventType";
        isQRCodeGenerated = true;
      }

      step++;
      _controller.clear();
    });
  }

  void generateQRCode() {
    if (eventName.isNotEmpty) {
      setState(() {
        qrData = "event://$eventName";
        isQRCodeGenerated = true;
      });
    }
  }

  // Future<void> _selectDate() async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2027)
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       eventDate = "${picked.toLocal()}".split(' ')[0];
  //     });
  //   }
  // }

  Future<void> _captureAndSavePng() async {
  try {
    RenderRepaintBoundary boundary = _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Get the temporary directory
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/qr_code.png');
    await file.writeAsBytes(pngBytes);

    // Save to gallery
    bool? success = await GallerySaver.saveImage(file.path);
    
    if (success == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR Code saved to gallery!'))
      );
    } else {
      throw Exception("Gallery save failed");
    }
  } catch (e) {
    print("Error saving QR Code: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Something went wrong!'))
    );
  }
  }

  Future<void> saveQRImage() async {
  try {
    await Future.delayed(Duration(milliseconds: 500)); // Ensure rendering is done
    RenderRepaintBoundary boundary = _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = File('${directory.path}/event_qr.png');

    await imagePath.writeAsBytes(pngBytes);

    // Check if file exists
    if (await imagePath.exists()) {
      print("File successfully saved: ${imagePath.path}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("QR Code saved successfully!")));
    } else {
      print("File not found after saving.");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to save QR Code.")));
    }
  } catch (e) {
    print("Error saving QR code: $e");
  }
}


  Future<void> saveAndShareQRImage() async {
  try {
    await Future.delayed(Duration(milliseconds: 500)); // Ensures rendering
    RenderRepaintBoundary boundary = _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    if (boundary.debugNeedsPaint) {
      await Future.delayed(Duration(milliseconds: 500));
    }

    ui.Image image = await boundary.toImage(pixelRatio: 3.0); // High resolution
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Save temporarily for sharing
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/event_qr.png').create();
    await file.writeAsBytes(pngBytes);

    // Share the QR code
    await Share.shareXFiles([XFile(file.path)], text: "Here is my event QR code! Please scan it and join my event.");

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to share QR Code.")));
  }
}

  @override
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return Scaffold(
    appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.all(0.01 * size.width),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 0.35 * size.width,
                    child: ThinElevatedButtonWidget(
                      buttonName: 'Join Event',
                      onPressed: toggleCreateEvent,
                      outlined: isJoiningEvent,
                    ),
                  ),
                  SizedBox(
                    width: 0.35 * size.width,
                    child: ThinElevatedButtonWidget(
                      buttonName: 'Create Event',
                      onPressed: toggleJoinEvent,
                      outlined: !isJoiningEvent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        backgroundColor: black,
        toolbarHeight: 0.15 * size.height,
      ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isJoiningEvent)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.7,
                  width: size.width,
                  child: MobileScanner(
                    onDetect: (barcode) async {
                      if (barcode.barcodes.isNotEmpty && barcode.barcodes.first.rawValue != null) {
                        String eventId = barcode.barcodes.first.rawValue!;
                        String attendeeId = FirebaseAuth.instance.currentUser!.uid;
                        try{
                          await EventRepository().addAttendee(eventId: eventId, attendeeId: attendeeId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("You have successfully joined the event!")),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Failed to join the event: $e")),
                          );
                        }
                      }
                    }
                  )
                )
              ]
            ),
          if (!isJoiningEvent)
            !isQRCodeGenerated
                ? EventCreationFormWidget(
                  onEventCreated: (String eventId, String eventName, String eventDate, String eventType) {
                    setState(() {
                      this.eventName = eventName;
                      this.eventDate =  eventDate;
                      this.eventType = eventType;
                      this.eventId = eventId;
                      qrData = "Event ID: $eventId\nEvent Name: $eventName\nEvent Date: $eventDate\nEvent Type:$eventType";
                      isQRCodeGenerated = true;
                    });
                  }
                )
                :  QRCodeDisplayWidget(
                    qrKey: _qrKey,
                    qrData: qrData,
                    onSave: _captureAndSavePng,
                    onShare: saveAndShareQRImage,
                  ),
        ],
      ),
    ),
  );
}
}
