import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umka_flutter/ui/core/bloc_observer.dart';
import 'package:umka_flutter/ui/umka_app.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(UmkaApp());
}
