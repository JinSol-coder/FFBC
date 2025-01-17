import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: 검색 화면으로 이동
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              '검색어를 입력하세요',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
} 