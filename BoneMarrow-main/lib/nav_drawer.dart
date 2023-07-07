import 'package:flutter/material.dart';
import 'package:g_project/profileScreen.dart';
import 'package:g_project/search_screen.dart';
import 'package:g_project/widget/fields.dart';

import 'Prediction_Screen1.dart';
import 'changePassword.dart';
import 'classification_screen.dart';
import 'f_Page.dart';
import 'login+_screen.dart';

class NavDrawer extends StatefulWidget {
  // const NavDrawer({Key? key}) : super(key: key);

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
      color: m_color,
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
            height: 10,
          ),
          Text(
            "Bone_marrow",
            style: TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "(Transplantation)",
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
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
              color:  m_color,
            ),
            title: Text(
              'Classification',
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Classification()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.screen_lock_landscape_rounded,
              size: _drawerIconSize,
              color:  m_color,
            ),
            title: Text(
              'Prediction',
              style: TextStyle(fontSize: _drawerFontSize, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Prediction_Screen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              size: _drawerIconSize,
              color:  m_color,
            ),
            title: Text(
              'Search for Patient',
              style: TextStyle(fontSize: _drawerFontSize, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage(isappbar: true,)));
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
              color:  m_color,
            ),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: _drawerFontSize, color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                        isAppar: true,
                      )));
            },
          ),
          ListTile(
              leading: Icon(
                Icons.settings,
                size: _drawerIconSize,
                color:  m_color,
              ),
              title: Text(
                'Change Password',
                style:
                    TextStyle(fontSize: _drawerFontSize, color: Colors.black),
              ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const Changepassword()));
          },
          ),
          ListTile(
            leading: Icon(Icons.login_rounded,
                size: _drawerIconSize, color: m_color),
            title: Text(
              'Login Page',
              style: TextStyle(
                  fontSize: _drawerFontSize,
                  color:Colors.black
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login_Screen()),
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
                  .push(MaterialPageRoute(builder: (context) => FirstPage()));
            },
          ),
        ],
      ),
    );
  }
}
