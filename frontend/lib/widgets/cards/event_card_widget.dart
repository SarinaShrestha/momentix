import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';

class EventCardWidget extends StatelessWidget {
  final String eventName;
  final int pictureCount;
  final String createdOn;
  final String? imageUrl; // Optional image URL

  const EventCardWidget({
    super.key,
    required this.eventName,
    required this.pictureCount,
    required this.createdOn,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundBlue, 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 0.4 * size.width,
            height: 0.4 * size.width,
            decoration: BoxDecoration(
              color: Colors.white, // Placeholder color
            ),
            child: imageUrl != null
                ? ClipRRect(
                    child: Image.asset(imageUrl!, fit: BoxFit.cover),
                  )
                : SizedBox(), 
          ),
          SizedBox(width: 20), // Space between image and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventName,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: 16, 
                    fontWeight: FontWeight.w600),
                    softWrap: true, 
                    overflow: TextOverflow.visible,
                ),
                SizedBox(height: 8),

                //Number of Pictures
                Row(
                  children: [
                    Text(
                      "Pictures: ",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 13),
                    ),
                    Text(
                      '$pictureCount',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13)
                    )
                  ],
                ),

                SizedBox(height: 3),

                //Created Date
                Column(
                  children: [
                    Text(
                      "Created on:",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 13),
                    ),
                    Text(
                      createdOn,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13)
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
