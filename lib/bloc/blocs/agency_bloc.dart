import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/bloc/events/agency_event.dart';
import 'package:triptip/bloc/states/agency_state.dart';
import 'package:triptip/bloc/repositories/agency_repo.dart';
import 'package:triptip/bloc/models/agency_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Bloc
class AgencyBloc extends Bloc<AgencyEvent, AgencyState> {
  final AgencyRepository repository;

  AgencyBloc({required this.repository}) : super(AgencyInitial()) {
    on<AgencyLoginSubmitted>(_onLoginSubmitted);
    on<AgencySignupSubmitted>(_onSignupSubmitted);
  }

  void _onSignupSubmitted(AgencySignupSubmitted event, Emitter<AgencyState> emit) async {
    final emailError = validateEmail(event.email);
    final passwordError = validatePassword(event.password);
    final nameError = validateAgencyName(event.name);
    final phoneError = validatePhoneNumber(event.phoneNumber);
    final locationError = validateLocationInt(event.location);

    if (emailError != null || passwordError != null || nameError != null || phoneError != null || locationError != null) {
      emit(AgencyFailure(error: 'Validation failed.'));
      return;
    }

    emit(AgencyLoading());

    try {
      final agency = AgencyModel(
        name: event.name,
        email: event.email,
        password: event.password,
        phoneNumber: event.phoneNumber,
        location: event.location,
      );
      final result = await repository.signUpAgency(agency);
      emit(SignupSuccess(agency: result));
    } catch (e) {
      emit(AgencyFailure(error: e.toString()));
    }
  }

  void _onLoginSubmitted(AgencyLoginSubmitted event, Emitter<AgencyState> emit) async {
    final emailError = validateEmail(event.email);
    final passwordError = validatePassword(event.password);

    if (emailError != null || passwordError != null) {
      emit(AgencyFailure(error: 'Validation failed.'));
      return;
    }

    emit(AgencyLoading());

    try {
      final user = await repository.loginAgency(email: event.email, password: event.password);
      await _storeUserData(user);
      emit(LoginSuccess(agency: user));
    } catch (e) {
      emit(AgencyFailure(error: e.toString()));
    }
  }

  Future<void> _storeUserData(AgencyModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', user.email);
    await prefs.setString('user_role', user.password);
  }
}
