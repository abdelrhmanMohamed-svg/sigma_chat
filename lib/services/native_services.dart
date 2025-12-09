import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class NativeServices {
  Future<File?> pickImageFromGallery();
  Future<File?> pickImageFromCamera();
  //Future<String?> pickFile();
}

class NativeServicesImpl implements NativeServices {
  final ImagePicker _picker = ImagePicker();
  @override
  Future<File?> pickImageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;

    return File(image.path);
  }

  @override
  Future<File?> pickImageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    return File(image.path);
  }
}
