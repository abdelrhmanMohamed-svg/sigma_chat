import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sgima_chat/utils/theme/app_color.dart';

class SelectedIamgeItem extends StatelessWidget {
  const SelectedIamgeItem({
    super.key,
    required this.image,
    required this.onTap,
  });
  final File image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.file(
            image,
            height: size.height * 0.13,
            width: size.width * 0.3,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 3,
          right: 3,
          child: InkWell(
            onTap: onTap,
            child: CircleAvatar(
              backgroundColor: AppColor.gray300,
              radius: 15,
              child: Icon(Icons.close),
            ),
          ),
        ),
      ],
    );
  }
}
