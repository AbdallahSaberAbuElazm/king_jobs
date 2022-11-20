import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final Color imageColor;
  const LogoWidget({super.key, required this.imageColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      // height: 50,
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.fill,
        color: imageColor,
      ),
    );
  }
}
