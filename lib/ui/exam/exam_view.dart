import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/exam/exam_cubit.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';
import 'package:umka_flutter/ui/exam/widgets/StartButton.dart';

class ExamView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExamCubit(context.read<UmkaService>()),
      child: BlocBuilder<ExamCubit, ExamState>(
        builder: (context, state) => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 100,
              ),
              child: Column(
                children: [
                  _NameWidget(),
                  StartButton(
                    text: 'Start Exam',
                    onPress: () {
                      context.read<ExamCubit>().takeExam(state.enteredName);
                    },
                  ),
                  _ExamQuestion(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) => TextFormField(
        decoration: InputDecoration(
          hintText: 'Enter your name',
        ),
        onChanged: (value) => context.read<ExamCubit>().nameChanged(value),
        validator: (value) => state.isNameValid ? null : 'Name is too short',
      ),
    );
  }
}

class _ExamQuestion extends StatelessWidget {
  const _ExamQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) => state.currentQuestion == null
          ? SizedBox.shrink()
          : Container(
              child: Text(state.currentQuestion!.text),
            ),
    );
  }
}
