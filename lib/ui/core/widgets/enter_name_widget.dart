import 'package:flutter/material.dart';

class EnterNameWidget extends StatelessWidget {
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const EnterNameWidget({
    Key? key,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter your name',
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
