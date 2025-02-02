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


//   fetchInitialData() async {
//   try {
//     emit(OfferLoadingState());

//     // Simulated top offer data
//     final topOffer = OfferModel(
//       image: 'assets/images/choosen_offer.png',
//       cityName: "Today's Deal",
//       countryName: "Special Offer",
//       rating: 4.9,
//       price: 10000.0,
//       startDate: "2023-12-20",
//       endDate: "2023-12-21",
//       descriptionText: "It is a too good deal, you will travel with free food, plenty of free food.",
//       category: "Limited Time Offer",
//       thumbnails: [],
//       days: 1,
//     );

//     // Simulated places data
//     final places = [
//       OfferModel(
//         image: "assets/images/Annaba.png",
//         cityName: "Annaba",
//         countryName: "Algeria",
//         rating: 4.5,
//         price: 0,
//         startDate: "2024-01-01",
//         endDate: "2024-01-02",
//         descriptionText: "Discover the beautiful coastal city of Annaba.",
//         category: "Destination",
//         thumbnails: [],
//         days: 1,
//       ),
//       OfferModel(
//         image: "assets/images/Tunis.png",
//         cityName: "Tunis",
//         countryName: "Tunisia",
//         rating: 4.7,
//         price: 0,
//         startDate: "2024-01-01",
//         endDate: "2024-01-02",
//         descriptionText: "Explore the rich culture and history of Tunis.",
//         category: "Destination",
//         thumbnails: [],
//         days: 1,
//       ),
//       OfferModel(
//         image: "assets/images/Istanbul.png",
//         cityName: "Istanbul",
//         countryName: "Turkey",
//         rating: 4.8,
//         price: 0,
//         startDate: "2024-01-01",
//         endDate: "2024-01-02",
//         descriptionText: "Visit the stunning city of Istanbul, where East meets West.",
//         category: "Destination",
//         thumbnails: [],
//         days: 1,
//       ),
//       OfferModel(
//         image: "assets/images/Jijel.png",
//         cityName: "Jijel",
//         countryName: "Algeria",
//         rating: 4.6,
//         price: 0,
//         startDate: "2024-01-01",
//         endDate: "2024-01-02",
//         descriptionText: "Relax in the serene landscapes of Jijel.",
//         category: "Destination",
//         thumbnails: [],
//         days: 1,
//       ),
//       OfferModel(
//         image: "assets/images/sahara.png",
//         cityName: "Sahara",
//         countryName: "Algeria",
//         rating: 4.9,
//         price: 0,
//         startDate: "2024-01-01",
//         endDate: "2024-01-02",
//         descriptionText: "Experience the magic of the Sahara desert.",
//         category: "Destination",
//         thumbnails: [],
//         days: 1,
//       ),
//     ];

//     // Simulated categories data
//     final categories = [
//       OfferModel(
//         image: "assets/images/cat01.png",
//         cityName: "Shopping",
//         countryName: "",
//         rating: 0,
//         price: 0,
//         startDate: "",
//         endDate: "",
//         descriptionText: "Explore the best shopping destinations.",
//         category: "Shopping",
//         thumbnails: [],
//         days: 0,
//       ),
//       OfferModel(
//         image: "assets/images/cat02.png",
//         cityName: "Swimming",
//         countryName: "",
//         rating: 0,
//         price: 0,
//         startDate: "",
//         endDate: "",
//         descriptionText: "Find great swimming spots.",
//         category: "Swimming",
//         thumbnails: [],
//         days: 0,
//       ),
//       OfferModel(
//         image: "assets/images/cat03.png",
//         cityName: "Mountains",
//         countryName: "",
//         rating: 0,
//         price: 0,
//         startDate: "",
//         endDate: "",
//         descriptionText: "Discover scenic mountain destinations.",
//         category: "Mountains",
//         thumbnails: [],
//         days: 0,
//       ),
//       OfferModel(
//         image: "assets/images/cat04.png",
//         cityName: "Camping",
//         countryName: "",
//         rating: 0,
//         price: 0,
//         startDate: "",
//         endDate: "",
//         descriptionText: "Enjoy the great outdoors with camping adventures.",
//         category: "Camping",
//         thumbnails: [],
//         days: 0,
//       ),
//     ];

//     // Simulated offers data
//     final offers = [
//       OfferModel(
//         image: 'assets/images/offer1.png',
//         cityName: 'To-Oran',
//         countryName: 'Algeria',
//         rating: 4.8,
//         price: 40000,
//         startDate: "2024-01-10",
//         endDate: "2024-01-15",
//         descriptionText: "A wonderful journey to Oran.",
//         category: "Tour",
//         thumbnails: [
//           'assets/images/offer1.png',
//           'assets/images/offer2.png',
//           'assets/images/offer3.png',
//         ],
//         days: 5,
//       ),
//       OfferModel(
//         image: 'assets/images/offer2.png',
//         cityName: 'To-Maldives',
//         countryName: 'Maldives',
//         rating: 4.7,
//         price: 45000,
//         startDate: "2024-01-20",
//         endDate: "2024-01-26",
//         descriptionText: "Relax in the Maldives.",
//         category: "Tour",
//         thumbnails: [
//           'assets/images/offer1.png',
//           'assets/images/offer2.png',
//           'assets/images/offer3.png',
//         ],
//         days: 6,
//       ),
//       OfferModel(
//         image: 'assets/images/offer3.png',
//         cityName: 'To-Paris',
//         countryName: 'France',
//         rating: 4.9,
//         price: 50000,
//         startDate: "2024-02-01",
//         endDate: "2024-02-07",
//         descriptionText: "Discover the romance of Paris.",
//         category: "Tour",
//         thumbnails: [
//           'assets/images/offer1.png',
//           'assets/images/offer2.png',
//           'assets/images/offer3.png',
//         ],
//         days: 7,
//       ),
//     ];

//     // Update the state with the fetched data
//     _updateState(
//       topOffer: topOffer,
//       places: places,
//       categories: categories,
//       offers: offers,
//     );
//   } catch (e) {
//     _handleError(e.toString());
//   }
// }


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