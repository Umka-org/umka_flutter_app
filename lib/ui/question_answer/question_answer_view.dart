import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_flutter/ui/question_answer/events.dart';
import 'package:umka_flutter/ui/question_answer/state.dart';

import 'bloc.dart';

class QuestionAnswerView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QaBloc, QaState>(
      builder: (context, state) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _body(context, state),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, QaState state) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getRandomQuestionButton(context, state),
          const SizedBox(height: 50),
          _questionWidget('hello'),
          const SizedBox(height: 50),
          _nameField(context, state),
          const SizedBox(height: 50),
          _answerField(context, state),
          const SizedBox(height: 50),
          _submitButton(context, state),
        ],
      ),
    );
  }

  Widget _getRandomQuestionButton(BuildContext context, QaState state) {
    return TextButton(
      onPressed: () {
        context.read<QaBloc>().add(GetRandomQuestion());
      },
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

  Widget _nameField(BuildContext context, QaState state) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter your name',
      ),
      onChanged: (value) => context.read<QaBloc>().add(NameChanged(value)),
      validator: (value) => state.isValidName ? null : 'Name is too short',
    );
  }

  Widget _answerField(BuildContext context, QaState state) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter the Answer',
      ),
      onChanged: (value) => context.read<QaBloc>().add(AnswerChanged(value)),
      validator: (value) =>
          state.isValidAnswer ? null : 'Incorrect answer format',
    );
  }

  Widget _submitButton(BuildContext context, QaState state) {
    return state.submissionStatus is Submitting
        ? CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<QaBloc>().add(AnswerSubmitted());
              }
            },
            child: Text('Submit'),
          );
  }
}
