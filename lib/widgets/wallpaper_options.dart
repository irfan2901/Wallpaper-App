import 'package:flutter/material.dart';

class WallpaperOptions extends StatelessWidget {
  final Color color;
  final String title;
  final IconData iconData;
  final VoidCallback callback;
  const WallpaperOptions(
      {super.key,
      required this.color,
      required this.title,
      required this.iconData,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
          ),
          child: IconButton(
            onPressed: callback,
            icon: Icon(iconData),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(title)
      ],
    );
  }
}
