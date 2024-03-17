import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/repository/wallpaper_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  WallpaperRepository wallpaperRepository;
  HomeCubit({required this.wallpaperRepository}) : super(HomeInitial());

  Future<void> getTrendingWallpapers() async {
    emit(HomeLoadingState());
    try {
      var data = await wallpaperRepository.getTrendingWallpapers();
      var wallpapers = WallpaperModel.fromJson(data);
      emit(HomeLoadedState(photosList: wallpapers.photos!));
    } catch (ex) {
      emit(HomeErrorState(error: ex.toString()));
    }
  }
}
