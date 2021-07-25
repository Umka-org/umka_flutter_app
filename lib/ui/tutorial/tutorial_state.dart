import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_proto/generated/umka.pb.dart';

@immutable
class TutorialState extends Equatable {
  final String enteredName;
  final List<AnsweredQuestion>? questions;
  final List<String> answers;
  final SubmissionStatus submissionStatus;

  bool get isNameValid => enteredName.length > 1;
  bool get showStartButton =>
      isNameValid && submissionStatus != SubmissionStatus.submitting;

  TutorialState({
    this.questions,
    this.enteredName = '',
    this.answers = const [],
    this.submissionStatus = SubmissionStatus.initial,
  });

  TutorialState reset() => TutorialState(
        submissionStatus: SubmissionStatus.submitting,
        enteredName: this.enteredName,
      );

  TutorialState copyWith({
    String? enteredName,
    List<AnsweredQuestion>? questions,
    List<String>? answers,
    SubmissionStatus? submissionStatus,
  }) =>
      TutorialState(
        enteredName: enteredName ?? this.enteredName,
        questions: questions ?? this.questions,
        answers: answers ?? this.answers,
        submissionStatus: submissionStatus ?? this.submissionStatus,
      );

  @override
  List<Object?> get props => [
        enteredName,
        questions,
        answers,
        submissionStatus,
      ];
}
