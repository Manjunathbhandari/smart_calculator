// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:smartcalculator/widgets/app_text.dart';

class CustomCard extends StatelessWidget {
  String text;

  final VoidCallback onPressed;
  CustomCard({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color.fromARGB(255, 36, 36, 36),
        child: ListTile(
          title: AppText(text: text, color: Colors.white),
          trailing: const Icon(Icons.arrow_right),
          onTap: onPressed,
        ));
  }
}
