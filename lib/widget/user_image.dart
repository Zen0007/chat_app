import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  const UserImage({super.key, required this.pickImage});
  final void Function(File pickImage) pickImage;
  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? _pickImageUser;

  void _imagePick() async {
    final pickImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    if (pickImage == null) {
      return;
    }
    setState(() {
      _pickImageUser = File(pickImage.path);
    });

    widget.pickImage(_pickImageUser!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.black,
          foregroundImage:
              _pickImageUser != null ? FileImage(_pickImageUser!) : null,
        ),
        TextButton.icon(
          onPressed: _imagePick,
          label: Text(
            "Add image",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          icon: const Icon(Icons.image),
        )
      ],
    );
  }
}
