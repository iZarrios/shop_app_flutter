import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit as void Function(String)?,
      onChanged: onChange as void Function(String)?,
      onTap: onTap as void Function()?,
      validator: validate as String? Function(String?)?,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 13),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed as void Function()?,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Container defaultButton({
  required Function onPressedFunction,
  required String text,
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
}) {
  return Container(
    width: width,
    height: 40.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
    child: MaterialButton(
      onPressed: onPressedFunction as VoidCallback,
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

TextButton defaultTextButton({
  required Function onPressed,
  required String text,
}) {
  return TextButton(
    onPressed: onPressed as VoidCallback,
    child: Text(
      text.toUpperCase(),
      style: TextStyle(fontSize: 13),
    ),
  );
}
