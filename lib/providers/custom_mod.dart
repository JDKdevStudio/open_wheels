import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';

class Mod {
  static uiOverlay(Color? color) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarDividerColor: color,
      systemNavigationBarColor: color,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
 
  }
  
}
