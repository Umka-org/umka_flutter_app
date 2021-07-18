import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final bool show;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPress,
    this.show = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show
        ? ElevatedButton(
            onPressed: onPress,
            child: Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
          )
        : SizedBox.shrink();
  }
}
