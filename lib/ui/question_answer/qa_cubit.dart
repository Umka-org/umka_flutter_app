import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_flutter/ui/question_answer/state.dart';
import 'package:umka_proto/generated/umka.pb.dart';

class QaCubit extends Cubit<QaState> {
  final UmkaService umkaService;
  QaCubit(this.umkaService) : super(QaState());

  void nameChanged(String name) => emit(state.copyWith(enteredName: name));
  void answerChanged(String answer) =>
      emit(state.copyWith(enteredAnswer: answer));

  void getRandomQuestion() async {
    reset();
    await Future.delayed(Duration(milliseconds: 300));
    final student = Student()
      ..id = state.enteredName.hashCode
      ..name = state.enteredName;

    try {
      final question = await umkaService.getRandomQuestion(student);
      emit(state.copyWith(
          question: question, submissionStatus: SubmissionStatus.success));
    } catch (err) {
      emit(state.copyWith(submissionStatus: SubmissionStatus.failure));
      print(err);
    }
  }

  void reset() => emit(state.reset());

  void answerSubmitted(String text) async {
    emit(state.copyWith(submissionStatus: SubmissionStatus.submitting));
    final student = Student()
      ..id = 101
      ..name = state.enteredName;
    final answer = Answer()
      ..question = state.question!
      ..id = 7
      ..text = text
      ..student = student;
    try {
      final evaluation = await umkaService.sendAnswer(answer);
      await Future.delayed(Duration(milliseconds: 300));
      emit(state.copyWith(
          evaluation: evaluation, submissionStatus: SubmissionStatus.success));
    } catch (err) {
      print(err);
      emit(state.copyWith(submissionStatus: SubmissionStatus.failure));
    }
  }
}
