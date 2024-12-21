import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/logic/form_validators.dart';
import 'package:triptip/bloc/events/client/client_event.dart';
import 'package:triptip/bloc/states/client/client_state.dart';
import 'package:triptip/bloc/models/client/client_model.dart';
import 'package:triptip/bloc/repositories/client/client_repo.dart';

// Bloc
class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepository repository;

  ClientBloc({required this.repository}) : super(ClientInitial()) {
    on<ClientSignupSubmitted>(_onSignupSubmitted);
     on<ClientLoginSubmitted>(_onLoginSubmittedClient);
  }

  void _onSignupSubmitted(
      ClientSignupSubmitted event, Emitter<ClientState> emit) async {
    // Validate fields before processing signup logic
    final firstnameError = validateName(event.firstname);
    final lastnameError = validateName(event.lastname);
    final birthdateError = validateDate(event.birthdate);
    final emailError = validateEmail(event.email);
    final passwordError = validatePassword(event.password);
    final wilayaError = validateLocationInt(event.wilaya);


    if (firstnameError != null) {
      emit(ClientFailure(error: firstnameError));
      return;
    }
    if (lastnameError != null) {
      emit(ClientFailure(error: lastnameError));
      return;
    }
    if (birthdateError != null) {
      emit(ClientFailure(error: birthdateError));
      return;
    }
    if (emailError != null) {
      emit(ClientFailure(error: emailError));
      return;
    }
    if (passwordError != null) {
      emit(ClientFailure(error: passwordError));
      return;
    }
    if(wilayaError != null){
       emit(ClientFailure(error: wilayaError));
      return;
    }

    emit(ClientLoading());
    try {
      final client = ClientModel(
        firstname: event.firstname,
        lastname: event.lastname,
        email: event.email,
        password: event.password,
        birthdate: event.birthdate,
        wilayaID: event.wilaya,
      );

      final result = await repository.signUp(client);
      emit(ClientSuccess(client: result));
    } catch (e) {
      emit(ClientFailure(error: e.toString()));
    }
  }

  void _onLoginSubmittedClient(ClientLoginSubmitted event, Emitter<ClientState> emit) async {
    // Validate email and password
    final emailError = validateEmail(event.email);
    final passwordError = validatePassword(event.password);

    if (emailError != null) {
      emit(ClientFailure(error: emailError));
      return;
    }
    if (passwordError != null) {
      emit(ClientFailure(error: passwordError));
      return;
    }

    // Emit loading state
    emit(ClientLoading());

    try {
      // Call the repository to login and fetch user data
      final user = await repository.loginClient(
        email: event.email,
        password: event.password,
        
      );
      // Emit success state
      emit(ClientSuccess(client: user));
    } catch (e) {
      // Emit failure state with error message
      emit(ClientFailure(error: e.toString()));
    }
  }

}
