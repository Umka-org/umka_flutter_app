import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_proto/generated/umka.pb.dart';

@immutable
class QaState extends Equatable {
  final String enteredName;
  final Question? question;
  final String enteredAnswer;
  final SubmissionStatus submissionStatus;
  final Evaluation? evaluation;

  bool get isNameValid => enteredName.length > 3;

  bool get isReadyToAnswer => isNameValid && question != null;

  bool get isAnswerValid => enteredAnswer.isNotEmpty;

  bool get isReadyToSubmitAnswer => isReadyToAnswer && isAnswerValid;

  QaState({
    this.question,
    this.enteredName = '',
    this.enteredAnswer = '',
    this.submissionStatus = const InitialSubmissionStatus(),
    this.evaluation,
  });

  QaState reset() => QaState(
        submissionStatus: Submitting(),
        enteredName: this.enteredName,
      );

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

  @override
  List<Object?> get props => [
        enteredName,
        question,
        enteredAnswer,
        submissionStatus,
        evaluation,
      ];

  @override
  String toString() {
    return 'QaState{enteredName: $enteredName,\n question: $question, \n'
        'enteredAnswer: $enteredAnswer,\n submissionStatus: $submissionStatus, '
        '\nevaluation: $evaluation}\n\n';
  }
}
