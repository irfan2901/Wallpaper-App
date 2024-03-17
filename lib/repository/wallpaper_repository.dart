import 'package:wallpaper_app/api/http_service.dart';
import 'package:wallpaper_app/constants/app_constants.dart';

class WallpaperRepository {
  HttpService httpService;
  WallpaperRepository({required this.httpService});

  Future<dynamic> getTrendingWallpapers() async {
    try {
      return await httpService.getApi(url: trendingUrl);
    } catch (ex) {
      rethrow;
    }
  }

  Future<dynamic> getSearchWallpaper(String query,
      {String color = "", int page = 1}) async {
    try {
      return await httpService.getApi(
          url: "$searchUrl?query=$query&color=$color&page=$page");
    } catch (ex) {
      throw (ex.toString());
    }
  }
}
