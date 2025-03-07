import 'package:flutter/material.dart';
import 'package:frontend/features/core/views/events/events.dart';
import 'package:frontend/features/core/views/gallery/gallery.dart';
import 'package:frontend/features/core/views/profile/profile_page.dart';
import 'package:frontend/features/core/widgets/bottom_nav_bar.dart';
import 'package:frontend/utils/colors.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    GalleryPage(),
    Container(), 
    EventsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      _showCreateJoinDialog();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showCreateJoinDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Create or Join Event', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                // Add event creation logic here
              },
              icon: Icon(Icons.add),
              label: Text('Create Event'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                // Add event joining logic here
              },
              icon: Icon(Icons.group),
              label: Text('Join Event'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => _onItemTapped(2),
        backgroundColor: lightBlack,
        child: Icon(Icons.add, color: white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}




class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text('Momentix', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: white)),
            SizedBox(height: 8),
            Text('MEMORY MADE SIMPLE', style: 
              TextStyle(
                  fontFamily: 'Poppins', 
                  fontWeight: FontWeight.w400,
                  fontSize: 14, 
                  color: offWhite)),
          ]
        ),
        backgroundColor: black,
        toolbarHeight: 110.0,
      ),
      
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text('Hi,',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 24, color: black)),
              Text(' Sarina!',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24, color: textBlue, fontWeight: FontWeight.bold)),
            ]
          ),

          SizedBox(height: 5),

          Row(
            children: [
              SizedBox(width: 20),
              Text('Welcome to',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, color: black)),
              Text(' Momentix!',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18, color: black, fontWeight: FontWeight.bold)),
            ]
          ),

          SizedBox(height: 30),

          Container(
            height: 200,
            decoration: BoxDecoration(
              color: backgroundBlue,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Your Memories, Just a Tap Away!',
                    style: TextStyle(fontWeight:FontWeight.w600, fontSize: 15, color: black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Here’s your hub for reliving your favorite event moments.',
                    style: TextStyle(
                      fontWeight:FontWeight.w400, 
                      fontSize: 13, 
                      color: textGray,
                      height: 1.8),
                    textAlign: TextAlign.center,
                  )
                ]
                ),

                Positioned(
                  top: 150,
                  right: 16,
                  left: 16,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    height: 250,
                    decoration: BoxDecoration(
                      color: lightBlack,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Ready to relive your favourite moments?',
                          style: TextStyle(fontWeight:FontWeight.w600, fontSize: 14, color: white, height: 1.8),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Your latest event’s pictures are just a click away!',
                          style: TextStyle(
                            fontWeight:FontWeight.w400, 
                            fontSize: 13, 
                            color: hintTextColor,
                            height: 1.8),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 20),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonYellow,
                            foregroundColor: black,
                            shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {},
                          child: Text('My Moments', style: TextStyle(fontWeight:FontWeight.w600, fontSize: 14, color: black)),
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
          ),
          SizedBox(height: 220),
          Text('Remember every moment with Momentix.', style: TextStyle(fontWeight:FontWeight.w400, fontSize: 11, color: textGray, height: 1.8), textAlign: TextAlign.center),
        ],
      )
    );
  }
}
