import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_wheels/data/preferences.dart';
import 'package:open_wheels/providers/providers.dart';
import 'package:open_wheels/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  //SafeProtocol:> iniciar ui en caso de un delay en el future response
  WidgetsFlutterBinding.ensureInitialized();

  //Bloquear orientación de pantalla:> portrait
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //Iniciar preferencias de usuario
  await UserPreferences.init();

  //iniciar aplicación
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BackendProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Open Wheels',
      initialRoute: UserPreferences.autoLogin ? 'home' : 'lobby',
      routes: AppRputes.routes,
    );
  }
}
