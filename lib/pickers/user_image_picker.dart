import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker( this.imagePickfn,{Key? key,} ) : super(key: key);

  final void Function(File PickedImage)imagePickfn;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}
class _UserImagePickerState extends State<UserImagePicker> {
   var _pickedImage;
  final ImagePicker _picked = ImagePicker();
  void _pickImage(ImageSource src) async {
    final pickImageFile = await _picked.pickImage(source: src,imageQuality: 50,maxWidth: 150);
    if (pickImageFile != null) {
      setState(() {
        _pickedImage = File(pickImageFile.path);
      });
      widget.imagePickfn(_pickedImage);
    } else {
      print('no image picked');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        const SizedBox(
          width: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(Icons.photo_camera_outlined),
                label: const Text("Add Image \nfrome Camera"),
            ),
            TextButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.image_outlined),
              label: const Text("Add Image \nfrome Gallery"),
            ),

          ],
        )
      ],
    );
  }
}
