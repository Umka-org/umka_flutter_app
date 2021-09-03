import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';
import 'package:umka_proto/generated/umka.pb.dart';

class ExamCubit extends Cubit<ExamState> {
  final UmkaService umkaService;

  ExamCubit(this.umkaService) : super(ExamState());

  void nameChanged(String name) => emit(state.copyWith(enteredName: name));

  void takeExam(String name) async {
    final student = Student()
      ..name = name
      ..id = 42;

    final exam = await umkaService.getExam(student);

    if (null != exam) {
      emit(state.copyWith(exam: exam));
    }
  }
}
