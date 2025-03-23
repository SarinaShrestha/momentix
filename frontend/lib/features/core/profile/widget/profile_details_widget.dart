import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileDetailsWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title, value;
  final IconData icon;

  const ProfileDetailsWidget(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.value,
      this.icon = LineAwesomeIcons.angle_right});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600, // 600 weight
                  fontSize: 15.0,
                  color: black,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis),
            ),
            Expanded(
                child: Icon(icon)
            ),
          ],
        ),
      ),
    );
  }
}
