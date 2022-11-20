import 'package:flutter/material.dart';
import 'package:king_jobs/config/styles/color.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String title;
  const PasswordFormField(
      {Key? key, required this.controller, required this.title})
      : super(key: key);

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        // top: MediaQuery.of(context).size.height / 80,
        left: MediaQuery.of(context).size.width / 150,
        right: MediaQuery.of(context).size.width / 150,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10.3,
              child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  color: Colors.white,
                  elevation: 7,
                  shadowColor: Colors.grey.withOpacity(0.4),
                  margin: const EdgeInsets.only(bottom: 9, top: 8),
                  child: TextFormField(
                    cursorColor: secondColor,
                    controller: widget.controller,
                    validator: (val) => (val != null && val.length < 6)
                        ? 'كلمة المرور اقل من 6 احرف'
                        : null,
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      fillColor: secondColor,
                      focusColor: secondColor,
                      hoverColor: secondColor,
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          (_passwordVisible == true)
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: secondColor,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_passwordVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.right,
                  )),
            )
          ]),
    );
  }
}
