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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(flex: 3, child: _nameField(context, state)),
            SizedBox(width: 20),
            Flexible(flex: 1, child: _startButton(context, state)),
          ],
        ),
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
    return SizedBox(
      width: 100,
      child: state.showStartButton
          ? ElevatedButton(
              onPressed: () {
                context.read<ExamCubit>().takeTutorial();
              },
              child: Text(
                'Start',
                style: TextStyle(fontSize: 20),
              ),
            )
          : SizedBox.shrink(),
    );
  }

  Widget _currentExamQuestion(BuildContext context, ExamState state) {}
}
