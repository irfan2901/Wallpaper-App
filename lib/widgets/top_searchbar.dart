// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/api/http_service.dart';
import 'package:wallpaper_app/repository/wallpaper_repository.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';

import 'package:wallpaper_app/screens/search/search_page.dart';

class TopSearchbar extends StatelessWidget {
  final TextEditingController searchController;
  const TopSearchbar({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey),
        child: TextField(
          controller: searchController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Find wallpapers...',
            suffixIcon: InkWell(
              onTap: () {
                if (searchController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => SearchCubit(
                          wallpaperRepository:
                              WallpaperRepository(httpService: HttpService()),
                        ),
                        child: SearchPage(
                          query: searchController.text,
                        ),
                      ),
                    ),
                  );
                }
              },
              child: const Icon(Icons.search),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
          ),
          cursorColor: Colors.blue,
        ),
      ),
    );
  }
}
