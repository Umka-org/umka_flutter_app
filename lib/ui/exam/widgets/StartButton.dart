import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/ui/exam/exam_cubit.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';

class StartButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  const StartButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) => state.showGetQuestionButton
          ? ElevatedButton(
              onPressed: onPress,
              child: Text(
                text,
                style: TextStyle(fontSize: 20),
              ),
            )
          : SizedBox.shrink(),
    );
  }
}
