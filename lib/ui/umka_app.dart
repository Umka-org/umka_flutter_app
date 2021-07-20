import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/services/umka_service.dart';
import 'package:umka_flutter/ui/home/home_screen.dart';
import 'package:umka_flutter/ui/question_answer/bloc.dart';

class UmkaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QaBloc>(
          create: (context) => QaBloc(),
        ),
      ],
      child: MaterialApp(
        home: RepositoryProvider(
          create: (context) => UmkaService(),
          child: HomeScreen(),
        ),
      ),
    );
  }
}
