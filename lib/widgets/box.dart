import 'package:flutter/material.dart';
import 'package:lavij/widgets/KurdishText.dart';

class ChapterTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isChapter;

  const ChapterTile({
    Key? key,
    required this.title,
    this.onTap,
    this.isChapter = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color accentColor =
        isChapter ? const Color(0xFF6C63FF) : const Color(0xFF00BFA5);
    final Color accentLight =
        isChapter ? const Color(0xFFD1C4E9) : const Color(0xFFA7FFEB);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        splashColor: accentColor.withOpacity(0.1),
        highlightColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                accentLight.withOpacity(0.25),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: accentColor.withOpacity(0.2),
              width: 1.1,
            ),
            boxShadow: [
              BoxShadow(
                color: accentColor.withOpacity(0.1),
                offset: const Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Show icon only when not a chapter
              if (!isChapter) ...[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        accentColor,
                        accentColor.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.info_outline_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
              ],

              // Title expands naturally with full height
              Expanded(
                child: KurdishText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.85),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
