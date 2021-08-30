import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/ui/tutorial/tutorial_cubit.dart';
import 'package:umka_proto/generated/umka.pb.dart';

class QuestionItem extends StatefulWidget {
  final AnsweredQuestion question;
  final bool isChecked;
  final int index;

  const QuestionItem({
    Key? key,
    required this.index,
    required this.question,
    required this.isChecked,
  }) : super(key: key);

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  String enteredAnswer = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(minWidth: 150),
            child: Text(widget.question.question.text.replaceFirst('?', ''))),
        SizedBox(
            width: 50,
            child: TextField(onChanged: (value) {
              setState(() {
                enteredAnswer = value;
              });
            })),
        Spacer(),
        Checkbox(
          value: widget.isChecked,
          activeColor: enteredAnswer == widget.question.answer
              ? Colors.green
              : Colors.red,
          onChanged: (value) {
            if (value ?? false) {
              context.read<TutorialCubit>().questionChecked(widget.index);
            }
          },
        ),
      ],
    );
  }
}
