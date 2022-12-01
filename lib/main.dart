// import 'package:placesapp/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_council_staff/providers/RoutineInspectionProvider.dart';
import 'package:pharmacy_council_staff/screens/RoutineInspectionList.dart';
import 'package:pharmacy_council_staff/screens/UserPin.dart';
import 'package:pharmacy_council_staff/screens/addRoutineInspection.dart';
import 'package:pharmacy_council_staff/screens/dashboard.dart';
import 'package:pharmacy_council_staff/screens/login.dart';
import 'package:pharmacy_council_staff/screens/welcome.dart';
import 'package:provider/provider.dart';

// 2Capsulesnotabs.
void main() async {
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
            create: (context) => RoutineInspectionProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.amber),
          primaryColor: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        home: Welcome(),
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          Dashboard.routeName: (context) => Dashboard(),
          UserPinScreen.routeName: (context) => UserPinScreen(),
          RoutineInspectionListScreen.routeName: (context) =>
              RoutineInspectionListScreen(),
          AddRoutineInspectionScreen.routeName: (context) =>
              AddRoutineInspectionScreen(),
        },
      ),
    );
  }
}
