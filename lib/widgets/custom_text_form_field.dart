import 'package:flutter/material.dart';
import 'package:king_jobs/config/styles/color.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isEnabled;
  const CustomTextFormField(
      {super.key,
      required this.title,
      required this.controller,
      required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        // top: MediaQuery.of(context).size.height / 200,
        left: MediaQuery.of(context).size.width / 150,
        right: MediaQuery.of(context).size.width / 150,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 9.7,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              color: Colors.white,
              elevation: 7,
              shadowColor: Colors.grey.withOpacity(0.4),
              margin: const EdgeInsets.only(bottom: 9, top: 8),
              child: TextFormField(
                enabled: isEnabled,
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    fillColor: secondColor,
                    focusColor: secondColor,
                    hoverColor: secondColor,
                    iconColor: secondColor),
                cursorColor: secondColor,
                style: Theme.of(context).textTheme.bodyText2,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'من فضلك أدخل $title';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
