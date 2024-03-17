part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoadingState extends SearchState {}

final class SearchLoadedState extends SearchState {
  final List<Photos> photosList;
  final num totalCount;

  SearchLoadedState({required this.photosList, required this.totalCount});
}

final class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState({required this.error});
}
