import 'package:triptip/bloc/models/agency_model.dart';

// States
// Base state class
abstract class AgencyState {}

// Initial state
class AgencyInitial extends AgencyState {}

// Loading state
class AgencyLoading extends AgencyState {}

// Login Success State
class LoginSuccess extends AgencyState {
  final AgencyModel agency;

  LoginSuccess({required this.agency});
}

// Signup Success State
class SignupSuccess extends AgencyState {
  final AgencyModel agency;

  SignupSuccess({required this.agency});
}

// Failure State
class AgencyFailure extends AgencyState {
  final String error;

  AgencyFailure({required this.error});
}
