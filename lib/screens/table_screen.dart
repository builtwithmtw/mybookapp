import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:lavij/constants/app_routes.dart';
import 'package:lavij/model/TableOfContent.dart';
import 'package:lavij/widgets/KurdishText.dart';

class TableOfContentScreen extends StatefulWidget {
  const TableOfContentScreen({super.key});

  @override
  State<TableOfContentScreen> createState() => _TableOfContentScreenState();
}

class _TableOfContentScreenState extends State<TableOfContentScreen> {
  List<TableOfContent> chapters = [];
  List<TableOfContent> filteredChapters = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTableOfContent();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadTableOfContent() async {
    final jsonString =
        await rootBundle.loadString('assets/table_of_content.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);

    setState(() {
      chapters = jsonList
          .map((jsonItem) => TableOfContent.fromJson(jsonItem))
          .toList();
      filteredChapters = chapters;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() => filteredChapters = chapters);
    } else {
      setState(() {
        filteredChapters = chapters
            .where((chapter) =>
                chapter.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: KurdishText(
        text: 'ناڤه‌رۆكا په‌رتۆكێ',
        fontSize: 24,
        color: Colors.black,
      )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: 'RudawRegular',
                fontSize: 18,
              ),
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '...كهران بو بابيك',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
              child: chapters.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: chapters.length,
                      itemBuilder: (context, index) {
                        final chapter = chapters[index];
                        final chapterNo = index + 1;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: _buildChapterTile(
                            chapter.title,
                            onTap: () {
                              if (chapterNo != 12) {
                                Get.toNamed(
                                  AppRoutes.subchapters,
                                  arguments: {'chapterId': chapterNo},
                                );
                              } else {
                                Get.toNamed(AppRoutes.chapter12Detail);
                              }
                            },
                          ),
                        );
                      },
                    ))
        ],
      ),
    );
  }

  Widget _buildChapterTile(String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: KurdishText(
              text: title,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
