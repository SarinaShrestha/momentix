import 'package:flutter/material.dart';
import 'package:frontend/features/core/user_events/controller/user_events_controller.dart';
import 'package:provider/provider.dart';
import 'package:frontend/features/core/home/views/home_page.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:frontend/features/core/user_events/widgets/event_card_widget.dart';
import 'package:frontend/widgets/common/thin_elevated_button_widget.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}
class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<UserEventsController>(context, listen: false).loadUserEvents());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userEventsController = Provider.of<UserEventsController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        clipBehavior: Clip.none,
        title: Padding(
          padding: EdgeInsets.all(20),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: 20),
                  Text('Your Events!', style: TextStyle(fontFamily: 'Poppins', fontWeight:FontWeight.w600, fontSize: 16, color: white)),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Text('Here you can find all the events you’ve created and joined.', style: 
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
                  SizedBox(height: 30),
                ]
              ),
              Positioned(
                top:0.15 * size.height,
                //left: 0.2 * size.width,
                child: SizedBox(
                  width: 0.5 * size.width,
                  height: 0.052 * size.height,
                  child: ThinElevatedButtonWidget(
                    buttonName: '+ Create Event', 
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                    }, 
                    outlined: false,
                  ),
                ),
              )
            ]
          ),
        ),
        
        backgroundColor: black,
        toolbarHeight: 0.18 * size.height,
      ),


      body: userEventsController.isLoading
      ? const Center(child: CircularProgressIndicator(),)
      : userEventsController.errorMessage != null
        ? Center(child: Text(userEventsController.errorMessage!))
        : ListView.builder(
          padding: const EdgeInsets.only(top: 30.0),
          itemCount: userEventsController.events.length,
          itemBuilder: (context, index){
            final event = userEventsController.events[index];

            return EventCardWidget(
              eventName: event['Event Name'] ?? 'Unknown Event',
              pictureCount: event['pictureCount']?? 0,
              createdOn: event['Event Date'] ?? 'Unknown Date',
              imageUrl: loginImage,

            );
          })
    );
  }
}
