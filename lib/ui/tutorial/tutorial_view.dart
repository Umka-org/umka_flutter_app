import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/kit/app_button.dart';
import 'package:umka_flutter/ui/tutorial/question_item.dart';
import 'package:umka_flutter/ui/tutorial/tutorial_cubit.dart';
import 'package:umka_flutter/ui/tutorial/tutorial_state.dart';

class TutorialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TutorialCubit(context.read<UmkaService>()),
      child: BlocBuilder<TutorialCubit, TutorialState>(
        builder: (context, state) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _body(context, state),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, TutorialState state) {
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
        Expanded(child: _questionsList(context, state)),
      ],
    );
  }

  Widget _nameField(BuildContext context, TutorialState state) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Enter your name',
      ),
      onChanged: (value) => context.read<TutorialCubit>().nameChanged(value),
      validator: (value) => state.isNameValid ? null : 'Name is too short',
    );
  }

  Widget _startButton(BuildContext context, TutorialState state) {
    return SizedBox(
      width: 100,
      child: state.showStartButton
          ? AppButton(
              text: 'Start',
              onPress: () {
                context.read<TutorialCubit>().takeTutorial();
              })
          : SizedBox.shrink(),
    );
  }

  Widget _questionsList(BuildContext context, TutorialState state) =>
      ListView.separated(
          separatorBuilder: (context, _) =>
              Divider(color: Colors.transparent, height: 20),
          itemCount: state.questions?.length ?? 0,
          itemBuilder: (context, index) => state.questions == null
              ? SizedBox.shrink()
              : QuestionItem(
                  key: ValueKey(state.questions![index]),
                  isChecked: state.checkedQuestions.contains(index),
                  index: index,
                  question: state.questions![index]));
}
