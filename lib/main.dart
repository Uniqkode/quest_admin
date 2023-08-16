import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_admin/screens/main_screen.dart';

import 'consts/theme_data.dart';
import '../controllers/MenuController.dart' as menucont;
import 'inner_screens/add_prod.dart';
import 'providers/dark_theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => menucont.MenuController(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Grocery',
              theme: Styles.themeData(themeProvider.getDarkTheme, context),
              home: const MainScreen(),
              routes: {
                UploadProductForm.routeName: (context) =>
                    const UploadProductForm(),
              });
        },
      ),
    );
  }
}
