import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lavij/model/ItemModel.dart';
import 'package:lavij/screens/child_screen.dart';
import 'package:lavij/widgets/KurdishText.dart';

class Chapter12DetailScreen extends StatefulWidget {
  const Chapter12DetailScreen({super.key});

  @override
  State<Chapter12DetailScreen> createState() => _Chapter12DetailScreenState();
}

class _Chapter12DetailScreenState extends State<Chapter12DetailScreen> {
  List<Folder> items = [];

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    final jsonString = await rootBundle.loadString('assets/pics.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    setState(() {
      items = jsonList.map((e) => Folder.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الفصل'),
      ),
      body: items.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return _buildChapterTile(
                  items[index].title,
                  onTap: () {
                    Get.to(() => const ChildScreen(),
                        arguments: items[index]); // 👈 send Folder
                  },
                );
              },
            ),
    );
  }

  Widget _buildChapterTile(String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
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
      ),
    );
  }
}
