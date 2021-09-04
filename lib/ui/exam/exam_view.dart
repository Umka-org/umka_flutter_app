import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/exam/exam_cubit.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';
import 'package:umka_flutter/ui/exam/widgets/exam_question.dart';
import 'package:umka_flutter/ui/kit/app_button.dart';

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
                  NameWidget(
                    onChanged: (value) =>
                        context.read<ExamCubit>().nameChanged(value),
                    validator: (_) =>
                        state.isNameValid ? null : 'Name is too short',
                  ),
                  AppButton(
                    text: 'Start Exam',
                    show: state.showStartButton,
                    onPress: () {
                      context.read<ExamCubit>().takeExam(state.enteredName);
                    },
                  ),
                  ExamQuestion(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const NameWidget({
    Key? key,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter your name',
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
