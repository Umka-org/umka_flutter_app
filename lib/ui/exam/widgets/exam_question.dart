import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/ui/exam/exam_cubit.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';

class ExamQuestion extends StatefulWidget {
  const ExamQuestion({Key? key}) : super(key: key);

  @override
  State<ExamQuestion> createState() => _ExamQuestionState();
}

class _ExamQuestionState extends State<ExamQuestion> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(builder: (context, state) {
      return state.currentQuestion == null
          ? SizedBox.shrink()
          : Container(
              child: Column(
                children: [
                  Text(
                    'Enter the answer for question #'
                    '${state.questionIndex + 1} of '
                    '${state.exam?.questions.length ?? 0}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 10),
                  Text(
                    state.currentQuestion!.text,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.deepPurple.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    onChanged: (text) =>
                        context.read<ExamCubit>().answerChanged(text),
                  ),
                  SizedBox(height: 30),
                  _submitButton(context, state),
                ],
              ),
            );
    });
  }

  Widget _submitButton(BuildContext context, ExamState state) {
    return state.showSubmitButton
        ? ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Colors.deepPurple.shade700),
            ),
            onPressed: () {
              _controller.clear();
              context.read<ExamCubit>().sendAnswer(state.enteredAnswer);
            },
            child: Text(
              'Send: ${_getSentAnswerText(state)}',
              style: TextStyle(fontSize: 25),
            ),
          )
        : SizedBox.shrink();
  }

  String _getSentAnswerText(ExamState state) =>
      '${state.currentQuestion!.text.replaceFirst('?', '')}'
      '${state.enteredAnswer}';
}
