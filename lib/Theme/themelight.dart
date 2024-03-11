import 'package:flutter/material.dart';

class ThemeCustomLight{

static Color primary = const Color.fromARGB(255, 1, 40, 49);
static Color fontColor = const Color.fromARGB(255, 99, 142, 153);
static Color lightBack = const Color.fromARGB(255, 9, 89, 109);

static ThemeData temaGeneral = ThemeData.light().copyWith(
primaryColor: primary,
appBarTheme: AppBarTheme(
  backgroundColor: primary,
  centerTitle: true,
  elevation: 12,
  iconTheme:IconThemeData(color: fontColor, size: 35),
  titleTextStyle:  TextStyle(color: fontColor, fontSize: 35)
),
colorScheme: const ColorScheme.light(
background: Color.fromARGB(255, 184, 240, 255), 
 ),
inputDecorationTheme: InputDecorationTheme(
  enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: primary,
          ),
        ),
  focusedBorder:  UnderlineInputBorder(
          borderSide: BorderSide(
            color: lightBack,
            width: 2
          )
        ),
),
buttonTheme: ButtonThemeData(
  buttonColor: primary,
  padding: const EdgeInsets.all(5), 
),
switchTheme: SwitchThemeData( 
  //TODO: REVISAR DESPUES S ES LA PROPIEDAD ADECUADA
 trackColor: MaterialStateProperty.resolveWith<Color>((states) {
    if (states.contains(MaterialState.disabled)) {
      return Colors.grey.withOpacity(0.12); // Ejemplo de color cuando el switch está desactivado
    }
    return primary; // Ejemplo de color cuando el switch está activado
  }),
  )
); 

 static InputDecoration inputField(
    IconData? icon,
    String hintext, 
    String labeltext
 ){
  return InputDecoration(
  
     hintText: hintext,
        labelText: labeltext,       
        prefixIcon: icon != null  
        ? Icon(icon, color:primary,)
        : null, 
  ); 

 }

static  BoxDecoration decoBox() {
 return BoxDecoration(
  color:const Color.fromRGBO(255, 255, 255, 0.65),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
         BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 5),
      )
    ]
  );
}


}