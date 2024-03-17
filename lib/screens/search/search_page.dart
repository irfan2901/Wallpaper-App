import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/screens/search/cubit/search_cubit.dart';
import 'package:wallpaper_app/screens/set_wallpaper_page.dart';

class SearchPage extends StatefulWidget {
  final String query;
  final String color;

  const SearchPage({super.key, required this.query, this.color = ""});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ScrollController scrollController;
  num totalWallpapers = 0;
  num totalPages = 1;
  int pageCount = 1;
  List<Photos> photosList = [];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (pageCount < totalPages) {
          pageCount++;
          BlocProvider.of<SearchCubit>(context)
              .getSearchedWallpapers(query: widget.query, page: pageCount);
        }
      }
    });
    BlocProvider.of<SearchCubit>(context)
        .getSearchedWallpapers(query: widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchLoadingState && photosList.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Wallpapers loading...'),
              ),
            );
          } else if (state is SearchErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error loading wallpapers...'),
              ),
            );
          } else if (state is SearchLoadedState) {
            totalWallpapers = state.totalCount;
            photosList.addAll(state.photosList);
            totalPages = state.totalCount;
            setState(() {});
          }
        },
        child: ListView(
          controller: scrollController,
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.query,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "$totalWallpapers wallpapers available",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: photosList.length,
              itemBuilder: (context, index) {
                var wallpaper = photosList[index];
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SetWallpaperPaage(
                                  imageSource: wallpaper.src!),
                            ),
                          );
                        },
                        child: Image.network(
                          wallpaper.src!.portrait!,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 60,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (pageCount < totalPages)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
