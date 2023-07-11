import 'package:flutter/material.dart';

import '../../screens/add_patient_screen.dart';
import '../constansts/app_colors.dart';

class AddPatientButton extends StatelessWidget {
  final String screenName;
  const AddPatientButton({
    super.key,
    required this.isAddPatientVisible,
    required this.context,
    required this.screenName,
  });

  final bool isAddPatientVisible;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isAddPatientVisible
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPatientScreen(
                            screenName: screenName,
                          )));
            }
          : null,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: purple300,
          ),
          height: 40,
          width: 100,
          child: const Center(
              child: Text(
            "Add Patient",
            style: TextStyle(color: Colors.white),
          ))),
    );
  }
}
