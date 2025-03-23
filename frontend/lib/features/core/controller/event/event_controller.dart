import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/repository/authentication_repository/event_repository/event_repository.dart';
import 'package:frontend/repository/cloudinary/cloudinary_service.dart';
import 'package:frontend/utils/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventController {
  final EventRepository _eventRepository = EventRepository();
  final CloudinaryService _cloudinaryService = CloudinaryService();

  // Validate event name
  String? validateEventName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter an event name.";
    }
    return null;
  }

  // Validate event date
  String? validateEventDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select a date.";
    }
    return null;
  }

  // Validate event type
  String? validateEventType(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select an event type.";
    }
    return null;
  }

  Future<Uint8List> _generateQRCodeImage(String eventId) async {
    try {
      final qrPainter = QrPainter(
        data: eventId,
        version: QrVersions.auto,
        eyeStyle: const QrEyeStyle(
          eyeShape: QrEyeShape.square,
          color: black,
        ),
        dataModuleStyle: const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: black,
        ),
        emptyColor: white,
      );

      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      qrPainter.paint(canvas, const Size(200, 200));
      final image = await recorder.endRecording().toImage(200, 200);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (e) {
      print("Error generating QR code image: $e");
      throw Exception("Failed to generate QR code image");
    }
  }
  
  // Create an event
  Future<String> createEvent({
    required String eventName,
    required String eventDate,
    required String eventType,
  }) async {
    final String creatorId = FirebaseAuth.instance.currentUser!.uid;

    try {
      String eventId = await _eventRepository.addEvent(
        eventName: eventName,
        eventDate: eventDate,
        eventType: eventType,
        creatorId: creatorId,
      );

      final qrImageBytes = await _generateQRCodeImage(eventId);

      final qrCodeUrl = await _cloudinaryService.uploadQRCode(qrImageBytes, eventId);

      await _eventRepository.storeQRCodeUrl(eventId, qrCodeUrl);

      return eventId;
    } catch (e) {
      throw e; // Rethrow the error for handling in the UI
    }
  }

  Future<void> addUserToEvent(String eventId) async{
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      await _eventRepository.addAttendee(eventId: eventId, attendeeId: userId);
    } catch (e) {
      print("Error adding user to event: $e");
    }
  }
}