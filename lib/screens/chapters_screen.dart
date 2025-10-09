import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lavij/constants/app_routes.dart';
import 'package:lavij/widgets/KurdishText.dart';
import 'package:get/get.dart';

class ChaptersScreen extends StatefulWidget {
  @override
  _ChaptersScreenState createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  final List<String> kurdishChapters = [
    'به‌شێ ئێكێ', // 1
    'به‌شێ دوویێ', // 2
    'به‌شێ سێیێ', // 3
    'به‌شێ چارێ', // 4
    'به‌شێ پێنچێ', // 5
    'به‌شێ شه‌شێ', // 6
    'به‌شێ هه‌فتی', // 7
    'به‌شێ هه‌شتێ', // 8
    'به‌شێ نه‌هێ', // 9
    'به‌شێ ده‌هێ', // 10
    'به‌شێ یازدێ', // 11
    'به‌شێ دوازدێ' // 12
  ];

  late List<String> chapters;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    chapters = List.from(kurdishChapters); // copy if needed later
  }

  @override
  Widget build(BuildContext context) {
    final filteredChapters = chapters
        .where((chapter) =>
            chapter.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ── Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KurdishText(
                    text: 'په‌رتووك',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.contact_page_outlined, size: 28),
                    onPressed: () {
                      Navigator.pushNamed(context, '/contact');
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),

              /// ── Search Bar
              TextField(
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: 'RudawRegular',
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: '...كهران بو بابيك',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (val) {
                  setState(() => searchQuery = val);
                },
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.tableOfContent);
                    },
                    child: KurdishText(
                      text: 'ناڤه‌رۆكا په‌رتووكێ ',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 24,
                mainAxisSpacing: 18,
                childAspectRatio: 1.2,
                children: List.generate(filteredChapters.length, (index) {
                  return _buildChapterTile(
                    filteredChapters[index],
                    onTap: () {
                      final int chapterNo = index + 1;
                      if (chapterNo != 12) {
                        Get.toNamed(
                          AppRoutes.subchapters,
                          arguments: {'chapterId': index + 1},
                        );
                      } else {
                        Get.toNamed(AppRoutes.chapter12Detail);
                      }
                    },
                  );
                }),
              ),
            ],
          ),
        ),
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
          child: KurdishText(
            text: title,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
