import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_flutter/ui/question_answer/qa_cubit.dart';
import 'package:umka_flutter/ui/question_answer/state.dart';

class QuestionAnswerView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QaCubit(context.read<UmkaService>()),
      child: BlocBuilder<QaCubit, QaState>(
        builder: (context, state) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _body(context, state),
          ),
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
          _nameField(context, state),
          const SizedBox(height: 50),
          _getRandomQuestionButton(context, state),
          const SizedBox(height: 50),
          _questionWidget(state.question?.text ?? ''),
          const SizedBox(height: 50),
          _answerField(context, state),
          const SizedBox(height: 50),
          state.submissionStatus.isSubmitting
              ? CircularProgressIndicator()
              : _submitButton(context, state),
          const SizedBox(height: 50),
          _evaluationWidget(context, state)
        ],
      ),
    );
  }

  Widget _getRandomQuestionButton(BuildContext context, QaState state) {
    return state.isNameValid
        ? TextButton(
            onPressed: () {
              context.read<QaCubit>().getRandomQuestion();
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
          )
        : SizedBox.shrink();
  }

  Widget _questionWidget(String question) => Text(question);

  Widget _nameField(BuildContext context, QaState state) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter your name',
      ),
      onChanged: (value) => context.read<QaCubit>().nameChanged(value),
      validator: (value) => state.isNameValid ? null : 'Name is too short',
    );
  }

  Widget _answerField(BuildContext context, QaState state) {
    return state.isReadyToAnswer
        ? TextFormField(
            initialValue: state.enteredAnswer,
            decoration: InputDecoration(
              hintText: 'Enter the Answer',
            ),
            onChanged: (value) => context.read<QaCubit>().answerChanged(value),
            validator: (value) =>
                state.isAnswerValid ? null : 'Incorrect answer format',
          )
        : SizedBox.shrink();
  }

  Widget _submitButton(BuildContext context, QaState state) {
    return state.isReadyToSubmitAnswer
        ? ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<QaCubit>().answerSubmitted(state.enteredAnswer);
              }
            },
            child: Text('Submit'),
          )
        : SizedBox.shrink();
  }

  Widget _evaluationWidget(BuildContext context, QaState state) {
    return state.evaluation == null
        ? SizedBox.shrink()
        : Text(state.evaluation!.mark == 5 ? 'Correct' : 'Incorrect');
  }
}
