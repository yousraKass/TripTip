part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final List<String> selectedCategories;
  final String selectedCountry;
  final String selectedCity;
  final List<String> selectedFeatures;
  final String selectedTravelOption;
  final double minPrice;
  final double maxPrice;
  final int selectedStars;

  const FilterState({
    this.selectedCategories = const [],
    this.selectedCountry = '',
    this.selectedCity = '',
    this.selectedFeatures = const [],
    this.selectedTravelOption = '',
    this.minPrice = 20000,
    this.maxPrice = 100000,
    this.selectedStars = 0,
  });

  FilterState copyWith({
    List<String>? selectedCategories,
    String? selectedCountry,
    String? selectedCity,
    List<String>? selectedFeatures,
    String? selectedTravelOption,
    double? minPrice,
    double? maxPrice,
    int? selectedStars,
  }) {
    return FilterState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedFeatures: selectedFeatures ?? this.selectedFeatures,
      selectedTravelOption: selectedTravelOption ?? this.selectedTravelOption,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      selectedStars: selectedStars ?? this.selectedStars,
    );
  }

  @override
  List<Object> get props => [
    selectedCategories,
    selectedCountry,
    selectedCity,
    selectedFeatures,
    selectedTravelOption,
    minPrice,
    maxPrice,
    selectedStars,
  ];
}