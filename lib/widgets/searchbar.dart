import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  final Color borderColor;
  final Color iconColor;

  const Searchbar({required this.borderColor, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search, color: iconColor),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
