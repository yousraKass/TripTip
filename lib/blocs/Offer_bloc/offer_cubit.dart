import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/OfferRepo.dart';
import '/data/models/OfferModel.dart';
import 'offer_state.dart';


class OfferCubit extends Cubit<OfferState> {
  final OfferRepo offerRepo;
  OfferLoadedState? _lastLoadedState;
  OfferCubit({required this.offerRepo}) : super(OfferInitialState());


  fetchInitialData() async {
    try {
      emit(OfferLoadingState());
      final topOffer = await offerRepo.fetchTopOffer();
      final places = await offerRepo.fetchPlaces();
      final categories = await offerRepo.fetchCategories();
      final offers = await offerRepo.fetchOffers();

      _updateState(
        topOffer: topOffer,
        places: places,
        categories: categories,
        offers: offers,
      );
    } catch (e) {
      _handleError(e.toString());
    }
  }



  Future<void> fetchTopOffer() async {
    try {
      final currentState = state;
      if (currentState is! OfferLoadedState) {
        emit(OfferLoadingState());
      }
      
      final offer = await offerRepo.fetchTopOffer();
      _updateState(topOffer: offer);
    } catch (e) {
      _handleError(e.toString());
    }
  }


  Future<void> fetchPlaces() async {
    try {
      final currentState = state;
      if (currentState is! OfferLoadedState) {
        emit(OfferLoadingState());
      }
      
      final places = await offerRepo.fetchPlaces();
      _updateState(places: places);
    } catch (e) {
      _handleError(e.toString());
    }
  }


  Future<void> fetchCategories() async {
    try {
      final currentState = state;
      if (currentState is! OfferLoadedState) {
        emit(OfferLoadingState());
      }
      
      final categories = await offerRepo.fetchCategories();
      _updateState(categories: categories);
    } catch (e) {
      _handleError(e.toString());
    }
  }


  Future<void> fetchOffers() async {
    try {
      final currentState = state;
      if (currentState is! OfferLoadedState) {
        emit(OfferLoadingState());
      }
      
      final offers = await offerRepo.fetchOffers();
      _updateState(offers: offers);
    } catch (e) {
      _handleError(e.toString());
    }
  }


 Future<void> fetchOffersByAgencyId(int agencyId) async {
    try {
      emit(OfferLoadingState());
      final offers = await offerRepo.fetchOffersByAgencyId(agencyId);
      _updateState(offers: offers);
    } catch (e) {
      _handleError(e.toString());
    }
  }
  Future<void> deleteOffer(int offerId) async {
    try {
      final currentState = state;
      if (currentState is OfferLoadedState) {
        // Remove the offer from the list
        final updatedOffers = List<OfferModel>.from(currentState.offers)
          ..removeWhere((offer) => offer.id == offerId);

        // Update the state
        _updateState(offers: updatedOffers);
      }
    } catch (e) {
      _handleError(e.toString());
    }
  }

  // Future<void> fetchOfferById(int id) async {
  //   try {
  //     final currentState = state;
  //     if (currentState is! OfferLoadedState) {
  //       emit(OfferLoadingState());
  //     }
      
  //     final offer = await offerRepo.fetchOfferById(id);
  //     _updateState(offers: [offer]);
  //   } catch (e) {
  //     _handleError(e.toString());
  //   }
  // }

 static const backGroundImage = 'assets/images/backgroundimage.jpeg';
  static const List<String> offerImageUrls = [
    'assets/images/offer1.png',
    'assets/images/offer2.png',
    'assets/images/offer3.png',
    'assets/images/offer4.png',
  ];


Future<void> fetchOfferById(int offerId, {int id = 1}) async {
  try {
    final currentState = state;
    if (currentState is! OfferLoadedState) {
      emit(OfferLoadingState());
    }

    final offer = OfferModel(
      id: 1,
      image: 'assets/images/Annaba.png',
      cityName: 'Annaba',
      countryName: 'Algeria',
      rating: 4.7,
      price: 20000.0,
      startDate: '02/08/2024',
      endDate: '15/08/2024',
      descriptionText:
          'Annaba captivates visitors with its perfect blend of natural beauty and rich history, '
          'offering a unique experience that bridges ancient civilizations with stunning landscapes. '
          'Located in the northeastern corner of Algeria, this coastal city is blessed with pristine beaches, rolling hills, '
          'and the shimmering waters of the Mediterranean. The surrounding landscapes are dotted with lush olive groves and vibrant green fields, '
          'while the nearby Tassili Mountains add a dramatic backdrop to the city’s charm.',
      category: 'Destination',
      days: 13,
      thumbnails: offerImageUrls,
    );

    emit(OfferLoadedState(offers: [offer])); 
  } catch (e) {
    emit(OfferErrorState(message: e.toString()));
  }
}


  Future<void> addOffer(OfferModel offer, int agencyId) async {
    try {
      emit(OfferLoadingState());
      await offerRepo.addOffer(offer, agencyId);
      
      // After successfully adding the offer, refetch the offers for this agency
      final offers = await offerRepo.fetchOffersByAgencyId(agencyId);
      _updateState(offers: offers);
    } catch (e) {
      _handleError(e.toString());
    }
  }


  void _updateState({
    List<OfferModel>? offers,
    List<OfferModel>? places,
    List<OfferModel>? categories,
    OfferModel? topOffer,
    OfferModel ? singleOffer,
  }) {
    final currentState = _lastLoadedState ?? OfferLoadedState();
    
    _lastLoadedState = currentState.copyWith(
      offers: offers ?? currentState.offers,
      places: places ?? currentState.places,
      categories: categories ?? currentState.categories,
      topOffer: topOffer ?? currentState.topOffer,
      singleOffer: singleOffer ?? currentState.singleOffer,
    );
    
    emit(_lastLoadedState!);
  }

  void _handleError(String message) {
    if (_lastLoadedState != null) {
      emit(_lastLoadedState!);
    } else {
      emit(OfferErrorState(message: message));
    }
  }

  void toggleFavorite(String cityName) {
    if (_lastLoadedState != null) {
      final newFavorites = Set<String>.from(_lastLoadedState!.favorites);
      
      if (newFavorites.contains(cityName)) {
        newFavorites.remove(cityName);
      } else {
        newFavorites.add(cityName);
      }

      _lastLoadedState = _lastLoadedState!.copyWith(favorites: newFavorites);
      emit(_lastLoadedState!);
    }
  }

  void setHovered(String cityName) {
    if (_lastLoadedState != null) {
      _lastLoadedState = _lastLoadedState!.copyWith(hoveredCity: cityName);
      emit(_lastLoadedState!);
    }
  }

  void clearHovered() {
    if (_lastLoadedState != null) {
      _lastLoadedState = _lastLoadedState!.copyWith(hoveredCity: null);
      emit(_lastLoadedState!);
    }
  }
}