import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sgima_chat/utils/theme/app_color.dart';

class SelectedFileItem extends StatelessWidget {
  const SelectedFileItem({
    super.key,
    required this.file,
    this.onTap,
    this.isSend = false,
  });
  final PlatformFile file;
  final VoidCallback? onTap;
  final bool isSend;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            height: size.height * 0.1,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: AppColor.gray400),
            ),
            child: Row(
              children: [
                Icon(Icons.file_copy, color: isSend ? AppColor.primary : null),
                SizedBox(width: size.width * 0.03),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        file.name,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: isSend ? AppColor.primary : null),
                      ),
                      SizedBox(height: size.height * 0.001),
                      Text(
                        file.extension ?? "unknown",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: isSend ? AppColor.primary : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isSend)
            Positioned(
              top: 8,
              right: 8,
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
      ),
    );
  }
}
