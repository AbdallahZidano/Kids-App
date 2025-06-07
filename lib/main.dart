import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/alphabet_provider.dart';
import 'providers/color_provider.dart';
import 'providers/game_provider.dart';
import 'providers/game_sound_provider.dart';
import 'providers/number_provider.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AlphabetProvider()),
        ChangeNotifierProvider(create: (_) => GameSoundProvider()),
        ChangeNotifierProvider(create: (_) => NumberProvider()),
      ],
      child: MaterialApp(
        title: 'Kids Learning',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: 'ComicNeue',
        ),
        home: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.isFirstTime) {
              return const WelcomeScreen();
            }
            return const HomeScreen();
          },
        ),
      ),
    );
  }
}
