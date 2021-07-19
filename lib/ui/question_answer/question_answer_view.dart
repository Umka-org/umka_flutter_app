import 'package:flutter/material.dart';

class QuestionAnswerView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _questionWidget('hello'),
        const SizedBox(height: 100),
        _answerField(),
        const SizedBox(height: 100),
        _submitButton(),
      ],
    );
  }

  Widget _questionWidget(String question) => Text(question);

  Widget _answerField() {
    return TextFormField(
      key: _formKey,
      decoration: InputDecoration(
        hintText: 'Enter the Answer',
      ),
      validator: (value) => null,
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () {
        print('hi');
      },
      child: Text('Submit'),
    );
  }
}
