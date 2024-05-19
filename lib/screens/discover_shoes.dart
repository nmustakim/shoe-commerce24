import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiscoverShoes extends StatelessWidget {
  const DiscoverShoes({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'DISCOVER',
            style: GoogleFonts.urbanist(),
          ),
          centerTitle: false,
          actions: [
            Image.asset('assets/images/cart.png'),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: const Column(children: []),
      ),
    );
  }
}
