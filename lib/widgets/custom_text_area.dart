import 'package:flutter/material.dart';
import 'package:king_jobs/config/styles/color.dart';

class CustomTextArea extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  CustomTextArea({super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            color: Colors.white,
            elevation: 11,
            shadowColor: Colors.grey.withOpacity(0.4),
            margin: const EdgeInsets.only(bottom: 9, top: 8),
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  fillColor: secondColor,
                  focusColor: secondColor,
                  hoverColor: secondColor,
                  iconColor: secondColor),
              minLines: 4,
              cursorColor: secondColor,
              style: Theme.of(context).textTheme.bodyText2,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          )
        ]);
  }
}
