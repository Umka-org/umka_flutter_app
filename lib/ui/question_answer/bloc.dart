import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/service_locator.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_flutter/ui/question_answer/events.dart';
import 'package:umka_flutter/ui/question_answer/state.dart';
import 'package:umka_proto/generated/umka.pb.dart';

class QaBloc extends Bloc<QaEvent, QaState> {
  QaBloc() : super(QaState());

  @override
  Stream<QaState> mapEventToState(QaEvent event) async* {
    if (event is GetRandomQuestion) {
      yield* _mapGetRandomQuestionToQaState();
    } else if (event is GotQuestion) {
      yield state.copyWith(question: event.question);
    } else if (event is AnswerChanged) {
      yield state.copyWith(enteredAnswer: event.answer);
    } else if (event is NameChanged) {
      yield state.copyWith(enteredName: event.name);
    } else if (event is AnswerSubmitted) {
      yield* _mapSubmittedEventQaState(event);
    } else if (event is GotEvaluation) {
      yield state.copyWith(evaluation: event.evaluation);
    }
  }

  Stream<QaState> _mapSubmittedEventQaState(AnswerSubmitted event) async* {
    final student = Student()
      ..id = 101
      ..name = state.enteredName;
    final answer = Answer()
      ..id = 7
      ..student = student;
    try {
      final evaluation = await umkaService.sendAnswer(answer);
      yield state.copyWith(evaluation: evaluation);
    } catch (err) {
      print(err);
    }
    yield state.copyWith(submissionStatus: Submitting());
  }

  Stream<QaState> _mapGetRandomQuestionToQaState() async* {
    final student = Student()
      ..id = 101
      ..name = state.enteredName;
    try {
      final question = await umkaService.getRandomQuestion(student);
      add(GotQuestion(question));
    } catch (err) {
      print(err);
    }
  }
}
