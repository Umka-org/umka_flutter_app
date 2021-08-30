import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/exam/exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final UmkaService umkaService;

  ExamCubit(this.umkaService) : super(ExamState());

  void nameChanged(String name) => emit(state.copyWith(enteredName: name));
}
