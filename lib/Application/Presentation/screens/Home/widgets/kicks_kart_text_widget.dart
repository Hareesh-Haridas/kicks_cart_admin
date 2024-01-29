import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KicksCartText extends StatelessWidget {
  const KicksCartText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Kicks Cart',
          style: GoogleFonts.bangers(fontSize: 40),
        )
      ],
    );
  }
}
