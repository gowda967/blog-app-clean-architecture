import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(fontWeight: .bold, fontSize: 24),
                ),
                const SizedBox(height: 20),
                Text(
                  'by${blog.posterName}',
                  style: const TextStyle(fontWeight: .w500, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  '${formatDateByDDMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)}min',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppPallete.greyColor,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.network(
                    (blog.imageUrl),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator(); // Show loader
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error); // Show on error
                    },
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(fontSize: 16, height: 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
