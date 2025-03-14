import 'package:flutter/material.dart';
import 'package:frontend/features/core/views/events/qrscanner.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/widgets/common/thin_elevated_button_widget.dart';
import 'package:frontend/widgets/event/create_event_section.dart';
import 'package:frontend/widgets/event/join_event_section.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool isCreatingEvent = false;
  TextEditingController eventController = TextEditingController();
  final GlobalKey _qrKey = GlobalKey();
  int step = 0;
  String eventType = "";
  String eventDate = "";
  String eventLocation = "";
  bool showQR = false;

  void toggleSection() {
    setState(() {
      isCreatingEvent = !isCreatingEvent;
    });
  }

  

  void nextStep(String value) {
    setState(() {
      if (step == 0) {
        eventType = value;
      } else if (step == 1) {
        eventDate = value;
      } else if (step == 2) {
        eventLocation = value;
        showQR = true;
      }
      step++;
    });
  }

  Future<void> _saveQR() async {
    RenderRepaintBoundary boundary =
        _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    await ImageGallerySaver.saveImage(pngBytes);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("QR Code Saved!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Join or Create an Event"),
        centerTitle: true,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container (
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ThinElevatedButtonWidget(
                    onPressed: () {
                      setState(() => isCreatingEvent = false);
                    },
                    buttonName: "Join Event",
                    outlined: !isCreatingEvent ? false : true,
                  ),

                  SizedBox(width: 10),

                  ThinElevatedButtonWidget(
                    onPressed: toggleSection,
                    buttonName: "Create Event",
                    outlined: isCreatingEvent ? false : true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            isCreatingEvent ? CreateEventSectionWidget() : JoinEventSectionWidget(),

            Text(
              step == 0
                  ? "What kind of event are you up to?"
                  : step == 1
                      ? "Select Event Date"
                      : "Enter Event Location",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (!showQR)
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (step == 0) ...[
                        _eventButton("Wedding"),
                        _eventButton("Party"),
                        _eventButton("Conference"),
                        _eventButton("Birthday"),
                        _eventButton("Other"),
                      ] else
                        TextField(
                          decoration: InputDecoration(
                            labelText: step == 1
                                ? "Enter Date (YYYY-MM-DD)"
                                : "Enter Location",
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: nextStep,
                        ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            else
              Column(
                children: [
                  RepaintBoundary(
                    key: _qrKey,
                    child: QrImageView(
                      data: "Event: $eventType\nDate: $eventDate\nLocation: $eventLocation",
                      version: QrVersions.auto,
                      size: 200,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveQR,
                    child: Text("Save QR Code"),
                  ),
                ],
              ),
          ],
        ),
    );  
  }

  Widget _eventButton(String title) {
    return ElevatedButton(
      onPressed: () => nextStep(title),
      child: Text(title),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
    );
  }


}
