import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_proto/generated/umka.pb.dart';

class QaState {
  final Student? student;
  final Question? question;
  final String enteredAnswer;
  final SubmissionStatus submissionStatus;
  final Evaluation? evaluation;

  QaState({
    this.student,
    this.question,
    this.enteredAnswer = '',
    this.submissionStatus = const InitialSubmissionStatus(),
    this.evaluation,
  });

  QaState copyWith({
    Student? student,
    Question? question,
    bool? isLoading,
    String? enteredAnswer,
    SubmissionStatus? submissionStatus,
    Evaluation? evaluation,
  }) =>
      QaState(
        student: student ?? this.student,
        question: question ?? this.question,
        enteredAnswer: enteredAnswer ?? this.enteredAnswer,
        submissionStatus: submissionStatus ?? this.submissionStatus,
        evaluation: evaluation ?? this.evaluation,
      );
}
