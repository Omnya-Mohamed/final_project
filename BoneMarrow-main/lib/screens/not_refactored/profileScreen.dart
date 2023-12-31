import 'package:flutter/material.dart';
import 'package:g_project/screens/not_refactored/search_screen.dart';
import 'package:g_project/screens/not_refactored/updateProfileScreen.dart';
import 'package:g_project/utils/extensions/capitalize_extension.dart';
import 'package:g_project/shared/widgets/profile_menu_widget.dart';
import 'package:g_project/shared/constansts/app_colors.dart';
import 'package:g_project/core/repos/shared_pref.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../change_password_screen.dart';
import 'welcome_page.dart';

class ProfileScreen extends StatelessWidget {
  final bool isAppBar;
  const ProfileScreen({Key? key, this.isAppBar = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: isAppBar
          ? AppBar(
              backgroundColor: purple300,
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(LineAwesomeIcons.angle_left)),
              title: Text('Profile',
                  style: Theme.of(context).textTheme.headlineMedium),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                        isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
              ],
            )
          : null,
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
                    child: CircleAvatar(
                        radius: 52,
                        backgroundImage:
                            AssetImage('assets/images/Bone_marrow_biopsy.jpg')),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: Container(
                  //     width: 35,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(100),
                  //         color: purple300),
                  //     child:  Icon(
                  //       LineAwesomeIcons.alternate_pencil,
                  //       color: Colors.black,
                  //       size: 20,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 8),
              // Text((CacheHelper.getData(key: 'email') ?? ""),
              //     style: Theme.of(context).textTheme.headlineMedium),
              Text(
                ("${CacheHelper.getData(key: 'userName')}".capitalize() ?? ""),
                style: const TextStyle(fontSize: 28),
              ),
              //  SizedBox(height: 4),
              // Text('+201117762846', ),
              // SizedBox(height: 4),
              // Text('femal', ),
              // SizedBox(height: 4),
              // Text('Beni Suif', ),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: purple300,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Edit Profile',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              //  SizedBox(height: 10),
              const Divider(),
              //   SizedBox(height: 10),

              ProfileMenuWidget(
                  title: "Change Password ",
                  icon: LineAwesomeIcons.cog,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen()));
                  }),
              ProfileMenuWidget(
                  title: " patients",
                  icon: LineAwesomeIcons.person_entering_booth,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchPage(
                              isAppBar: true,
                            )));
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
                  icon: LineAwesomeIcons.alternate_sign_out,
                  onPress: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => WelcomePage()));
                  }),
              // ProfileMenuWidget(
              //     title: "Logout",
              //     icon: LineAwesomeIcons.alternate_sign_out,
              //     textColor: Colors.black,
              //     endIcon: false,
              //     onPress: () {
              //       Get.defaultDialog(
              //         title: "LOGOUT",
              //         titleStyle:  TextStyle(fontSize: 20),
              //         content:  Padding(
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
              //             child:  Text("Yes"),
              //           ),
              //         ),
              //         cancel: OutlinedButton(
              //             onPressed: () => Get.back(), child:  Text("No")),
              //       );
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
