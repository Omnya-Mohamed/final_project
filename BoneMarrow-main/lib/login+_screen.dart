import 'package:flutter/material.dart';
import 'package:g_project/API.dart';
import 'package:g_project/registerScreen.dart';
import 'package:g_project/widget/fields.dart';

import 'ResetPage.dart';
import 'home_screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  String bText = "Sign Up";
  bool lSwitch = false;
  String? Email;

  var password;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _key1 = GlobalKey<FormState>();
  var _namecontroller = TextEditingController();
  var passwordcontroler = TextEditingController();

  //var phonecontroller = TextEditingController(;
  var emailcontroler = TextEditingController();

  bool passvisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:AssetImage('assets/images/background1.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/light-1.png'))),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/light-2.png'))),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/clock.png'))),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "Welcome Doctor",
                        style: TextStyle(
                            color: Colors.purple.shade300,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      lSwitch ? const DoctorRegist() : Login(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don\'t  have an account ?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DoctorRegist()),
                                );
                                setState(() {
                                  // lSwitch = !lSwitch;
                                });
                              },
                              child: Text(
                                "Register Now",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.purple.shade200),
                              ),
                            ),
                          ]),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Image.asset("assets/images/google.png"),
                      //     const SizedBox(
                      //       width: 20,
                      //     ),
                      //     Image.asset("assets/images/facebook.png"),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form Login() {
    return Form(
      key: _key1,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            defultTextFied(
              hint: "Enter your username",
              label: "UserName",
              type: TextInputType.emailAddress,
              pIcon: const Icon(Icons.perm_identity_outlined),
              onSave: () => (String? val) {
                setState(() {
                  // Email = _namecontroller.text;
                });
              },
              validate: () => (String? val) {
                if (val!.isEmpty) {
                  return "this field can't be empty";
                }
              },
              vall: false,
              mycontroler: _namecontroller,
            ),
            const SizedBox(
              height: 15,
            ),
            defultTextFied(
              hint: "Enter Password",
              label: "Password",
              type: TextInputType.visiblePassword,
              pIcon: Icon(Icons.lock, color: Colors.purple.shade100),
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
                setState(() {
                  //  password = passwordcontroler.text;
                });
              },
              validate: () => (String? val) {
                if (val!.isEmpty) {
                  return "this field can't be empty";
                }
              },
              vall: passvisible,
              mycontroler: passwordcontroler,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Text(
                    "Forget Password ?",
                    style: TextStyle(color: Colors.purple),
                  ),
                  onTap: () => myDialog(),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            MaterialButton(
                minWidth: 30.0,
                color: Colors.purple.shade300,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.purple.shade300),
                    borderRadius: BorderRadius.circular(15.0)),
                onPressed: () {
                  if (_key1.currentState!.validate()) {
                    ApiHealper.loginAuth(
                      userName: _namecontroller.text.toString().trim(),
                      password: passwordcontroler.text.toString(),
                    ).then((value) {
                      if (value.authToken == null) {
                       
                        final snackBar = SnackBar(
                          content: const Text('try again'),
                          backgroundColor: Colors.red.shade900,
                        );

                       
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
            
                        final snackBar = SnackBar(
                          content: Text('successfuly'),
                          backgroundColor:
                              const Color.fromARGB(255, 37, 238, 51),
                        );


                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Future.delayed(const Duration(seconds: 4), () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => HomePage()));
                        });
                      }
                    });

                    ;
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "login",
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

  myDialog() {
    var ad = AlertDialog(
      title: Center(child: Text("Enter your Email")),
      //content: Text("Status:"),
      actions: [
        defultTextFied(
          hint: "Enter your Email",
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
          vall: false,
          mycontroler: emailcontroler,
        ),
        SizedBox(height: 15),
        MaterialButton(
            minWidth: 30.0,
            color: Colors.purple.shade300,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.purple.shade300),
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => ResetPage()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Reset",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ))
      ],
    );
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return ad;
        });
  }
}
