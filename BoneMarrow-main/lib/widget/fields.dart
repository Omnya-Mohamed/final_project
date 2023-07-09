import 'package:flutter/material.dart';

var m_color = Colors.deepPurple[300];
var b_color = Colors.deepPurple[200];
var t_calor = Colors.grey[700];
var t_style = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: t_calor,
);

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

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double redius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(redius)),
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
