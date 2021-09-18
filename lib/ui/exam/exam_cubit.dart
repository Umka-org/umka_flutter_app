import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';
import 'package:umka_proto/generated/umka.pb.dart';

class ExamCubit extends Cubit<ExamState> {
  final UmkaService umkaService;
  StreamController<Answer>? answersStream;

  ExamCubit(this.umkaService) : super(ExamState());

  void nameChanged(String name) => emit(state.copyWith(enteredName: name));

  void answerChanged(String answer) =>
      emit(state.copyWith(enteredAnswer: answer));

  void takeExam(String name) async {
    final exam = await umkaService.getExam(state.student);

    if (null != exam) {
      emit(state.copyWith(exam: exam));
    }

    answersStream = StreamController();

    final evaluation =
        await umkaService.takeExam(state.student.name, answersStream!.stream);

    emit(state.copyWith(evaluation: evaluation));
  }

  void sendAnswer(String enteredAnswer) async {
    final answer = Answer(
      id: state.questionIndex,
      student: state.student,
      question: state.currentQuestion,
      text: enteredAnswer,
    );
    answersStream?.add(answer);
    emit(state.copyWith(
      questionIndex: state.questionIndex + 1,
      enteredAnswer: '',
    ));
    if (state.questionIndex == state.exam!.questions.length) {
      await answersStream?.close();
    }
  }
}
