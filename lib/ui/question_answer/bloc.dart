import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/service_locator.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_flutter/ui/question_answer/events.dart';
import 'package:umka_flutter/ui/question_answer/state.dart';

class QaBloc extends Bloc<QaEvent, QaState> {
  QaBloc() : super(QaState());

  @override
  Stream<QaState> mapEventToState(QaEvent event) async* {
    if (event is GotQuestion) {
      yield state.copyWith(question: event.question);
    } else if (event is AnswerChanged) {
      yield state.copyWith(enteredAnswer: event.answer);
    } else if (event is AnswerSubmitted) {
      yield* _mapSubmittedEventQaState(event);
    } else if (event is GotEvaluation) {
      yield state.copyWith(evaluation: event.evaluation);
    }
  }

  Stream<QaState> _mapSubmittedEventQaState(AnswerSubmitted event) async* {
    try {
      final evaluation = await umkaService.sendAnswer(event.answer);
      yield state.copyWith(evaluation: evaluation);
    } catch (err) {
      print(err);
    }
    yield state.copyWith(submissionStatus: Submitting());
  }
}
