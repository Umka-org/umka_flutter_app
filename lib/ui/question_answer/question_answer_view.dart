import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/ui/question_answer/events.dart';
import 'package:umka_flutter/ui/question_answer/state.dart';

import 'bloc.dart';

class QuestionAnswerView extends StatelessWidget {
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocBuilder<QaBloc, QaState>(builder: (context, bloc) {
          return _body(context);
        }),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _questionWidget('hello'),
        const SizedBox(height: 50),
        _nameField(),
        const SizedBox(height: 50),
        _answerField(context),
        const SizedBox(height: 50),
        _submitButton(),
      ],
    );
  }

  Widget _questionWidget(String question) => Text(question);

  Widget _nameField() {
    return TextFormField(
      // key: _formKey,
      decoration: InputDecoration(
        hintText: 'Enter your name',
      ),
      validator: (value) => null,
    );
  }

  Widget _answerField(BuildContext context) {
    return TextFormField(
        // key: _formKey,
        decoration: InputDecoration(
          hintText: 'Enter the Answer',
        ),
        onChanged: (value) => context.read<QaBloc>().add(AnswerChanged(value)));
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
