
import 'package:flutter/material.dart';


Widget defaultButton({
  double width=double.infinity,
  double height=50,
  double radius=10,
   Color backColor=Colors.blue,
   Color textColor=Colors.white,
  required String label,
  required void Function()? function,
}){
  return SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(backColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      onPressed: function,
      child:  Text(
        label.toUpperCase(),
        style: TextStyle(
            color: textColor,
        ),
      ),
    ),
  );
}
Future navigateTo({
  required BuildContext context,
  required Widget screen,
})=>Navigator.push(context, MaterialPageRoute(
  builder: (context)=>screen,
));

Future navigateToFinish({
  required BuildContext context,
  required Widget screen,
})=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
  builder: (context)=>screen
), (route) => false);

Widget defaultFormField({
  required var controller,
  required bool obscure,
  required var keyboardType,
  required String label,
   String? Function(String?)? validator,
   String? Function(String?)? onChange,
  TextStyle?textStyle,
  void Function()? onTap,
  Icon ? prefixIcon,
  var  suffixIcon,
  double radius=10,
  TextStyle?hintStyle,
  bool isClickable=true,
  void Function(String)? onSubmit,
  context,
}){
  return TextFormField(
    decoration:  InputDecoration(
      labelText: label,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      labelStyle: hintStyle,
    ),
    controller: controller,
    style: textStyle,
    onFieldSubmitted: onSubmit,
    keyboardType: keyboardType,
    enabled: isClickable,
    obscureText: obscure,
    onChanged: onChange,
    validator: validator,
    onTap: onTap,
  );
}

