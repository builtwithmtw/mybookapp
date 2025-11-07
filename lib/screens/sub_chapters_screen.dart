import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:lavij/constants/app_routes.dart';
import 'package:lavij/widgets/KurdishText.dart';
import 'package:lavij/model/ChapterModel.dart';
import 'package:lavij/widgets/box.dart'; // import model

class Subchaptersscreen extends StatefulWidget {
  const Subchaptersscreen({super.key});

  @override
  State<Subchaptersscreen> createState() => _SubchaptersscreenState();
}

class _SubchaptersscreenState extends State<Subchaptersscreen> {
  late int chapterId;
  Chapter? chapter;

  @override
  void initState() {
    super.initState();
    chapterId = Get.arguments['chapterId']; // 👈 Extract here
    loadChapter(chapterId);
  }

  Future<void> loadChapter(int id) async {
    print("Loading chapter with ID: $id");
    final jsonString = await rootBundle.loadString('assets/chapter${id}.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    final chapterData = Chapter.fromJson(jsonList[0]);

    setState(() {
      chapter = chapterData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (chapter == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Loading...")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(
        chapter!.title,
      )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: chapter!.subchapters.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 18,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final subchapter = chapter!.subchapters[index];
            return ChapterTile(
              title: subchapter.title,
              isChapter: true,
              onTap: () {
                if (chapterId != 4 &&
                    chapterId != 11 &&
                    chapterId != 10 &&
                    chapterId != 3) {
                  Get.toNamed(AppRoutes.chapterDetail, arguments: {
                    'title': subchapter.title,
                    'content': subchapter.content,
                  });
                } else {
                  log('chapterId: $chapterId');

                  Get.toNamed(
                    AppRoutes.subsubchapters,
                    arguments: {
                      'chapterId': chapterId,
                      'title': subchapter.title,
                    },
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
