import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/ui/exam/exam_cubit.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';

class EnterNameWidget extends StatefulWidget {
  const EnterNameWidget({Key? key}) : super(key: key);

  @override
  State<EnterNameWidget> createState() => _EnterNameWidgetState();
}

class _EnterNameWidgetState extends State<EnterNameWidget> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamCubit, ExamState>(builder: (context, state) {
      if(state.enteredName.isEmpty) {
        _controller.clear();
      }
      return TextField(
        controller: _controller,
        onChanged: (value) => context.read<ExamCubit>().nameChanged(value),
        decoration: InputDecoration(
          hintText: 'Enter your name',
        ),
      );
    });
  }
}
