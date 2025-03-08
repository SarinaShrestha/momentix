import 'package:flutter/material.dart';
import 'package:frontend/features/core/views/profile/update_profile_page.dart';
import 'package:frontend/features/core/widgets/profile_details_widget.dart';
import 'package:frontend/utils/colors.dart';
import 'package:get/get.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:frontend/utils/sizes.dart';
import 'package:frontend/widgets/common/thin_elevated_button_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Profile', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: Column(
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
                        //border: Border.all(color: placeholderColor, width: 1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage(loginImage), fit: BoxFit.cover,),
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
              const SizedBox(height: 10,),
              Text('User Name', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),),
              Text('Gmail@gmail.com', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15)),
              const SizedBox(height: 20,),
              SizedBox(
                width: 150,
                child: ThinElevatedButtonWidget(
                  onPressed: () => Get.to(() => const UpdateProfilePage()), 
                  buttonName: 'Edit Profile',
                  color: textBlue ,
                  outlined: false,
                  ),
              ),

              const SizedBox(height: 20,),
              const Divider(),
              const SizedBox(height: 10,),
              Text("Profile Information", style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 17),),
              const SizedBox(height: 10,),

              ProfileDetailsWidget(
                title: 'Name',
                value: 'Sarina',
                onPressed: (){},
              ),

              ProfileDetailsWidget(
                title: 'UserId',
                value: '00enfrkwn',
                icon: Iconsax.copy,
                onPressed: (){},
              ),

              ProfileDetailsWidget(
                title: 'Gmail', 
                value: 'sarina@gmail.com',
                onPressed: (){},
              ),

              ProfileDetailsWidget(
                title: 'Password',
                value: 'sarina@gmail.com',
                onPressed: (){},
              ),

              const SizedBox(height: 5,),
              Divider(),

              Center(
                child: TextButton(
                  onPressed: (){}, 
                  child: Text('Logout', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.red, fontSize: 14)),
                ),
              )
              //
            ],

            ),
        ),
      ),
    );
  }
}

