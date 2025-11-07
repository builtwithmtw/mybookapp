import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lavij/constants/app_routes.dart';
import 'package:lavij/model/ChapterModel.dart';
import 'package:lavij/widgets/box.dart';

class BookScreen extends StatefulWidget {
  final bool isAuthor;
  const BookScreen({super.key, required this.isAuthor});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  List<Chapter> chapters = [];

  @override
  void initState() {
    super.initState();
    loadBookData();
  }

  Future<void> loadBookData() async {
    final filePath =
        widget.isAuthor ? 'assets/author.json' : 'assets/book_content.json';

    try {
      final jsonString = await rootBundle.loadString(filePath);
      final List<dynamic> jsonData = jsonDecode(jsonString);

      setState(() {
        chapters = jsonData.map((e) => Chapter.fromJson(e)).toList();
      });
    } catch (e, s) {
      log('Error loading book data: $e');
      log('Stacktrace: $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.teal,
      ),
      body: chapters.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, chapterIndex) {
                final chapter = chapters[chapterIndex];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🟢 List all Subchapters
                    ListView.builder(
                      itemCount: chapter.subchapters.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, subIndex) {
                        final sub = chapter.subchapters[subIndex];
                        return ChapterTile(
                          title: sub.title,
                          onTap: () {
                            Get.toNamed(AppRoutes.chapterDetail, arguments: {
                              'title': sub.title,
                              'content': sub.content,
                            });
                          },
                          isChapter: true,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}
