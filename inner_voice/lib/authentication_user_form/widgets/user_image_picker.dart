import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key, required this.onPickImage});
  final void Function(File pickedImageFile) onPickImage;

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? pickedImageFile;
  void _pickImageFromCamera() async {
    final pickedImageFromCamera = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front,
        maxHeight: 640,
        maxWidth: 480);

    if (pickedImageFromCamera == null) {
      return;
    }
    setState(() {
      pickedImageFile = File(pickedImageFromCamera.path);
    });
    widget.onPickImage(pickedImageFile!);
  }

  void _pickImageFromGallery() async {
    final pickedImageFromGallery = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front,
        maxHeight: 640,
        maxWidth: 480);
    if (pickedImageFromGallery == null) {
      return;
    }
    setState(() {
      pickedImageFile = File(pickedImageFromGallery.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          foregroundImage:
              pickedImageFile != null ? FileImage(pickedImageFile!) : null,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _pickImageFromCamera,
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(
                Icons.camera,
              ),
            ),
            IconButton(
              onPressed: _pickImageFromGallery,
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.image_rounded),
            )
          ],
        )
      ],
    );
  }
}
