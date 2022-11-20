import 'package:flutter/material.dart';

class GoElevatedBtn extends StatelessWidget {
  final dynamic onPressed;
  final String title;
  final Color btnColor;
  final Color textColor;

  const GoElevatedBtn(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.btnColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              color: textColor, fontSize: 18, fontFamily: 'NotoKufiArabic'),
        ),
      ),
    );
  }
}
