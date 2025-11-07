import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lavij/widgets/KurdishText.dart';

class ChapterDetailScreen extends StatelessWidget {
  const ChapterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extracting arguments
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String title = args['title'] ?? '';
    final String content = args['content'] ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Soft paper-like background
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: KurdishText(
          text: title,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.teal.shade700,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.teal),
          onPressed: () => Get.back(),
        ),
      ),
      body: Scrollbar(
        radius: const Radius.circular(12),
        thickness: 5,
        thumbVisibility: true,
        interactive: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),

                // 🟢 Chapter Content
                KurdishText(
                  text: content,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.85),
                  textAlign: TextAlign.justify,
                ),

                const SizedBox(height: 30),

                // 🟢 End Separator
                Center(
                  child: Container(
                    height: 5,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
