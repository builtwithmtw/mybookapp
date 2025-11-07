import 'package:get/get.dart';
import 'package:lavij/screens/chapter_12_detail_screen.dart';
import 'package:lavij/screens/chapter_detail_screen.dart';
import 'package:lavij/screens/chapters_screen.dart';
import 'package:lavij/screens/child_screen.dart';
import 'package:lavij/screens/home_screen.dart';
import 'package:lavij/screens/sub_chapters_screen.dart';
import 'package:lavij/screens/sub_sub_chapters_screen.dart';
import 'package:lavij/screens/table_screen.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String chapters = '/chapters';
  static const String subchapters = '/subchapters';
  static const String subsubchapters = '/subsubchapters';
  static const String chapterDetail = '/chapter_detail';
  static const String chapter12Detail = '/chapter_12_detail';
  static const String childScreen = '/childScreen';
  static const String tableOfContent = '/tableOfContent';

  static final routes = [
    GetPage(name: welcome, page: () => HomeScreen()),
    GetPage(name: chapters, page: () => ChaptersScreen()),
    GetPage(name: subchapters, page: () => const Subchaptersscreen()),
    GetPage(name: subsubchapters, page: () => const Subsubchaptersscreen()),
    GetPage(name: chapterDetail, page: () => ChapterDetailScreen()),
    GetPage(name: chapter12Detail, page: () => Chapter12DetailScreen()),
    GetPage(name: childScreen, page: () => ChildScreen()),
    GetPage(name: tableOfContent, page: () => TableOfContentScreen()),
  ];
}
