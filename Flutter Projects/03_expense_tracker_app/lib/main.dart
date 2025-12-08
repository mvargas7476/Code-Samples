import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';
// This imports the package for rotating the screen
// import 'package:flutter/services.dart';

// Setting up a color based on a seed that you se up here
var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 21, 119, 205));
var kDarkScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark, 
  seedColor: const Color.fromARGB(255, 35, 78, 116)
);

void main() {
  // These two functions allows us to lock the device orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp
  // ]).then((fn) {
  //   runApp(const MainApp());
  // });
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkScheme,
        cardTheme: const CardThemeData().copyWith(
          color: kDarkScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkScheme.primaryContainer,
            foregroundColor: kDarkScheme.onPrimaryContainer
          )
        ),
      ),
      // Setting all of the theme data for the whole app
      // using copyWith so that we are only changing little pieces of ityou could create your own though. 
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer
        ),
        cardTheme: const CardThemeData().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer
          )
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal, 
            color: kColorScheme.onSecondaryContainer, 
            fontSize: 16
          )
        ),
      ),
      themeMode: ThemeMode.system,
      home: Expenses()
    );
  }
}
