// import 'package:triptip/data/models/agency/agency_model.dart';

// // States
// // Base state class
// abstract class AgencyState {}

// // Initial state
// class AgencyInitial extends AgencyState {}

// // Loading state
// class AgencyLoading extends AgencyState {}

// class AgencyLoaded extends AgencyState {
//   final AgencyModel agency;

//   AgencyLoaded({required this.agency});
// }

// // Login Success State
// class LoginSuccess extends AgencyState {
//   final AgencyModel agency;

//   LoginSuccess({required this.agency});
// }

// // Signup Success State
// class SignupSuccess extends AgencyState {
//   final AgencyModel agency;

//   SignupSuccess({required this.agency});
// }

// // Failure State
// class AgencyFailure extends AgencyState {
//   final String error;

//   AgencyFailure({required this.error});
// }



// //Edit Profile Success State
// class EditProfileSuccess extends AgencyState {
//   final AgencyModel agency;

//   EditProfileSuccess({required this.agency});
// }
// //Edit Profile Failure State
// class EditProfileFailure extends AgencyState {
//   final String error;

//   EditProfileFailure({required this.error});
// }


// agency_state.dart

import 'package:triptip/data/models/agency/agency_model.dart';

abstract class AgencyState {
  final AgencyModel? agency;  // Base property for all states
  
  const AgencyState({this.agency});
}

class AgencyInitial extends AgencyState {
  AgencyInitial() : super(agency: null);
}

class AgencyLoading extends AgencyState {
  AgencyLoading() : super(agency: null);
}

class AgencyLoaded extends AgencyState {
  final AgencyModel agency;

  AgencyLoaded({required this.agency}) : super(agency: agency);
}

class LoginSuccess extends AgencyState {
  final AgencyModel agency;

  LoginSuccess({required this.agency}) : super(agency: agency);
}

class SignupSuccess extends AgencyState {
  final AgencyModel agency;

  SignupSuccess({required this.agency}) : super(agency: agency);
}

class AgencyFailure extends AgencyState {
  final String error;

  AgencyFailure({required this.error}) : super(agency: null);
}

class EditProfileSuccess extends AgencyState {
  final AgencyModel agency;

  EditProfileSuccess({required this.agency}) : super(agency: agency);
}

class EditProfileFailure extends AgencyState {
  final String error;

  EditProfileFailure({required this.error}) : super(agency: null);
}