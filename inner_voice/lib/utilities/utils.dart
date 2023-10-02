import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(
      source: source,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front,
      maxHeight: 640,
      maxWidth: 480);
  if (file != null) {
    return await file.readAsBytes();
  }
}

/// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(text)));
}

class ImageSelector extends StatelessWidget {
  const ImageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: pickImage(ImageSource.camera),
            icon: const Icon(Icons.camera_rounded)),
        IconButton(
            onPressed: pickImage(ImageSource.gallery),
            icon: const Icon(Icons.photo)),
      ],
    );
  }
}
