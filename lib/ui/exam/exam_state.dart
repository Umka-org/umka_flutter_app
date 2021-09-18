import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_proto/generated/umka.pb.dart';

@immutable
class ExamState extends Equatable {
  final String enteredName;
  final Exam? exam;
  final int questionIndex;
  final String enteredAnswer;
  final SubmissionStatus submissionStatus;
  final Evaluation? evaluation;

  ExamState({
    this.exam,
    this.questionIndex = 0,
    this.enteredName = '',
    this.enteredAnswer = '',
    this.submissionStatus = SubmissionStatus.initial,
    this.evaluation,
  });

  bool get isNameValid => enteredName.length > 1;

  bool get isAnswerValid => enteredAnswer.isNotEmpty;

  bool get showStartButton => isNameValid && !submissionStatus.isSubmitting;

  bool get isEvaluated => evaluation != null;

  Question? get currentQuestion {
    if (null == exam || exam!.questions.length < questionIndex + 1) {
      return null;
    }
    return exam!.questions[questionIndex];
  }

  bool get showSubmitButton =>
      !submissionStatus.isSubmitting &&
      enteredAnswer.isNotEmpty &&
      isAnswerValid &&
      currentQuestion != null;

  Student get student => Student(id: 42, name: enteredName);

  ExamState reset() => ExamState();

  ExamState copyWith({
    String? enteredName,
    Exam? exam,
    int? questionIndex,
    String? enteredAnswer,
    SubmissionStatus? submissionStatus,
    Evaluation? evaluation,
  }) =>
      ExamState(
        enteredName: enteredName ?? this.enteredName,
        exam: exam ?? this.exam,
        questionIndex: questionIndex ?? this.questionIndex,
        enteredAnswer: enteredAnswer ?? this.enteredAnswer,
        submissionStatus: submissionStatus ?? this.submissionStatus,
        evaluation: evaluation ?? this.evaluation,
      );

  @override
  List<Object?> get props => [
        enteredName,
        exam,
        enteredAnswer,
        submissionStatus,
        evaluation,
      ];

  @override
  String toString() {
    return 'ExamState{enteredName: $enteredName,\n exam: $exam, \n'
        'enteredAnswer: $enteredAnswer,\n submissionStatus: $submissionStatus, '
        '\nevaluation: $evaluation}\n\n';
  }
}
