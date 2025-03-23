import 'package:flutter/material.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:frontend/widgets/cards/event_card_widget.dart';

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text('Your Memories', style: TextStyle(fontFamily: 'Poppins', fontWeight:FontWeight.w600, fontSize: 16, color: white)),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text('Here you can find all your memories from different events.', style: 
                  TextStyle(
                      fontFamily: 'Poppins', 
                      fontWeight: FontWeight.w400,
                      fontSize: 13, 
                      color: offWhite,
                      height: 1.8,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
             ),
             SizedBox(height: 20),
            ]
          ),
        ),
        
        backgroundColor: black,
        toolbarHeight: 0.18 * size.height,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          EventCardWidget(
            eventName: 'Event Name',
            pictureCount: 5,
            createdOn: '2024-10-10',
            imageUrl: loginImage,
          ),
        ],
      ),
    );
  }
}
