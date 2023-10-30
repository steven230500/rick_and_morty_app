// user_notifier.dart (puedes colocarlo en la carpeta 'notifiers')

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/data/models/user.dart';
import 'package:rick_and_morty_app/src/presentation/states/user_state.dart';
import 'package:rick_and_morty_app/src/utils/db_helper.dart';

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState.initial());

  Future<void> setUser(String name) async {
    if (name.isNotEmpty) {
      final user = await DBHelper.db.getUserByName(name);
      if (user == null) {
        await DBHelper.db.insertUser(name);
      }
      state = UserState.success(User(name));
    } else {
      state = UserState.error('Por favor ingrese un nombre');
    }
  }

  void setLoginSuccess(bool success) {
    state = state.copyWith(loginSuccess: success);
  }
}
