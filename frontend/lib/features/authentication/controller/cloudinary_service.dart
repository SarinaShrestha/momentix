import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class CloudinaryService {
  final String cloudName = 'dx5mrbp5d';
  final String uploadPreset = 'YOUR_UPLOAD_PRESET';

  // Function to pick image
  Future<File?> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Function to upload image to Cloudinary
  Future<String?> uploadImage(File imageFile) async {
    final String uploadUrl = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

    final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final resStream = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = json.decode(resStream);
      return data['secure_url']; // Returns the image URL
    } else {
      debugPrint('Failed to upload: $resStream');
      return null;
    }
  }
}
