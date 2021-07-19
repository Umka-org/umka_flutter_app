import 'package:flutter_bloc/flutter_bloc.dart';
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
      yield state.copyWith(submissionStatus: Submitting());
    } else if (event is GotEvaluation) {
      yield state.copyWith(evaluation: event.evaluation);
    }
  }
}
