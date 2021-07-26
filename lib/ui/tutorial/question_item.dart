import 'package:flutter/material.dart';
import 'package:umka_proto/generated/umka.pb.dart';

class QuestionItem extends StatelessWidget {
  final AnsweredQuestion question;
  final bool checked;
  final Function checkHandler;
  final int index;

  const QuestionItem({
    Key? key,
    required this.index,
    required this.question,
    required this.checked,
    required this.checkHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(question.question.text.replaceFirst('?', '')),
        SizedBox(width: 50, child: TextField()),
        Checkbox(
          value: checked,
          onChanged: (_) => () => checkHandler(index),
        ),
        Text(question.answer),
      ],
    );
  }
}
