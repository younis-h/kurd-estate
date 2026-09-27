import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import 'app_router.dart';

class KurdEstateApp extends StatelessWidget {
  const KurdEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kurd Estate',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      routerConfig: appRouter,
    );
  }
}