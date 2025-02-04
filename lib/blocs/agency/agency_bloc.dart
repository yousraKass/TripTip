import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/blocs/agency/agency_event.dart';
import 'package:triptip/blocs/agency/agency_state.dart';
import 'package:triptip/data/repositories/agency/agency_repo.dart';
import 'package:triptip/data/models/agency/agency_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

// Bloc
class AgencyBloc extends Bloc<AgencyEvent, AgencyState> {
  final AgencyRepository repository;

  AgencyBloc({required this.repository}) : super(AgencyInitial()) {
    on<AgencyLoginSubmitted>(_onLoginSubmitted);
    on<AgencySignupSubmitted>(_onSignupSubmitted);
    on<FetchAgencyById>(_onFetchAgencyById);
  }

  void _onSignupSubmitted(
      AgencySignupSubmitted event, Emitter<AgencyState> emit) async {
    final emailError = validateEmail(event.email);
    final passwordError = validatePassword(event.password);
    final nameError = validateAgencyName(event.name);
    final phoneError = validatePhoneNumber(event.phoneNumber);
    final locationError = validateLocationInt(int.tryParse(event.location));
    final token = await SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('user_token');
    });
    if (emailError != null ||
        passwordError != null ||
        nameError != null ||
        phoneError != null ||
        locationError != null) {
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
        aboutUs: event.aboutUs,
        offers: event.offers ?? [],
      );
      final result = await repository.signUpAgency(agency);
      emit(SignupSuccess(agency: result));
    } catch (e) {
      emit(AgencyFailure(error: e.toString()));
    }
  }

  void _onLoginSubmitted(
      AgencyLoginSubmitted event, Emitter<AgencyState> emit) async {
    final emailError = validateEmail(event.email);
    final passwordError = validatePassword(event.password);

    if (emailError != null || passwordError != null) {
      emit(AgencyFailure(error: 'Validation failed.'));
      return;
    }

    emit(AgencyLoading());

    try {
      final user = await repository.loginAgency(
          email: event.email, password: event.password);
      await _storeUserData(user);
      emit(LoginSuccess(agency: user));
    } catch (e) {
      emit(AgencyFailure(error: e.toString()));
    }
  }

  Future<AgencyModel> _storeUserData(AgencyModel user) async {
    return AgencyModel(
      name: user.name,
      email: user.email,
      password: user.password,
      phoneNumber: user.phoneNumber,
      location: user.location,
      aboutUs: user.aboutUs,
      offers: user.offers,
    );
  }

  Future<AgencyModel> fetchAgencyData(int id, String token) async {
    final user = await repository.fetchAgencyData(id, token);
    await _storeUserData(user);
    return user;
  }

  Future<AgencyModel>  editAgencyProfile(AgencyModel agency, String token) async {
    return await repository.editAgencyProfile(agency, token);
  }

  void _onFetchAgencyById(
      FetchAgencyById event, Emitter<AgencyState> emit) async {
    emit(AgencyLoading());
    try {
      final agency =
          await repository.fetchAgencyData(event.agencyId, event.token);
      emit(AgencyLoaded(agency: agency));
    } catch (e) {
      emit(AgencyFailure(error: e.toString()));
    }
  }

  // void _onFetchAgencyById(
  //     FetchAgencyById event, Emitter<AgencyState> emit) async {
  //   emit(AgencyLoading());
  //   try {
  //     // Create mock data directly instead of fetching
  //     final mockAgency = AgencyModel(
  //       id: 1,
  //       name: "Test Travel Agency",
  //       email: "test@agency.com",
  //       password: "",
  //       phoneNumber: "+1234567890",
  //       location: "New York",
  //       aboutUs:
  //           "We are a test travel agency providing the best travel experiences!",
  //       offers: [
  //         OfferModel(
  //           id: 1,
  //           cityName: "Paris",
  //           countryName: "France",
  //           price: 1200.0,
  //           startDate: DateTime.now().toIso8601String(),
  //           endDate: DateTime.now().add(Duration(days: 7)).toIso8601String(),
  //           descriptionText: "Amazing Paris tour!",
  //           category: "City Tour",
  //           days: 7,
  //           image: "assets/images/paris.jpg",
  //         ),
  //         OfferModel(
  //           id: 2,
  //           cityName: "Tokyo",
  //           countryName: "Japan",
  //           price: 2000.0,
  //           startDate: DateTime.now().toIso8601String(),
  //           endDate: DateTime.now().add(Duration(days: 10)).toIso8601String(),
  //           descriptionText: "Explore Tokyo!",
  //           category: "Cultural Tour",
  //           days: 10,
  //           image: "assets/images/tokyo.jpg",
  //         ),
  //       ],
  //     );

  //     emit(AgencyLoaded(agency: mockAgency));
  //   } catch (e) {
  //     emit(AgencyFailure(error: e.toString()));
  //   }
  // }

  void _onEditProfileSubmitted(
      AgencyEditProfileSubmitted event, Emitter<AgencyState> emit) async {
    final emailError = validateEmail(event.email);
    final passwordError = validatePassword(event.password);
    final nameError = validateAgencyName(event.name);
    final phoneError = validatePhoneNumber(event.phoneNumber);
    final locationError = validateLocationInt(int.tryParse(event.location));

    if (emailError != null ||
        passwordError != null ||
        nameError != null ||
        phoneError != null ||
        locationError != null) {
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
        aboutUs: event.aboutUs,
        offers: event.offers ?? [],
      );
      if (event.token == null) {
        emit(AgencyFailure(error: 'Token is null.'));
        return;
      }
      final result = await repository.editAgencyProfile(agency, event.token!);
      emit(EditProfileSuccess(agency: result));
    } catch (e) {
      emit(EditProfileFailure(error: e.toString()));
    }
  }
}
