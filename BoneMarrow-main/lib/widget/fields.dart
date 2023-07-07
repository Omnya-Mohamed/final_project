import 'package:flutter/material.dart';
var m_color = Colors.deepPurple[300];
var b_color = Colors.deepPurple[200];
var t_calor =Colors.grey[700];
var t_style = TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color:t_calor,
);

class defultTextFied extends StatelessWidget {
  String? hint;
  String? label;
  Widget? pIcon;
  Widget? sIcon;
  TextInputType? type;
  Function()? onTab;
  Function()? validate;
  Function()? onSave;
  bool? vall = false;
   var mycontroler = TextEditingController();
  defultTextFied({
    this.hint,
    this.label,
    this.onSave,
    this.pIcon,
    this.sIcon,
    this.type,
    this.validate,
    this.vall,
    required this.mycontroler,
    this.onTab,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
  height:70,
      child: TextFormField(
        keyboardType: type,
        validator: validate!(),
        onSaved: onSave!(),
        obscureText: vall!,
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
              borderSide: BorderSide(color: Colors.purple.shade200, width: 1.2)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:BorderSide(color: Colors.purple.shade200, width: 1.2)),
            focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.purple.shade200, width: 1.2),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: pIcon,
            suffixIcon:sIcon,
        ),
        controller: mycontroler,
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
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(redius)),
    );
