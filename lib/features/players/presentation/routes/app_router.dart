import 'package:go_router/go_router.dart';
import 'package:pl_tots/features/players/presentation/screens/home_screen.dart'; // Adjusted import path

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
