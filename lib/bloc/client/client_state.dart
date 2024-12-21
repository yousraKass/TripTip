import 'package:triptip/data/models/client/client_model.dart';

abstract class ClientState {}

class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class ClientSuccess extends ClientState {
  final ClientModel client;
  
  ClientSuccess({required this.client});
}

class ClientFailure extends ClientState {
  final String error;
  
  ClientFailure({required this.error});
}