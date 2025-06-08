import 'package:flutter/material.dart';
import 'package:kids_learning/providers/alphabet_game_provider.dart';
import 'package:provider/provider.dart';

import 'providers/alphabet_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/color_provider.dart';
import 'providers/game_provider.dart';
import 'providers/game_sound_provider.dart';
import 'providers/month_provider.dart';
import 'providers/number_provider.dart';
import 'providers/user_provider.dart';
import 'screens/auth/login_screen.dart';
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
        ChangeNotifierProvider(create: (_) => AlphabetGameProvider()),
        ChangeNotifierProvider(create: (_) => MonthProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Kids Learning',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: 'ComicNeue',
        ),
        home: Consumer2<UserProvider, AuthProvider>(
          builder: (context, userProvider, authProvider, child) {
            if (userProvider.isFirstTime) {
              return const WelcomeScreen();
            }
            if (!authProvider.isAuthenticated) {
              return const LoginScreen();
            }
            return const HomeScreen();
          },
        ),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
