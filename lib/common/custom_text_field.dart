import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final double topRightRadius;
  final double topLeftRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final TextEditingController controller;
  final String hintText;
  final bool isPasswordType;

  //
  TextInputType inputType;
  Function(String)? onChanged;
  bool? isEditbale;
  String? Function(String? validate) checkValidator;
  int? maxInput;
  List<TextInputFormatter>? formatterValues;

  CustomTextField({
    this.topRightRadius = 0,
    this.topLeftRadius = 0,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
    required this.controller,
    required this.hintText,
    this.inputType = TextInputType.name,
    this.isEditbale = true,
    required this.checkValidator,
    this.formatterValues,
    this.maxInput,
    this.isPasswordType = false,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius),
              topRight: Radius.circular(topRightRadius),
              bottomLeft: Radius.circular(bottomLeftRadius),
              bottomRight: Radius.circular(bottomRightRadius)),
          color: Colors.grey[100],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
            keyboardType: inputType,
            enabled: isEditbale,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return checkValidator(value);
            },
            autofocus: false,
            maxLength: maxInput,
            obscureText: isPasswordType,
            onChanged: onChanged,
            inputFormatters: formatterValues,
            style: TextStyle(color: Colors.black), // Add this line
            decoration: InputDecoration(
              counterText: "",
              hintText: hintText ?? "Enter Text",
              hintStyle: TextStyle(color: Colors.black), // Add this line
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
