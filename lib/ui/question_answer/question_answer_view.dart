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

  Widget _body(BuildContext context, QaState state) {
    final boxHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight * 2) / 6;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _EqualHeightWidget(
              height: boxHeight, child: _nameField(context, state)),
          _EqualHeightWidget(
              height: boxHeight,
              child: _questionWidget(state.question?.text ?? '')),
          _EqualHeightWidget(
              height: boxHeight, child: _answerField(context, state)),
          _EqualHeightWidget(
              height: boxHeight,
              child: state.submissionStatus.isSubmitting
                  ? CircularProgressIndicator()
                  : _submitButton(context, state)),
          _EqualHeightWidget(
              height: boxHeight, child: _evaluationWidget(context, state)),
          _EqualHeightWidget(
              height: boxHeight,
              child: _getRandomQuestionButton(context, state)),
        ],
      ),
    );
  }

  Widget _evaluationWidget(BuildContext context, QaState state) {
    if (state.evaluation == null) {
      return SizedBox.shrink();
    }
    final text = state.isAnswerCorrect
        ? '${_getSentAnswerText(state)}\nIs Correct 👍'
        : '${_getSentAnswerText(state)}\nIs not Correct 👎';

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: state.isAnswerCorrect ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget _getRandomQuestionButton(BuildContext context, QaState state) {
    return state.showGetQuestionButton
        ? ElevatedButton(
            onPressed: () {
              context.read<QaCubit>().getRandomQuestion();
            },
            child: Text(
              'Get Random Question',
              style: TextStyle(fontSize: 20),
            ),
          )
        : SizedBox.shrink();
  }

  String _getSentAnswerText(QaState state) =>
      '${state.question!.text.replaceFirst('?', '')}'
      '${state.enteredAnswer}';

  Widget _nameField(BuildContext context, QaState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Enter your name',
        ),
        onChanged: (value) => context.read<QaCubit>().nameChanged(value),
        validator: (value) => state.isNameValid ? null : 'Name is too short',
      ),
    );
  }

  Widget _questionWidget(String question) =>
      Text(question, style: TextStyle(fontSize: 20));

  Widget _submitButton(BuildContext context, QaState state) {
    return state.showSubmitButton
        ? ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<QaCubit>().answerSubmitted(state.enteredAnswer);
              }
            },
            child: Text('Send: ${_getSentAnswerText(state)}'),
          )
        : SizedBox.shrink();
  }
}

class _EqualHeightWidget extends StatelessWidget {
  final double height;
  final Widget child;

  const _EqualHeightWidget(
      {Key? key, required this.height, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(child: Center(child: child), height: height);
  }
}
