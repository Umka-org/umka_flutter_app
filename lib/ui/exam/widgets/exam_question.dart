import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/ui/exam/exam_cubit.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';

class ExamQuestion extends StatelessWidget {
  const ExamQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) => state.currentQuestion == null
          ? SizedBox.shrink()
          : Container(
              child: Column(
                children: [
                  Text(state.currentQuestion!.text),
                  TextFormField(
                    initialValue: state.enteredAnswer,
                    onChanged: (text) =>
                        context.read<ExamCubit>().answerChanged(text),
                  ),
                  _submitButton(context, state),
                ],
              ),
            ),
    );
  }

  Widget _submitButton(BuildContext context, ExamState state) {
    return state.showSubmitButton
        ? ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.pink),
            ),
            onPressed: () {
              context.read<ExamCubit>().sendAnswer(state.enteredAnswer);
            },
            child: Text('Send: ${_getSentAnswerText(state)}'),
          )
        : SizedBox.shrink();
  }

  String _getSentAnswerText(ExamState state) =>
      '${state.currentQuestion!.text.replaceFirst('?', '')}'
      '${state.enteredAnswer}';
}