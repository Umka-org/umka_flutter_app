import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/ui/core/utils.dart';
import 'package:umka_flutter/ui/exam/exam_cubit.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';

class ExamResultWidget extends StatelessWidget {
  const ExamResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
        builder: (context, state) => state.isEvaluated
            ? Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    '${state.student.name}!\n\nYour Exam Score is '
                    '${state.evaluation?.mark}%',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      context.read<ExamCubit>().newExam();
                    },
                    child: Text(
                      'OK ${getEmojiByScore(state.evaluation?.mark ?? 0)}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ],
              )
            : SizedBox.shrink());
  }
}
