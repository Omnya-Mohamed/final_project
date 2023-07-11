import 'package:flutter/material.dart';
import 'package:g_project/shared/constansts/app_colors.dart';
import 'package:g_project/shared/constansts/app_values.dart';
import '../../screens/change_password_screen.dart';
import '../../screens/classification_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/not_refactored/prediction_screen.dart';
import '../../screens/not_refactored/profileScreen.dart';
import '../../screens/not_refactored/search_screen.dart';
import '../../screens/not_refactored/welcome_page.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  //  NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final double _drawerIconSize = 24;
  final double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          buildDrawerHeader(context),
          SingleChildScrollView(
            child: buildDrawerItems(context),
          )
        ],
      ),
    );
  }

  buildDrawerHeader(BuildContext context) {
    return Container(
      color: purple300,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Column(
        children: [
          const CircleAvatar(
              radius: 52,
              backgroundImage:
                  AssetImage('assets/images/Bone_marrow_biopsy.jpg')
              //backgroundImage: NetworkImage("https://static.sciencelearn.org.nz/images/images/000/004/324/embed/Bone_marrow_biopsy.jpg?1674173795"),
              ),
          SizedBox(
            height: s_10,
          ),
          const Text(
            "Bone_marrow",
            style: TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "(Transplantation)",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItems(BuildContext context) {
    return Container(
      child: Wrap(
        runSpacing: 0.0,
        children: [
          ListTile(
            leading: Icon(
              Icons.screen_lock_landscape_rounded,
              size: _drawerIconSize,
              color: purple300,
            ),
            title: const Text(
              'Classification',
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClassificationScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.screen_lock_landscape_rounded,
              size: _drawerIconSize,
              color: purple300,
            ),
            title: Text(
              'Prediction',
              style: TextStyle(fontSize: _drawerFontSize, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PredictionScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              size: _drawerIconSize,
              color: purple300,
            ),
            title: Text(
              'Search for Patient',
              style: TextStyle(fontSize: _drawerFontSize, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchPage(
                            isAppBar: true,
                          )));
            },
          ),

          // ListTile(
          //   leading: Icon(Icons.person_add_alt_1,
          //       size: _drawerIconSize, color:Colors.purple.shade200),
          //   title: Text(
          //     'Registration Page',
          //     style: TextStyle(
          //         fontSize: _drawerFontSize,
          //         color:Colors.black),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => DoctorRegist()),
          //     );
          //   }
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.password_rounded,
          //     size: _drawerIconSize,
          //     color: Colors.purple.shade200,
          //   ),
          //   title: Text(
          //     'Forgot Password Page',
          //     style: TextStyle(
          //         fontSize: _drawerFontSize,
          //         color: Colors.black),
          //   ),
          //   /* onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
          //     );
          //   },*/
          // ),
          // /*ListTile(
          //   leading: Icon(
          //     Icons.verified_user_sharp,
          //     size: _drawerIconSize,
          //     color: Theme.of(context).accentColor,
          //   ),
          //   title: Text(
          //     'Verification Page',
          //     style: TextStyle(
          //         fontSize: _drawerFontSize,
          //         color: Theme.of(context).accentColor),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => ForgotPasswordVerificationPage()),
          //     );
          //   },
          // ),*/
          ListTile(
            leading: Icon(
              Icons.account_circle,
              size: _drawerIconSize,
              color: purple300,
            ),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: _drawerFontSize, color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProfileScreen(
                        isAppBar: true,
                      )));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: _drawerIconSize,
              color: purple300,
            ),
            title: Text(
              'Change Password',
              style: TextStyle(fontSize: _drawerFontSize, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.login_rounded,
                size: _drawerIconSize, color: purple300),
            title: Text(
              'Login Page',
              style: TextStyle(fontSize: _drawerFontSize, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login_Screen()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              size: _drawerIconSize,
              color: Colors.red,
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: _drawerFontSize, color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WelcomePage()));
            },
          ),
        ],
      ),
    );
  }
}
