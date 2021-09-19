import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/exam/widgets/enter_name_widget.dart';
import 'package:umka_flutter/ui/exam/exam_cubit.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';
import 'package:umka_flutter/ui/exam/widgets/exam_question.dart';
import 'package:umka_flutter/ui/exam/widgets/exam_result_widget.dart';
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
                  EnterNameWidget(),
                  AppButton(
                    text: 'Start New Exam',
                    show: state.showStartButton,
                    onPress: () {
                      context.read<ExamCubit>().takeExam(state.enteredName);
                    },
                  ),
                  ExamQuestion(),
                  ExamResultWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
