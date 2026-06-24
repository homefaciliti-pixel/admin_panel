import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart';

class CropBannerScreen extends StatelessWidget {
  final Uint8List imageBytes;

  const CropBannerScreen({super.key, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return ProImageEditor.memory(
      imageBytes,
      callbacks: ProImageEditorCallbacks(
        onImageEditingComplete: (Uint8List editedBytes) async {
          Navigator.pop(context, editedBytes);
        },
      ),
    );
  }
}
