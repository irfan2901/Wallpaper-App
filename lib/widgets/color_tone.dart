import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/api/http_service.dart';
import 'package:wallpaper_app/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/screens/search/search_page.dart';
import 'package:wallpaper_app/utils/app_utils.dart';

class ColorTone extends StatelessWidget {
  final TextEditingController searchController;
  const ColorTone({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppColors.mColors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => SearchCubit(
                        wallpaperRepository:
                            WallpaperRepository(httpService: HttpService()),
                      ),
                      child: SearchPage(
                        query: searchController.text.isNotEmpty
                            ? searchController.text
                            : "Nature",
                        color: AppColors.mColors[index]['code'],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: 70,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.mColors[index]['color']),
              ),
            ),
          );
        },
      ),
    );
  }
}
