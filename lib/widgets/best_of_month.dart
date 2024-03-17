import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/screens/home/cubit/home_cubit.dart';
import 'package:wallpaper_app/screens/set_wallpaper_page.dart';

class BestOfMonth extends StatelessWidget {
  const BestOfMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeErrorState) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else if (state is HomeLoadedState) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.photosList.length,
              itemBuilder: (context, index) {
                var wallpaper = state.photosList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetWallpaperPaage(
                              imageSource: wallpaper.src!,
                            ),
                          ),
                        );
                      },
                      child: Image(
                        image: NetworkImage(wallpaper.src!.portrait!),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
