import 'dart:convert';

import 'package:cloudinary/cloudinary.dart';
import 'dart:typed_data';

class CloudinaryService {
  final Dio _dio = Dio();
  final cloudinary = Cloudinary.signedConfig(
    cloudName: 'dx5mrbp5d',
    apiKey: "191922669853637",      
    apiSecret: "Inz4zaavE6ciw3qWjfbEfVUpJ20", 
  );

  // Upload QR code to Cloudinary
  Future<String> uploadQRCode(Uint8List qrImageBytes, String eventId) async {
    try {

      FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(qrImageBytes, filename: "$eventId.png"),
      "upload_preset": "preset_qr",
      "public_id": eventId
    });

    final response = await _dio.post(
      "https://api.cloudinary.com/v1_1/dx5mrbp5d/image/upload",
      data: formData,
    );

    print("Cloudinary Response: ${response.data}");

    return response.data["secure_url"];
      // final response = await cloudinary.upload(
      //   fileBytes:qrImageBytes,
      //   resourceType: CloudinaryResourceType.image,
      //   folder: 'qr_codes', 
      //   publicId: eventId, 
      // );

      // print('Cloudinary response: $response');

      // if (response.secureUrl == null) {
      //   print('Cloudinary response or secure URL is null');
      // }
      // return response.secureUrl!;
    } catch (e) {
      throw Exception('Failed to upload QR code: $e');
    }
  }
}