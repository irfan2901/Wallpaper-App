part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final List<Photos> photosList;

  HomeLoadedState({required this.photosList});
}

final class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
}
