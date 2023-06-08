import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_onboard_event.dart';
part 'user_onboard_state.dart';

class UserOnboardBloc extends Bloc<UserOnboardEvent, UserOnboardState> {
  UserOnboardBloc() : super(UserOnboardInitial()) {
    on<UserOnboardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
