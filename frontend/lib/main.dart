import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/screens/auth_screen.dart';
import 'package:frontend/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello.'),
        ),
        body: Column(
          children: [
            const Center(
              child: Text(
                'Flutter Demo Home Page',
              ),
            ),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AuthScreen.routeName);
                  },
                  child: const Text('Click'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
