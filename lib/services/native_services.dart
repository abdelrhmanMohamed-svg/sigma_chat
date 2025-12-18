import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

abstract class NativeServices {
  Future<File?> pickImage(ImageSource source);
  Future<PlatformFile?> pickFile();
}

class NativeServicesImpl implements NativeServices {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> pickImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (image == null) return null;

    return File(image.path);
  }

  @override
  Future<PlatformFile?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      return file;
    }
    return null;
  }
}
