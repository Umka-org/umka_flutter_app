import 'package:flutter/material.dart';

class QuestionAnswerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _answerField(),
    );
  }

  Widget _answerField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter the Answer',
      ),
    );
  }
}
