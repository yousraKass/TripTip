import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState());

  void updateCategories(List<String> categories) {
    emit(state.copyWith(selectedCategories: categories));
  }

  void updateCountry(String country) {
    emit(state.copyWith(selectedCountry: country));
  }

  void updateCity(String city) {
    emit(state.copyWith(selectedCity: city));
  }

  void updateFeatures(List<String> features) {
    emit(state.copyWith(selectedFeatures: features));
  }

  void updateTravelOption(String travelOption) {
    emit(state.copyWith(selectedTravelOption: travelOption));
  }

  void updatePriceRange(double start, double end) {
    emit(state.copyWith(minPrice: start, maxPrice: end));
  }

  void updateOfferRating(int rating) {
    emit(state.copyWith(selectedStars: rating));
  }

  Map<String, dynamic> prepareFiltersForSearch() {
    return {
      'categories': state.selectedCategories,
      'country': state.selectedCountry,
      'city': state.selectedCity,
      'features': state.selectedFeatures,
      'travelOption': state.selectedTravelOption,
      'minPrice': state.minPrice,
      'maxPrice': state.maxPrice,
      'rating': state.selectedStars,
    };
  }
}