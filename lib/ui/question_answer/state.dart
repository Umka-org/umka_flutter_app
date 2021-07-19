import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_proto/generated/umka.pb.dart';

class QaState {
  final Question? question;
  final bool isLoading;
  final String enteredAnswer;
  final SubmissionStatus submissionStatus;
  final Evaluation? evaluation;

  QaState({
    this.question,
    this.isLoading = true,
    this.enteredAnswer = '',
    this.submissionStatus = const InitialSubmissionStatus(),
    this.evaluation,
  });

  QaState copyWith({
    Question? question,
    bool? isLoading,
    String? enteredAnswer,
    SubmissionStatus? submissionStatus,
    Evaluation? evaluation,
  }) =>
      QaState(
        question: question ?? this.question,
        isLoading: isLoading ?? this.isLoading,
        enteredAnswer: enteredAnswer ?? this.enteredAnswer,
        submissionStatus: submissionStatus ?? this.submissionStatus,
        evaluation: evaluation ?? this.evaluation,
      );
}
