abstract class SubmissionStatus {
  const SubmissionStatus();
}

class InitialSubmissionStatus extends SubmissionStatus {
  const InitialSubmissionStatus();
}

class Submitting extends SubmissionStatus {}

class SubmissionSuccess extends SubmissionStatus {}

class SubmissionFailure extends SubmissionStatus {
  final Object exception;

  SubmissionFailure(this.exception);
}
