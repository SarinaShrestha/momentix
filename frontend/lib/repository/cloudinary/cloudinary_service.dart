import 'dart:convert';

import 'package:cloudinary/cloudinary.dart';
import 'dart:typed_data';

class CloudinaryService {
  final cloudinary = Cloudinary.signedConfig(
    cloudName: 'dx5mrbp5d', // Replace with your Cloudinary cloud name
    apiKey: "191922669853637",       // Replace with your Cloudinary API key
    apiSecret: "Inz4zaavE6ciw3qWjfbEfVUpJ20", // Replace with your Cloudinary API secret
  );

  // Upload QR code to Cloudinary
  Future<String> uploadQRCode(Uint8List qrImageBytes, String eventId) async {
    try {
      if(qrImageBytes == null) {
        print('QR Image bytes are null(inside uploadQRCode)');
        throw Exception("QR Image bytes are null");
      }

      final base64Image = base64Encode(qrImageBytes);

      if(base64Image.isEmpty) {
        print('Failed to encode image to base64');
      }

      final response = await cloudinary.upload(
        fileBytes:qrImageBytes,
        resourceType: CloudinaryResourceType.image,
        folder: 'qr_codes', // Optional: Organize files in a folder
        publicId: eventId,  // Use eventId as the public ID
      );
      print('Cloudinary response: $response');
      if (response == null || response.secureUrl == null) {
        print('Cloudinary response or secure URL is null');
      }
      return response.secureUrl!;
    } catch (e) {
      throw Exception('Failed to upload QR code: $e');
    }
  }
}