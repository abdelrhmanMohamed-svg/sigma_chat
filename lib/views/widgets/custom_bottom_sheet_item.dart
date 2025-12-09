import 'package:flutter/material.dart';
import 'package:sgima_chat/utils/theme/app_color.dart';

class CustomBottomSheetItem extends StatelessWidget {
  const CustomBottomSheetItem({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width * 0.25,
        height: size.height * 0.13,

        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColor.gray300,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            Icon(icon, size: size.width * 0.1),
            SizedBox(height: size.height * 0.005),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
