
enum SignUpRole { Client, Agency }

abstract class ChoiceState {}

class ChoiceInitial extends ChoiceState {}

class ChoiceSelected extends ChoiceState {
  final SignUpRole role;

  ChoiceSelected({required this.role});
}