//import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_project/widget/fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? pickedImage;

  CameraImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      pickedImage = File(
        image.path,
      );
    });
  }

  GalleryImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      pickedImage = File(
        image.path,
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'UPdate Profile',
        ),
        backgroundColor: m_color,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(
                          'assets/images/Bone_marrow_biopsy.jpg')), // SizedBox(
                  //   width: 120,
                  //   height: 120,
                  //   child: ClipRRect(
                  //       borderRadius: BorderRadius.circular(50),
                  //       child:  pickedImage == null
                  //           ? Image(
                  //           image: AssetImage('assets/images/doctor2.jpg'))
                  //           : Image.file(
                  //         pickedImage!,
                  //         // width: 400,
                  //         // height: 400,
                  //       )
                  //
                  //       ),
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () => myDialog(),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white),
                        child: const Icon(LineAwesomeIcons.camera,
                            color: Colors.black, size: 25),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('New Username'),
                        prefixIcon: const Icon(LineAwesomeIcons.user),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.purple.shade200, width: 1.2),
                        ),
                      ),
                    ),

                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     label: Text('New Email'),
                    //     prefixIcon: Icon(LineAwesomeIcons.envelope_1),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(20),
                    //       borderSide: BorderSide(
                    //           color: Colors.purple.shade200, width: 1.2),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('NEW Phone'),
                        prefixIcon: const Icon(LineAwesomeIcons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.purple.shade200, width: 1.2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text('New Address'),
                        prefixIcon: Icon(LineAwesomeIcons.envelope_1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.purple.shade200, width: 1.2),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Update',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 1),
                    // -- Created Date and Delete Button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  myDialog() {
    var ad = AlertDialog(
      title: Center(child: Text("Chose Image From")),
      //content: Text("Status:"),
      actions: [
        MaterialButton(
            minWidth: 30.0,
            color: Colors.purple.shade300,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.purple.shade300),
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () => CameraImage(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Camera",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            )),
        SizedBox(width: 15),
        MaterialButton(
            minWidth: 30.0,
            color: Colors.purple.shade300,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.purple.shade300),
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () => GalleryImage(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Gallery",
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
