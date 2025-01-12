import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:samsung_note/functions/datafunction.dart';

import 'package:samsung_note/home.dart';
import 'package:samsung_note/screens/folder.dart';
import 'package:samsung_note/screens/recycle.dart';
import 'package:samsung_note/themes/extension/light_dark_theme.dart';

void main() async {
  await GetStorage.init();
  loadNotesFromStorage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => SamsungNoteHomePage(),
        '/folder': (context) => FolderWidget(),
        '/recycle': (context) => RecycleWidget(),
      },
    );
  }
}
