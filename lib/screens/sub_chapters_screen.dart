import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:lavij/constants/app_routes.dart';
import 'package:lavij/widgets/KurdishText.dart';
import 'package:lavij/model/ChapterModel.dart'; // import model

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
            final sub = chapter!.subchapters[index];
            return _buildSubChapterTile(sub, chapterId);
          },
        ),
      ),
    );
  }

  Widget _buildSubChapterTile(Subchapter subchapter, int chapterId) {
    return GestureDetector(
      onTap: () {
        if (chapterId != 4 && chapterId != 11 && chapterId != 10) {
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: Offset(0, 6),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: KurdishText(
              text: subchapter.title,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
