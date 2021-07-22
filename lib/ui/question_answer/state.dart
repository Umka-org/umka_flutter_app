import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_proto/generated/umka.pb.dart';

class QaState {
  final String enteredName;
  final Question? question;
  final String enteredAnswer;
  final SubmissionStatus submissionStatus;
  final Evaluation? evaluation;

  bool get isValidAnswer => enteredAnswer.isNotEmpty;
  bool get isValidName => enteredAnswer.length > 3;

  QaState({
    this.question,
    this.enteredName = '',
    this.enteredAnswer = '',
    this.submissionStatus = const InitialSubmissionStatus(),
    this.evaluation,
  });

  QaState copyWith({
    String? enteredName,
    Question? question,
    bool? isLoading,
    String? enteredAnswer,
    SubmissionStatus? submissionStatus,
    Evaluation? evaluation,
  }) =>
      QaState(
        enteredName: enteredName ?? this.enteredName,
        question: question ?? this.question,
        enteredAnswer: enteredAnswer ?? this.enteredAnswer,
        submissionStatus: submissionStatus ?? this.submissionStatus,
        evaluation: evaluation ?? this.evaluation,
      );
}
