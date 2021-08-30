import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/exam/exam_cubit.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';

class ExamView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExamCubit(context.read<UmkaService>()),
      child: BlocBuilder<ExamCubit, ExamState>(
          builder: (context, state) => Scaffold(
                  body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _body(context, state),
              ))),
    );
  }

  Widget _body(BuildContext context, ExamState state) {
    return Column(
      children: [
        SizedBox(height: 100),
        _nameField(context, state),
        SizedBox(width: 20),
        _startButton(context, state),
        Expanded(child: _currentExamQuestion(context, state)),
      ],
    );
  }

  Widget _nameField(BuildContext context, ExamState state) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter your name',
      ),
      onChanged: (value) => context.read<ExamCubit>().nameChanged(value),
      validator: (value) => state.isNameValid ? null : 'Name is too short',
    );
  }

  Widget _startButton(BuildContext context, ExamState state) {
    return state.showGetQuestionButton
        ? ElevatedButton(
            onPressed: () {
//                 context.read<ExamCubit>().takeTutorial();
            },
            child: Text(
              'Start Exam',
              style: TextStyle(fontSize: 20),
            ),
          )
        : SizedBox.shrink();
  }

  Widget _currentExamQuestion(BuildContext context, ExamState state) {
    return Text('hello');
  }
}
