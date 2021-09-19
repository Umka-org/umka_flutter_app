import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_proto/generated/umka.pb.dart';

@immutable
class QuizState extends Equatable {
  final String enteredName;
  final Question? question;
  final String enteredAnswer;
  final SubmissionStatus submissionStatus;
  final Evaluation? evaluation;

  bool get isNameValid => enteredName.length > 1;
  bool get isReadyToAnswer => isNameValid && question != null;
  bool get isAnswerValid => enteredAnswer.isNotEmpty;
  bool get showGetQuestionButton =>
      isNameValid && submissionStatus != SubmissionStatus.submitting;
  bool get showSubmitButton =>
      isReadyToAnswer && isAnswerValid && evaluation == null;
  bool get isAnswerCorrect => (evaluation?.mark == 5);

  QuizState({
    this.question,
    this.enteredName = '',
    this.enteredAnswer = '',
    this.submissionStatus = SubmissionStatus.initial,
    this.evaluation,
  });

  QuizState reset() => QuizState(
        submissionStatus: SubmissionStatus.submitting,
        enteredName: this.enteredName,
      );

  QuizState copyWith({
    String? enteredName,
    Question? question,
    String? enteredAnswer,
    SubmissionStatus? submissionStatus,
    Evaluation? evaluation,
  }) =>
      QuizState(
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
