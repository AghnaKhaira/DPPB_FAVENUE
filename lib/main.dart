import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/role_selection_screen.dart';
import 'screens/home_screen.dart';
import 'screens/developer_list_screen.dart';
import 'screens/umkm_list_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/developer_home_screen.dart';
import 'screens/umkm_home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/knowledge_screen.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favenue',
      theme: AppTheme.lightTheme,
      home: const LandingScreen(),
      routes: {
        '/landing': (context) => const LandingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/role-selection': (context) => const RoleSelectionScreen(),
        '/about': (context) => const AboutScreen(),
        '/explore': (context) => const ExploreScreen(),
        '/knowledge': (context) => const KnowledgeScreen(),
        '/developer-role': (context) => const DeveloperHomeScreen(),
        '/umkm-role': (context) => const UMKMHomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/developer-home': (context) => const DeveloperHomeScreen(),
        '/umkm-home': (context) => const UMKMHomeScreen(),
        '/developers': (context) => const DeveloperListScreen(),
        '/umkm': (context) => const UMKMListScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
