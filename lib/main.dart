import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/home',
      routes: <RouteBase>[
        ShellRoute(
          builder: (context, state, child) {
            return MainScreen(child: child);
          },
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              redirect: (_, __) => '/home',
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/userMe',
              builder: (BuildContext context, GoRouterState state) {
                return const MeScreen();
              },
            ),
            GoRoute(
              path: '/user/:id',
              builder: (context, state) {
                final String id = state.pathParameters['id']!;
                return UserScreen(id: id);
              },
            ),
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const NotFoundScreen(),
    );

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black87,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getSelectedIndex(context),
        onTap: (index) => switch (index) {
          0 => context.go('/home'),
          1 => context.go('/userMe'),
          2 => context.go('/settings'),
          _ => context.go('/home'),
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: child,
    );
  }

  int _getSelectedIndex(BuildContext context) {
    const routes = ['/home', '/userMe', '/settings'];
    final location = GoRouterState.of(context).matchedLocation;
    final index = routes.indexOf(location);

    return index != -1 ? index : 0;
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.go('/userMe'),
              child: const Text('Go to the userMe screen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/user/199'),
              child: const Text('Go to the #199 user screen'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/settings'),
              child: const Text('Go to the settings screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Me Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}

class UserScreen extends StatelessWidget {
  const UserScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('The page you are looking for does not exist.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to the Home screen'),
            ),
          ],
        ),
      ),
    );
  }
}
