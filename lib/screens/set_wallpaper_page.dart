import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/wallpaper_options.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;

class SetWallpaperPaage extends StatelessWidget {
  final Src imageSource;
  const SetWallpaperPaage({super.key, required this.imageSource});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(imageSource.portrait!),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WallpaperOptions(
                color: Colors.grey.withOpacity(0.4),
                title: "Info",
                iconData: Icons.info,
                callback: () {},
              ),
              const SizedBox(
                width: 5,
              ),
              WallpaperOptions(
                color: Colors.grey.withOpacity(0.4),
                title: "Save",
                iconData: Icons.download,
                callback: () {
                  saveImage(context, imageSource.portrait);
                },
              ),
              const SizedBox(
                width: 5,
              ),
              WallpaperOptions(
                color: Colors.blueAccent,
                title: "Apply",
                iconData: Icons.format_paint,
                callback: () {
                  setWallpaper(context, imageSource.portrait);
                },
              ),
            ],
          )
        ],
      )),
    );
  }

  Future<void> saveImage(BuildContext context, String? portrait) async {
    try {
      if (portrait == null) {
        throw Exception("Image URL is null");
      }

      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final http.Response response = await http.get(Uri.parse(portrait));

      if (response.statusCode != 200) {
        throw Exception("Failed to download image: ${response.statusCode}");
      }

      final String fileName =
          "image_${DateTime.now().millisecondsSinceEpoch}.png";
      final File tempFile = File("$tempPath/$fileName");
      await tempFile.writeAsBytes(response.bodyBytes);

      await Gal.putImage(tempFile.path);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Image saved successfully..."),
        ),
      );
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error saving image: $ex"),
        ),
      );
    }
  }

  setWallpaper(BuildContext context, String? portrait) {
    Wallpaper.imageDownloadProgress(portrait!).listen((event) {}, onDone: () {
      Wallpaper.homeScreen(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          options: RequestSizeOptions.RESIZE_FIT);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Wallpaper set successfully"),
        ),
      );
    }, onError: (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error setting wallpaper"),
        ),
      );
    });
  }
}
