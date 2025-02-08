import 'package:triptip/data/models/agency/agency_model.dart';


abstract class AgencyState {
  final AgencyModel? agency;  // Base property for all states
  
  const AgencyState({this.agency});
}

class PublicAgencyLoaded extends AgencyState {
  final AgencyModel agency;

  PublicAgencyLoaded({required this.agency}) : super(agency: agency);
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