import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/screens/home/cubit/home_cubit.dart';
import 'package:wallpaper_app/utils/app_utils.dart';
import 'package:wallpaper_app/widgets/best_of_month.dart';
import 'package:wallpaper_app/widgets/categories_list.dart';
import 'package:wallpaper_app/widgets/color_tone.dart';
import 'package:wallpaper_app/widgets/top_searchbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getTrendingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLightColor,
      body: ListView(
        children: [
          TopSearchbar(searchController: searchController),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Best of the month',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const BestOfMonth(),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'The color tone',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          ColorTone(searchController: searchController),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const CategoriesList()
        ],
      ),
    );
  }
}
