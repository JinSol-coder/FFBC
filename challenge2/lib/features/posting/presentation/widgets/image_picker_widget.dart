import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/posting_provider.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PostingProvider>(
      builder: (context, provider, child) {
        if (provider.image == null) {
          return _buildImagePickerButtons(context);
        }
        return _buildSelectedImage(context, provider);
      },
    );
  }

  Widget _buildImagePickerButtons(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.photo_library),
          onPressed: () => _showImageSourceDialog(context),
        ),
      ],
    );
  }

  Widget _buildSelectedImage(BuildContext context, PostingProvider provider) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(provider.image!.path),
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: provider.removeImage,
            style: IconButton.styleFrom(
              backgroundColor: Colors.black54,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('카메라로 촬영'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<PostingProvider>().pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리에서 선택'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<PostingProvider>().pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
} 