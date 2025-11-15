import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lavij/constants/app_routes.dart';
import 'package:lavij/screens/book_content.dart';
import 'package:lavij/widgets/KurdishText.dart';
import 'package:lavij/widgets/box.dart';
import 'package:get/get.dart';

class ChaptersScreen extends StatefulWidget {
  @override
  _ChaptersScreenState createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  final List<String> kurdishChapters = [
    ' به‌شێ ئێكێ: ئێزدی و ئێزدییاتی', // 1
    '  به‌شێ دووێ: چین و فه‌رزێن ئێزدییان ', // 2
    ' به‌شێ سیێ: پیرۆزییێن ئێزدییان', // 3
    ' به‌شێ چارێ: جه‌ژن و ڕێوڕه‌سمێن ئێزدییان', // 4
    ' به‌شێ پێنچێ: زڤڕۆكا ژیانێ ل جه‌م ئێزدییان', // 5
    ' به‌شێ شه‌شێ: هه‌لكه‌فتێن ئێزدییان', // 6
    ' به‌شێ هه‌فتێ: گونه‌ه و بتكاری  ل جه‌م ئێزدییان', // 7
    'به‌شێ هه‌شتێ: مه‌هده‌ر و زێوێن پیرانی ', // 8
    ' به‌شێ نه‌هێ: ئه‌ركانێن دینێ ئێزدییان', // 9
    'به‌شێ ده‌هێ: مه‌زارگه‌ه و نیشانگه‌هێن خاس و چاكێن ئێزدییان ', // 10
    'به‌شێ یازدێ: ئه‌ده‌بیاتا دینێ ئێزدییان', // 11
    ' به‌شێ دوازدێ: وێنه‌ ده‌ربارێ په‌رتۆكێ' // 12
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
                  hintText: 'كهران بو بابيك',
                  hintTextDirection: TextDirection.rtl,
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
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  ChapterTile(
                    title: "ده‌رباره‌ی نڤیسه‌ری و چاپكرنا په‌رتووكێ",
                    onTap: () {
                      Get.to(() => const BookScreen(isAuthor: true));
                    },
                    isChapter: false,
                  ),
                  ChapterTile(
                    title: "ناڤه‌رۆكا په‌رتووكێ",
                    onTap: () {
                      Get.to(() => const BookScreen(isAuthor: false));
                    },
                    isChapter: false,
                  ),
                ],
              ),
              SizedBox(height: 25),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 1,
                children: List.generate(filteredChapters.length, (index) {
                  return ChapterTile(
                    title: filteredChapters[index],
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
}
