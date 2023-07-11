import 'package:flutter/material.dart';

class defaultTextField extends StatelessWidget {
  String? hint;
  String? label;
  String? initialValue;
  Widget? pIcon;
  Widget? sIcon;
  TextInputType? type;
  Function()? onTab;
  Function()? validate;
  Function()? onSave;
  bool? secureText = false;
  var myController = TextEditingController();
  defaultTextField({
    super.key,
    this.hint,
    this.label,
    this.onSave,
    this.pIcon,
    this.sIcon,
    this.initialValue,
    this.type,
    this.validate,
    this.secureText,
    required this.myController,
    this.onTab,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        keyboardType: type,
        validator: validate!(),
        initialValue: initialValue,
        onSaved: onSave!(),
        obscureText: secureText!,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.grey[700],
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 19,
            color: Colors.grey[700],
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  BorderSide(color: Colors.purple.shade200, width: 1.2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  BorderSide(color: Colors.purple.shade200, width: 1.2)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.purple.shade200, width: 1.2),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: pIcon,
          suffixIcon: sIcon,
        ),
        controller: myController,
      ),
    );
  }
}
