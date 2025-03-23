import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: lightBlack,
      height: 70.0,
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: currentIndex == 0 ? buttonYellow : Colors.grey),
            iconSize: 30,
            onPressed: () => onTap(0),
          ),
          IconButton(
            icon: Icon(Icons.photo, color: currentIndex == 1 ? buttonYellow: Colors.grey),
            onPressed: () => onTap(1),
            iconSize: 30,
          ),
          SizedBox(width: 40),
          IconButton(
            icon: Icon(Icons.event, color: currentIndex == 3 ? buttonYellow : Colors.grey),
            onPressed: () => onTap(3),
            iconSize: 30,
          ),
          IconButton(
            icon: Icon(Icons.person, color: currentIndex == 4 ? buttonYellow : Colors.grey),
            onPressed: () => onTap(4),
            iconSize: 30,
          ),
        ],
      ),
    );
  }
}
