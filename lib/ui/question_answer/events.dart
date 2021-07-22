import 'package:umka_proto/generated/umka.pb.dart';

class QaEvent {}

class GetRandomQuestion extends QaEvent {}

class GotQuestion extends QaEvent {
  final Question question;

  GotQuestion(this.question);
}

class NameChanged extends QaEvent {
  final String name;

  NameChanged(this.name);
}

class AnswerChanged extends QaEvent {
  final String answer;

  AnswerChanged(this.answer);
}

class AnswerSubmitted extends QaEvent {}

class GotEvaluation extends QaEvent {
  final Evaluation evaluation;

  GotEvaluation(this.evaluation);
}
