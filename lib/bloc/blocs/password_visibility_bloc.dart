import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/bloc/events/password_event_visible.dart';
import 'package:triptip/bloc/states/password_state_visible.dart';


// Bloc
class PasswordVisibilityBloc
    extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc()
      : super(PasswordVisibilityState(isPasswordVisible: false)) {
    on<TogglePasswordVisibility>((event, emit) {
      emit(
          PasswordVisibilityState(isPasswordVisible: !state.isPasswordVisible));
    });
  }
}
