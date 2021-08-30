import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_proto/generated/umka.pb.dart';

@immutable
class ExamState extends Equatable {
  final String enteredName;
  final List<Question>? questions;
  final Question? currentExamQuestion;
  final String enteredAnswer;
  final SubmissionStatus submissionStatus;
  final Evaluation? evaluation;

  bool get isNameValid => enteredName.length > 1;
  bool get isAnswerValid => enteredAnswer.isNotEmpty;
  bool get showGetQuestionButton =>
      isNameValid && submissionStatus != SubmissionStatus.submitting;

  ExamState({
    this.questions,
    this.currentExamQuestion,
    this.enteredName = '',
    this.enteredAnswer = '',
    this.submissionStatus = SubmissionStatus.initial,
    this.evaluation,
  });

  ExamState reset() => ExamState();

  ExamState copyWith({
    String? enteredName,
    List<Question>? questions,
    Question? currentExamQuestion,
    String? enteredAnswer,
    SubmissionStatus? submissionStatus,
    Evaluation? evaluation,
  }) =>
      ExamState(
        enteredName: enteredName ?? this.enteredName,
        questions: questions ?? this.questions,
        currentExamQuestion: currentExamQuestion ?? this.currentExamQuestion,
        enteredAnswer: enteredAnswer ?? this.enteredAnswer,
        submissionStatus: submissionStatus ?? this.submissionStatus,
        evaluation: evaluation ?? this.evaluation,
      );

  @override
  List<Object?> get props => [
        enteredName,
        questions,
        enteredAnswer,
        submissionStatus,
        evaluation,
      ];

  @override
  String toString() {
    return 'ExamState{enteredName: $enteredName,\n questions: $questions, \n'
        'enteredAnswer: $enteredAnswer,\n submissionStatus: $submissionStatus, '
        '\nevaluation: $evaluation}\n\n';
  }
}
