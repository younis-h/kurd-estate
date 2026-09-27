import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/config/supabase_options.dart';
import 'core/dependency_injection/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseOptions.url,
    publishableKey: SupabaseOptions.publishableKey,
  );

  await initServiceLocator();

  runApp(
    const ProviderScope(
      child: KurdEstateApp(),
    ),
  );
}