import 'package:flutter/material.dart';

class SizeAvailableText extends StatelessWidget {
  const SizeAvailableText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          "Size Availbale",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
