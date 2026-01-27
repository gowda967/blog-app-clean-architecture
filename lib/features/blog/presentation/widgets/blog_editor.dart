import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  const BlogEditor({
    super.key,
    required this.controller,
    required this.hintext,
  });
  final TextEditingController controller;
  final String hintext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintext),
      maxLines: null,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '$hintext is missing';
        }
        return null;
      },
    );
  }
}
