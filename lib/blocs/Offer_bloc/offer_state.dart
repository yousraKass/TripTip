import '../../data/models/OfferModel.dart';

abstract class OfferState {}

class OfferInitialState extends OfferState {}

class OfferLoadingState extends OfferState {}

class OfferErrorState extends OfferState {
  final String message;
  OfferErrorState({required this.message});
}

class OfferLoadedState extends OfferState {
  final List<OfferModel> offers;
  final List<OfferModel> places;
  final List<OfferModel> categories;
  final OfferModel? topOffer;
  final Set<String> favorites;
  final String? hoveredCity;

  OfferLoadedState({
    this.offers = const [],
    this.places = const [],
    this.categories = const [],
    this.topOffer,
    this.favorites = const {},
    this.hoveredCity,
  });

  OfferLoadedState copyWith({
    List<OfferModel>? offers,
    List<OfferModel>? places,
    List<OfferModel>? categories,
    OfferModel? topOffer,
    Set<String>? favorites,
    String? hoveredCity,
  }) {
    return OfferLoadedState(
      offers: offers ?? this.offers,
      places: places ?? this.places,
      categories: categories ?? this.categories,
      topOffer: topOffer ?? this.topOffer,
      favorites: favorites ?? this.favorites,
      hoveredCity: hoveredCity,
    );
  }
}