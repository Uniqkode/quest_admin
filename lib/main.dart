import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quest_admin/inner_screen/loan_review.dart';
import 'package:quest_admin/pages/admin_approval.dart';

import 'consts/theme_data.dart';
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
          create: (_) =>DarkThemeProvider(),
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
              title: 'Loan Admin',
              theme: Styles.themeData(themeProvider.getDarkTheme, context),
              home: const LoanApprovalPage(),
              routes: {
                LoanReviewPage.routeName: (context) =>
                    const LoanReviewPage(),
              });
        },
      ),
    );
  }
}
