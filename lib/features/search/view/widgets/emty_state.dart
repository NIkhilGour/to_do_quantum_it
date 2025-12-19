import 'package:flutter/material.dart';

class EmtyState extends StatelessWidget {
  const EmtyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFFE0E7FF),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.search, size: 56, color: Color(0xFF6366F1)),
          ),
          const SizedBox(height: 32),
          const Text(
            'Search Your Tasks',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Enter a keyword to find tasks by title or\ndescription',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
