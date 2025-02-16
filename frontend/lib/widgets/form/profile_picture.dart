import 'package:flutter/material.dart';
import 'package:frontend/utils/image_strings.dart';


class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget> [
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(profilePicture),
          ),
          Positioned(
            bottom: 20,
            right: 30,
            child: Icon(
              Icons.camera_alt,
              size  : 22,
              color : Colors.white,)
          ),
        ]
      ),
    );
  }
}
