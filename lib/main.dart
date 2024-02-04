import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenify_admin_panel/firebase_options.dart';
import 'package:zenify_admin_panel/view/dashboard/admin_screen.dart';
import 'package:zenify_admin_panel/view/dashboard/components/navigation_rail_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //navigation rail provider
          create: (context) => NavigationRailProvider(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            navigationRailTheme: NavigationRailThemeData(
                backgroundColor: MyAppColors.darkBlue,
                selectedIconTheme:
                    IconThemeData(color: MyAppColors.primaryred)),
            drawerTheme: const DrawerThemeData(
              backgroundColor: MyAppColors.primaryred,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: MyAppColors.primaryred,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Metropolis',
                fontSize: 34,
                fontWeight: FontWeight.w800,
              ),
              centerTitle: true,
            ),
            fontFamily: 'Metropolis',
            primaryColor: MyAppColors.primaryred,
            brightness: Brightness.dark,
          ),
          debugShowCheckedModeBanner: false,
          home: const AdminScreen()),
    );
  }
}

class MyAppColors {
  static const darkBlue = Color(0xFF1E1E2C);
  static const primaryred = Color(0xFFDB3022);
}
