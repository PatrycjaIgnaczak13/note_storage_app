import 'package:flutter/material.dart';
import 'package:notestorage/utilities/strings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notestorage/utilities/style_utils.dart';

import 'screens/home_screen.dart';

class NoteStorageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Note Storage",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: HomeScreen(),
      localizationsDelegates: [
        Strings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale("en", ""),
      ],
    );
  }
}
