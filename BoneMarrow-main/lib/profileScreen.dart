import 'package:flutter/material.dart';
import 'package:g_project/profileMenuWidget.dart';
import 'package:g_project/search_screen.dart';
import 'package:g_project/updateProfileScreen.dart';
import 'package:g_project/widget/fields.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'changePassword.dart';
import 'f_Page.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key, this.isAppar=false})
      : super(key: key);
  final bool isAppar;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery
        .of(context)
        .platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: isAppar ? AppBar(
        backgroundColor: m_color,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text('Profile', style: Theme
            .of(context)
            .textTheme
            .headline4),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ) : null,
      body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [

                    const Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child:  CircleAvatar(
                              radius: 52,
                              backgroundImage:
                              AssetImage('assets/images/Bone_marrow_biopsy.jpg')
                        ),),
                        // Positioned(
                        //   bottom: 0,
                        //   right: 0,
                        //   child: Container(
                        //     width: 35,
                        //     height: 35,
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(100),
                        //         color:m_color),
                        //     child: const Icon(
                        //       LineAwesomeIcons.alternate_pencil,
                        //       color: Colors.black,
                        //       size: 20,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text("Asmaa Ram", style: Theme
                        .of(context)
                        .textTheme
                        .headline4),
                    Text('asmaa@gmail.com', ),
                    //  SizedBox(height: 4),
                    // Text('+201117762846', ),
                    // SizedBox(height: 4),
                    // Text('femal', ),
                    // SizedBox(height: 4),
                    // Text('Beni Suif', ),
                    SizedBox(
                      width: 180,
                      child: ElevatedButton(
                        onPressed:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpdateProfileScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:m_color,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(
                            'Edit Profile', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                   // const SizedBox(height: 10),
                    const Divider(),
                  //  const SizedBox(height: 10),

                    ProfileMenuWidget(
                        title: "Change Password ",
                        icon: LineAwesomeIcons.cog,
                        onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Changepassword()));
                        }),
                    ProfileMenuWidget(
                        title: " patients",
                        icon: LineAwesomeIcons.person_entering_booth,
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SearchPage(isappbar: true,)));
                        }),
                    // ProfileMenuWidget(
                    //     title: "User Management",
                    //     icon: LineAwesomeIcons.user_check,
                    //     onPress: () {}),

                    ProfileMenuWidget(
                        title: "Information",
                        icon: LineAwesomeIcons.info,
                        onPress: () {}),
                    ProfileMenuWidget(
                        title: "Logout",
                        icon:LineAwesomeIcons.alternate_sign_out,
                        onPress: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => FirstPage()));
                        }),
                    // ProfileMenuWidget(
                    //     title: "Logout",
                    //     icon: LineAwesomeIcons.alternate_sign_out,
                    //     textColor: Colors.black,
                    //     endIcon: false,
                    //     onPress: () {
                    //       Get.defaultDialog(
                    //         title: "LOGOUT",
                    //         titleStyle: const TextStyle(fontSize: 20),
                    //         content: const Padding(
                    //           padding: EdgeInsets.symmetric(vertical: 15.0),
                    //           child: Text("Are you sure, you want to Logout?"),
                    //         ),
                    //         confirm: Expanded(
                    //           child: ElevatedButton(
                    //             onPressed: () {
                    //             },
                    //             style: ElevatedButton.styleFrom(
                    //                 backgroundColor: Colors.redAccent,
                    //                 side: BorderSide.none),
                    //             child: const Text("Yes"),
                    //           ),
                    //         ),
                    //         cancel: OutlinedButton(
                    //             onPressed: () => Get.back(), child: const Text("No")),
                    //       );
                    //     }),
                  ],
                ),
              ),
            ),
    );
          }

  }




