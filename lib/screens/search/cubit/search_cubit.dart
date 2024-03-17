import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/repository/wallpaper_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  WallpaperRepository wallpaperRepository;
  SearchCubit({required this.wallpaperRepository}) : super(SearchInitial());

  void getSearchedWallpapers(
      {required String query, String color = "", int page = 1}) async {
    emit(SearchLoadingState());
    try {
      var data = await wallpaperRepository.getSearchWallpaper(query,
          color: color, page: page);
      var wallpaper = WallpaperModel.fromJson(data);
      emit(SearchLoadedState(
          photosList: wallpaper.photos!, totalCount: wallpaper.totalResults!));
    } catch (ex) {
      emit(SearchErrorState(error: ex.toString()));
    }
  }
}
