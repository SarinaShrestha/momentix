import 'package:flutter/material.dart';
import 'package:frontend/widgets/form/error_message_widget.dart';

class MessagePage extends StatelessWidget{
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: ErrorMessageWidget(text: "The entered name already exists. Please enter another name."),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                elevation: 0,
              )
            );
          },
          child: const Text('Show Message'),
        ),
      )
    );
  }
}

