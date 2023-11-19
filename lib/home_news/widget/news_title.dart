import 'package:flutter/material.dart';

class NewsTitle extends StatelessWidget {
  const NewsTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      maxLines: 2,
    );
  }
}
