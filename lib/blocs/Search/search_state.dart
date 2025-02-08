// import 'package:equatable/equatable.dart';
// import '/data/models/OfferModel.dart';

// enum SearchStatus { initial, loading, success, failure }

// class SearchState extends Equatable {
//   final String searchQuery;
//   final List<String> suggestions;
//   final List<OfferModel> searchResults;
//   final String? selectedSuggestion;
//   final String? rankBy;
//   final SearchStatus status;
//   final String? error;

//   const SearchState({
//     this.searchQuery = '',
//     this.suggestions = const [],
//     this.searchResults = const [],
//     this.selectedSuggestion,
//     this.rankBy,
//     this.status = SearchStatus.initial,
//     this.error,
//   });

//   SearchState copyWith({
//     String? searchQuery,
//     List<String>? suggestions,
//     List<OfferModel>? searchResults,
//     String? selectedSuggestion,
//     String? rankBy,
//     SearchStatus? status,
//     String? error,
//   }) {
//     return SearchState(
//       searchQuery: searchQuery ?? this.searchQuery,
//       suggestions: suggestions ?? this.suggestions,
//       searchResults: searchResults ?? this.searchResults,
//       selectedSuggestion: selectedSuggestion ?? this.selectedSuggestion,
//       rankBy: rankBy ?? this.rankBy,
//       status: status ?? this.status,
//       error: error ?? this.error,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         searchQuery,
//         suggestions,
//         searchResults,
//         selectedSuggestion,
//         rankBy,
//         status,
//         error,
//       ];
// }


import 'package:equatable/equatable.dart';
import '/data/models/OfferModel.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final String searchQuery;
  final List<String> suggestions;
  final List<OfferModel> searchResults;
  final String? selectedSuggestion;
  final String? rankBy;
  final Map<String, dynamic>? filters;
  final SearchStatus status;
  final String? error;

  const SearchState({
    this.searchQuery = '',
    this.suggestions = const [],
    this.searchResults = const [],
    this.selectedSuggestion,
    this.rankBy,
    this.filters,
    this.status = SearchStatus.initial,
    this.error,
  });

  SearchState copyWith({
    String? searchQuery,
    List<String>? suggestions,
    List<OfferModel>? searchResults,
    String? selectedSuggestion,
    String? rankBy,
    Map<String, dynamic>? filters,
    SearchStatus? status,
    String? error,
  }) {
    return SearchState(
      searchQuery: searchQuery ?? this.searchQuery,
      suggestions: suggestions ?? this.suggestions,
      searchResults: searchResults ?? this.searchResults,
      selectedSuggestion: selectedSuggestion ?? this.selectedSuggestion,
      rankBy: rankBy ?? this.rankBy,
      filters: filters ?? this.filters,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        searchQuery,
        suggestions,
        searchResults,
        selectedSuggestion,
        rankBy,
        filters,
        status,
        error,
      ];
}