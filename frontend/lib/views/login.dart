import 'package:flutter/material.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:frontend/utils/sizes.dart';
import 'package:frontend/utils/text_strings.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView ( 
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              children: [
                // Titles
                Image(image: AssetImage(loginImage), height: size.height * 0.25),
                Text(loginTitle, style: Theme.of(context).textTheme.headlineLarge,),
                Text(loginSubTitle, style: Theme.of(context).textTheme.bodyMedium),

                //Login Box
                Form(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        //prefixIcon: Icon(Icons.person_outline_outlined),
                        labelText: email,
                        hintText: email,
                        border: OutlineInputBorder()
                      ),
                    )
                  ],
                )))
              ],)
          ),
        ),
      )
    );
  }

}