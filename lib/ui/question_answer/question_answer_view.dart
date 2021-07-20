import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/ui/question_answer/events.dart';
import 'package:umka_flutter/ui/question_answer/state.dart';

import 'bloc.dart';

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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getRandomQuestionButton(),
          const SizedBox(height: 50),
          _questionWidget('hello'),
          const SizedBox(height: 50),
          _nameField(),
          const SizedBox(height: 50),
          _answerField(),
          const SizedBox(height: 50),
          _submitButton(),
        ],
      ),
    );
  }

  Widget _getRandomQuestionButton() {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.refresh),
          ),
          Text('Get random question'),
        ],
      ),
    );
  }

  Widget _questionWidget(String question) => Text(question);

  Widget _nameField() {
    return BlocBuilder<QaBloc, QaState>(
      builder: (context, state) => TextFormField(
        decoration: InputDecoration(
          hintText: 'Enter your name',
        ),
        validator: (value) => state.isValidName ? null : 'Name is too short',
      ),
    );
  }

  Widget _answerField() {
    return BlocBuilder<QaBloc, QaState>(
        builder: (context, state) => TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter the Answer',
              ),
              onChanged: (value) =>
                  context.read<QaBloc>().add(AnswerChanged(value)),
              validator: (value) =>
                  state.isValidAnswer ? null : 'Incorrect answer format',
            ));
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
