import 'package:flutter/material.dart';

class TextWithLeadingIcon extends StatelessWidget {
  final Text text;
  final Icon icon;
  const TextWithLeadingIcon({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 10,
        ),
        text
      ],
    );
  }
}
