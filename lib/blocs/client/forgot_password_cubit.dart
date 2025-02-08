import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triptip/data/repositories/client/client_repo.dart';
import 'package:flutter/material.dart';
// States
abstract class ForgotPasswordState {
  final GlobalKey<FormState> formKey;
  const ForgotPasswordState({required this.formKey});
}

class ForgotPasswordInitial extends ForgotPasswordState {
  ForgotPasswordInitial({required GlobalKey<FormState> formKey}) 
    : super(formKey: formKey);
}

class ForgotPasswordLoading extends ForgotPasswordState {
  ForgotPasswordLoading({required GlobalKey<FormState> formKey}) 
    : super(formKey: formKey);
}

class ResetCodeSent extends ForgotPasswordState {
  ResetCodeSent({required GlobalKey<FormState> formKey}) 
    : super(formKey: formKey);
}

class ResetCodeVerified extends ForgotPasswordState {
  ResetCodeVerified({required GlobalKey<FormState> formKey}) 
    : super(formKey: formKey);
}

class PasswordUpdated extends ForgotPasswordState {
  PasswordUpdated({required GlobalKey<FormState> formKey}) 
    : super(formKey: formKey);
}

class ForgotPasswordError extends ForgotPasswordState {
  final String error;
  
  ForgotPasswordError({
    required this.error,
    required GlobalKey<FormState> formKey,
  }) : super(formKey: formKey);
}


// Cubit
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ClientRepository repository;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ForgotPasswordCubit({required this.repository}) 
    : super(ForgotPasswordInitial(formKey: GlobalKey<FormState>()));

  Future<void> sendResetCode(String email) async {
    emit(ForgotPasswordLoading(formKey: formKey));
    try {
      await repository.sendResetCode(email);
      emit(ResetCodeSent(formKey: formKey));
    } catch (e) {
      emit(ForgotPasswordError(error: e.toString(), formKey: formKey));
    }
  }

  Future<void> verifyResetCode(String email, String code) async {
    emit(ForgotPasswordLoading(formKey: formKey));
    try {
      await repository.verifyResetCode(email, code);
      emit(ResetCodeVerified(formKey: formKey));
    } catch (e) {
      emit(ForgotPasswordError(error: e.toString(), formKey: formKey));
    }
  }

  Future<void> updatePassword(String email, String newPassword) async {
    emit(ForgotPasswordLoading(formKey: formKey));
    try {
      await repository.updatePassword(email, newPassword);
      emit(PasswordUpdated(formKey: formKey));
    } catch (e) {
      emit(ForgotPasswordError(error: e.toString(), formKey: formKey));
    }
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void reset() {
    emit(ForgotPasswordInitial(formKey: formKey));
  }
}

/* class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ClientRepository repository;

  ForgotPasswordCubit({required this.repository}) : super(ForgotPasswordInitial());

  Future<void> sendResetCode(String email) async {
    emit(ForgotPasswordInitial());
    try {
      // Call repository to send reset code
      await repository.sendResetCode(email);
      emit(ResetCodeSent());
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }

  Future<void> verifyResetCode(String email, String code) async {
    emit(ForgotPasswordInitial());
    try {
      // Call repository to verify reset code
      await repository.verifyResetCode(email, code);
      emit(ResetCodeVerified());
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }

  Future<void> updatePassword(String email, String newPassword) async {
    emit(ForgotPasswordInitial());
    try {
      // Call repository to update password
      await repository.updatePassword(email, newPassword);
      emit(PasswordUpdated());
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }
} */