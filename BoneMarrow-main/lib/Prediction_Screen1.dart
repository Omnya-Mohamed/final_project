import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:g_project/api_final_edit.dart';
import 'package:g_project/widget/fields.dart';

import 'p_fullResult.dart';

//import 'package:managment/data/model/add_date.dart';
//import 'package:hive_flutter/hive_flutter.dart';

class Prediction_Screen extends StatefulWidget {
  //const Prediction_Screen({super.key});

  @override
  State<Prediction_Screen> createState() => _Prediction_ScreenState();
}

class _Prediction_ScreenState extends State<Prediction_Screen> {
  //final box = Hive.box<Add_data>('data');

  DateTime _ProcessTime = DateTime.now();
  var ProcessTime;

  // String? selctedItem;
  String? selctedItemi;
  String fileName = '';

  var namecontroler = TextEditingController();
  var phonecontroler = TextEditingController();
  var gendercontroler = TextEditingController();
  var agecontroler = TextEditingController();
  var addresscontroler = TextEditingController();
  var n_idcontroler = TextEditingController();
  bool isVissible = false;
  final _key = GlobalKey<FormState>();

  final List<String> _itemei = [
    'Male',
    "Femal",
  ];
  @override
  PlatformFile? file;

  void loadP_File() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        file = result.files.first;
        fileName = file!.name;
      });

      // File file = File(result.files.single.path);
      print(file?.name);
    } else {
      // User canceled the picker
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            background_container(context),
            Positioned(
              top: 120,
              child: main_container(),
            ),
          ],
        ),
      ),
    );
  }

  Container main_container() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      height: 500,
      width: 340,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: defultTextFied(
                    // hint: "Enter National ID",
                    label: " NID",
                    type: TextInputType.number,
                    pIcon: const Icon(Icons.edit),
                    onSave: () => (String? val) {
                      setState(() {
                        ApiHealperFinalEdit.searchInClassificationandPrediction(
                            nationalId: n_idcontroler.text);
                      });
                    },
                    validate: () => (String? val) {
                      if (val!.isEmpty) {
                        return "this field can't be empty";
                      }
                    },
                    vall: false,
                    mycontroler: n_idcontroler,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton.small(
                  onPressed: () {
                    setState(() {
                      ApiHealperFinalEdit.searchInClassificationandPrediction(
                          nationalId: n_idcontroler.text);
                      isVissible = !isVissible;
                    });
                  },
                  backgroundColor: Colors.purple,
                  child: const Icon(Icons.search),
                )
              ],
            ),
          ),
          isVissible
              ? InkWell(
                  onTap: isVissible ? () => loadP_File() : null,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: m_color!,
                      ),
                      height: 40,
                      width: 100,
                      child: const Center(
                          child: Text(
                        "upload files",
                        style: TextStyle(color: Colors.white),
                      ))),
                )
              : Container(),

          const SizedBox(height: 20),
          fileName.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(fileName),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            fileName = '';
                          });
                        },
                        icon: const Icon(Icons.close))
                  ],
                )
              : Container(),
          const SizedBox(height: 20),
          //Spacer(),
          StartProcess(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  GestureDetector StartProcess() {
    return GestureDetector(
      onTap: () {
        myDialog();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepPurple[300],
        ),
        width: 130,
        height: 40,
        child: const Text(
          'Start Process',
          style: TextStyle(
            //fontFamily: 'f',
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Column background_container(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            color: Colors.deepPurple[300],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Text(
                      'Prediction',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const Icon(
                      Icons.notification_add,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  myDialog() {
    Widget saveButton = TextButton(
      child: const Text(
        "Save",
        style: TextStyle(color: Colors.purple),
      ),
      onPressed: () {},
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel", style: TextStyle(color: Colors.purple)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget datailsButton = TextButton(
      child:
          const Text("Show in details", style: TextStyle(color: Colors.purple)),
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          /* return FullResult(
            result: "Nigative",
            PName: "${namecontroler.text}",
            image: pickedImage,
            id: idcontroler.text,
            age: agecontroler.text,
            Gender: gendercontroler.text,
          );*/
          return FullResult();
        }));
      },
    );
    var ad = AlertDialog(
      title: const Center(child: Text("Result")),
      content: const Text("Status:"),
      actions: [
        saveButton,
        cancelButton,
        datailsButton,
      ],
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ad;
        });
  }
}
