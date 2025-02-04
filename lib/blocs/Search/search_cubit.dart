// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../data/repositories/search_repository.dart';
// import 'search_state.dart';

// class SearchCubit extends Cubit<SearchState> {
//   final SearchRepository _repository;
  
//   SearchCubit({required SearchRepository repository})
//       : _repository = repository,
//         super(const SearchState()) {
//     _loadSuggestions();
//   }

//   Future<void> _loadSuggestions() async {
//     try {
//       final suggestions = await _repository.getSuggestions();
//       emit(state.copyWith(suggestions: suggestions));
//     } catch (e) {
//       emit(state.copyWith(
//         error: 'Failed to load suggestions',
//         status: SearchStatus.failure,
//       ));
//     }
//   }

//   void updateSearchQuery(String query) {
//     emit(state.copyWith(searchQuery: query));
//   }

//   void selectSuggestion(String suggestion) {
//     emit(state.copyWith(
//       selectedSuggestion: suggestion,
//       searchQuery: suggestion,
//     ));
//     searchOffers();
//   }

//   void updateRankBy(String? rankBy) {
//     emit(state.copyWith(rankBy: rankBy));
//     if (state.searchQuery.isNotEmpty || state.selectedSuggestion != null) {
//       searchOffers();
//     }
//   }

//   Future<void> searchOffers() async {
//     emit(state.copyWith(status: SearchStatus.loading));

//     try {
//       final results = await _repository.searchOffers(
//         query: state.searchQuery,
//         rankBy: state.rankBy,
//       );
      
//       emit(state.copyWith(
//         searchResults: results,
//         status: SearchStatus.success,
//       ));
//     } catch (e) {
//       emit(state.copyWith(
//         error: 'Failed to search offers',
//         status: SearchStatus.failure,
//       ));
//     }
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/search_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repository;
  
  SearchCubit({required SearchRepository repository})
      : _repository = repository,
        super(const SearchState()) {
    _loadSuggestions();
  }

  Future<void> _loadSuggestions() async {
    try {
      final suggestions = await _repository.getSuggestions();
      emit(state.copyWith(suggestions: suggestions));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load suggestions',
        status: SearchStatus.failure,
      ));
    }
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void selectSuggestion(String suggestion) {
    emit(state.copyWith(
      selectedSuggestion: suggestion,
      searchQuery: suggestion,
    ));
    searchOffers();
  }

  void updateRankBy(String? rankBy) {
    emit(state.copyWith(rankBy: rankBy));
    if (state.searchQuery.isNotEmpty || state.selectedSuggestion != null) {
      searchOffers();
    }
  }

  // New method to apply filters
  void applyFilters(Map<String, dynamic> filters) {
    emit(state.copyWith(filters: filters));
    searchOffers();
  }

  Future<void> searchOffers() async {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      final results = await _repository.searchOffers(
        query: state.searchQuery,
        rankBy: state.rankBy,
        filters: state.filters,
      );
      
      emit(state.copyWith(
        searchResults: results,
        status: SearchStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to search offers',
        status: SearchStatus.failure,
      ));
    }
  }
}