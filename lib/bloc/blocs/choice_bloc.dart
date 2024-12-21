import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/choice_event.dart';
import '../states/choice_state.dart';

class ChoiceBloc extends Bloc<ChoiceEvent, ChoiceState> {
  ChoiceBloc() : super(ChoiceInitial()) {
    on<ChooseClient>((event, emit) {
      emit(ChoiceSelected(role: SignUpRole.Client));
    });

    on<ChooseAgency>((event, emit) {
      emit(ChoiceSelected(role: SignUpRole.Agency));
    });
  }

}
