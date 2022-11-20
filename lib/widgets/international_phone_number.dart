import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class InternationPhoneNumber extends StatefulWidget {
  final TextEditingController controller;

  const InternationPhoneNumber({
    super.key,
    required this.controller,
  });

  @override
  State<InternationPhoneNumber> createState() => _InternationPhoneNumberState();
}

class _InternationPhoneNumberState extends State<InternationPhoneNumber> {
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'AE');

    setState(() {
      this.number = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      onInputValidated: (bool value) {
        print(value);
      },
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: const TextStyle(color: Colors.black),
      initialValue: number,
      textFieldController: widget.controller,
      formatInput: false,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: true),
      inputBorder: const OutlineInputBorder(),
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }
}
