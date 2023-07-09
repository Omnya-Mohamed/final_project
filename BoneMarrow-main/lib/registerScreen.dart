import 'package:flutter/material.dart';
import 'package:g_project/shared_pref.dart';
import 'package:g_project/widget/fields.dart';

import 'API.dart';
import 'login+_screen.dart';

class DoctorRegist extends StatefulWidget {
  const DoctorRegist({Key? key}) : super(key: key);

  @override
  State<DoctorRegist> createState() => _DoctorRegistState();
}

class _DoctorRegistState extends State<DoctorRegist> {
  String bText = "Sign Up";
  bool lSwitch = true;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _key1 = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var emailcontroler = TextEditingController();
  var passwordcontroler = TextEditingController();
  var comfirmPasscontroler = TextEditingController();
  bool passvisible = true;

  @override
  Widget build(BuildContext context) {
    print('userName ${CacheHelper.getData(
      key: 'email',
    )}');
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.purple, Colors.white],
        )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Rimage.png'),
                        fit: BoxFit.fill)),
              ),
              Text(
                "Hello!",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Register(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Have an account ?",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => Login_Screen()));
                    setState(() {
                      lSwitch = !lSwitch;
                    });
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }

  Form Register() {
    return Form(
      key: _key,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            defaultTextField(
              hint: "enter your name",
              type: TextInputType.text,
              pIcon: Icon(Icons.person),
              onSave: () => (String? val) {
                setState(() {});
              },
              validate: () => (String? val) {
                if (val!.isEmpty) {
                  return "this field can't be empty";
                }
              },
              secureText: false,
              myController: namecontroller,
            ),
            SizedBox(
              height: 10,
            ),
            defaultTextField(
              hint: "enter your Email",
              // label: "Email",
              type: TextInputType.emailAddress,
              pIcon: Icon(Icons.email),
              onSave: () => (String? val) {
                setState(() {});
              },
              validate: () => (String? val) {
                if (val!.isEmpty) {
                  return "this field can't be empty";
                }
              },
              secureText: false,
              myController: emailcontroler,
            ),
            SizedBox(
              height: 8.0,
            ),
            defaultTextField(
              hint: "Enter Password",
              //  label: "Password",
              type: TextInputType.text,
              pIcon: Icon(Icons.lock),
              sIcon: IconButton(
                icon: Icon(
                  passvisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    passvisible = !passvisible;
                  });
                },
              ),
              onSave: () => (String? val) {
                setState(() {});
              },
              validate: () => (String? val) {
                if (val!.isEmpty) {
                  return "this field can't be empty";
                }
              },
              secureText: false,
              myController: passwordcontroler,
            ),
            SizedBox(
              height: 8.0,
            ),
            defaultTextField(
              hint: "Comfirm password",
              label: "Comfirm password",
              type: TextInputType.text,
              pIcon: Icon(Icons.lock),
              sIcon: IconButton(
                icon: Icon(
                  passvisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    passvisible = !passvisible;
                  });
                },
              ),
              onSave: () => (String? val) {
                setState(() {});
              },
              validate: () => (String? val) {
                if (val!.isEmpty) {
                  return "this field can't be empty";
                }
              },
              secureText: false,
              myController: comfirmPasscontroler,
            ),
            SizedBox(
              height: 8.0,
            ),
            MaterialButton(
                minWidth: 30.0,
                color: Colors.purple.shade300,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.purple.shade300),
                    borderRadius: BorderRadius.circular(15.0)),
                onPressed: () {
                  print(namecontroller.text.toString());
                  if (_key.currentState!.validate()) {
                    ApiHelper.registerAuth(
                            userName: namecontroller.text.toString().trim(),
                            email: emailcontroler.text.toString(),
                            password: passwordcontroler.text.toString(),
                            rePassword: comfirmPasscontroler.text.toString())
                        .then((value) {
                      if (value.email == null) {
                        final snackBar = SnackBar(
                          content: const Text('try again'),
                          backgroundColor: Colors.red.shade900,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        const snackBar = SnackBar(
                          content:
                              Text('check your gmail then go to login screen'),
                          backgroundColor: Color.fromARGB(255, 37, 238, 51),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Register ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
