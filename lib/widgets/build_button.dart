// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BuildButton {
  static Widget build(String buttonText, Function onPressed,
      {IconData? buttonIcon,
      bool useIcon = false,
      Color? coloure,
      double? value = 25,
      double? size = 25.0}) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: InkWell(
          onTap: () => onPressed(buttonText),
          child: Container(
            padding: EdgeInsets.all(value!),
            child: Center(
              child: useIcon
                  ? Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        buttonIcon,
                        color: coloure,
                        size: size,
                      ),
                    )
                  : Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: size,
                        color: coloure,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
