import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/notifiers/user_notifier.dart';
import 'package:rick_and_morty_app/src/presentation/states/user_state.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) => UserNotifier());
