enum SubmissionStatus { initial, submitting, success, failure }

extension SubmissionStatusX on SubmissionStatus {
  bool get isInitial => this == SubmissionStatus.initial;
  bool get isSubmitting => this == SubmissionStatus.submitting;
  bool get isSuccess => this == SubmissionStatus.success;
  bool get isFailure => this == SubmissionStatus.failure;
}
