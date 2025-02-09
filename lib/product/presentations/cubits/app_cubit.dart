import 'package:carecomm/core/presentation/blocs/base_states/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppCubit extends Cubit<BaseState> {
  AppCubit() : super(const BaseState());

  static ThemeMode theme = ThemeMode.light;
  void changeTheme() {
    if (theme == ThemeMode.light) {
      theme = ThemeMode.dark;
    } else {
      theme = ThemeMode.light;
    }
    emit(state.setInProgressState());
  }
}
