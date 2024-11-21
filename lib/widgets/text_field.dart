import 'package:flutter/material.dart';
import '../theme.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final EdgeInsetsGeometry contentPadding;
  final String? Function(String?)? validator;
  final bool isError;
  final bool isPassword;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
    this.validator,
    this.isPassword = false,
    this.isError = false,
    this.keyboardType,
    required this.labelText,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        style: primaryTextStyle.copyWith(fontSize: 16),
        validator: widget.validator,
        obscureText: _isObscure,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: hintTextStyle,
          contentPadding: widget.contentPadding,
          focusedBorder: buildOutlineInputBorder(primary),
          errorBorder: buildOutlineInputBorder(red),
          border: buildOutlineInputBorder(softgray),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: borderColor),
    );
  }
}
