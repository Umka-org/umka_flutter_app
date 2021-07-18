import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/core/submission_status.dart';
import 'package:umka_flutter/ui/tutorial/tutorial_state.dart';
import 'package:umka_proto/generated/umka.pb.dart';

class TutorialCubit extends Cubit<TutorialState> {
  final UmkaService umkaService;

  TutorialCubit(this.umkaService) : super(TutorialState());

  void nameChanged(String name) => emit(state.copyWith(enteredName: name));

  void takeTutorial() async {
    reset();
    final student = Student()
      ..id = state.enteredName.hashCode
      ..name = state.enteredName;

    try {
      await for (var qustionAnswer in umkaService.getTutorial(student)) {
        emit(state.copyWith(
          questions: [
            ...(state.questions ?? []),
            qustionAnswer,
          ],
        ));
      }
      emit(state.copyWith(submissionStatus: SubmissionStatus.success));
    } catch (err) {
      emit(state.copyWith(submissionStatus: SubmissionStatus.failure));
      print(err);
    }
  }

  void questionChecked(int index) => emit(state.copyWith(checkedQuestions: [
        ...state.checkedQuestions,
        index,
      ]));

  void reset() => emit(state.reset());
}
