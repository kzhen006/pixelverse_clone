import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelverse_clone/common/error_page.dart';
import 'package:pixelverse_clone/common/loading_page.dart';
import 'package:pixelverse_clone/features/auth/controller/auth_controller.dart';
import 'package:pixelverse_clone/features/auth/view/login_view.dart';
import 'package:pixelverse_clone/features/auth/view/signup_view.dart';
import 'package:pixelverse_clone/features/home/view/home_view.dart';
import 'package:pixelverse_clone/theme/theme.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Pixelverse Demo',
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(
        data: (user) {
          // print(user!.email);
          if(user!=null) {
            return const HomeView();
          }
          return const SignUpView();
        }, 
        error: (error, st) => ErrorPage(
          error: error.toString()), 
        loading: () => const LoadingPage(),
      ),
    );
  }
}

