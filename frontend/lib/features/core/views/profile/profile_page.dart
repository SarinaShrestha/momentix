import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/features/core/views/profile/update_profile_page.dart';
import 'package:frontend/features/core/widgets/profile_details_widget.dart';
import 'package:frontend/utils/colors.dart';
import 'package:frontend/utils/image_strings.dart';
import 'package:frontend/utils/sizes.dart';
import 'package:frontend/widgets/common/thin_elevated_button_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
  
    if (user == null) {
      print("No user logged in.");
      throw Exception("User not logged in.");
    }
    
    String uid = user.uid;
    print("Current User UID: $uid");  // Debugging print
    
    return FirebaseFirestore.instance.collection('Users').doc(uid).get();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Profile', style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body:FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("User data not found."));
          }
          
          var userData = snapshot.data!.data()!;
          String profileImage = '';
          String name = userData['FullName'] ?? '';
          String email = userData['Email'] ?? '';
          String userId = userData['Id'] ?? '';
          String password = userData['Password'] ?? '';

          return SingleChildScrollView(
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
                        child: profileImage.isNotEmpty ?
                          Image.network(profileImage, fit: BoxFit.cover,) :
                          Image.asset(loginImage, fit: BoxFit.cover,),
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
              Text(name, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),),
              Text(email, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15)),
              const SizedBox(height: 20,),
              SizedBox(
                width: 150,
                child: ThinElevatedButtonWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateProfilePage()),
                    );
                  }, 
                  buttonName: 'Edit Profile',
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
                value: name,
                onPressed: (){},
              ),

              ProfileDetailsWidget(
                title: 'UserId',
                value: userId,
                icon: Iconsax.copy,
                onPressed: (){},
              ),

              ProfileDetailsWidget(
                title: 'Gmail', 
                value: email,
                onPressed: (){},
              ),

              ProfileDetailsWidget(
                title: 'Password',
                value: password,
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
      );
    
        },
      ),

    );
  }
}

