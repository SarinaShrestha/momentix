import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/model/user_model.dart';
import 'package:frontend/features/core/controller/profile/profile_controller.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:frontend/utils/sizes.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(LineAwesomeIcons.angle_left),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Update Your Profile', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: FutureBuilder(
            future: controller.getUserData(), 
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;

                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(profilePicture, fit: BoxFit.cover,),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: buttonYellow,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(LineAwesomeIcons.alternate_pencil, color: black,),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 50,),

                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller.name,
                              initialValue: user.name,
                            )
                          ],
                        )
                      ),
                      const SizedBox(height: 20),
                  ]);
                } else {
                  return CircularProgressIndicator();
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
        ),
      ),
    );
  }
}