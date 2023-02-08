import 'package:flutter/material.dart';
import 'app_text.dart';

// ignore: must_be_immutable
class ResponsiveButton extends StatelessWidget {
  Color color;
  double? width;
  double? height;
  String text;
  final VoidCallback onPressed;
  ResponsiveButton(
      {Key? key,
      this.color = Colors.indigo,
      this.width = 130,
      this.height = 50,
      required this.onPressed,
      this.text = "Button"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: SizedBox(
              width: width,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(child: AppText(text: text, color: Colors.white)),
              ))),
    );
  }
}
