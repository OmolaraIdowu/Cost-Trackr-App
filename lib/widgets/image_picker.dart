import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserImagePicker extends StatelessWidget {
  const UserImagePicker({
    super.key,
    required this.imageFile,
    required this.isUploading,
  });

  final File? imageFile;
  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.3;

    return Stack(alignment: Alignment.center, children: [
      Container(
        height: imageSize,
        width: imageSize,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: theme.primaryColor),
          shape: BoxShape.circle,
          color: theme.scaffoldBackgroundColor,
        ),
        child: imageFile != null
            ? CircleAvatar(
                backgroundColor: theme.scaffoldBackgroundColor,
                foregroundImage: FileImage(imageFile!),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset('assets/icons/profile.svg'),
              ),
      ),
      if (isUploading)
        Container(
          height: imageSize,
          width: imageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withOpacity(0.5),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
    ]);
  }
}
