import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../navigation/navigation_service.dart';
import '../session/session_manager.dart';

final getItProvider = Provider<GetIt>((ref) {
  return GetIt.instance;
});

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService();
});

final sessionManagerProvider = Provider<SessionManager>((ref) {
  return ref.read(getItProvider)<SessionManager>();
});

final currentUserProvider = StreamProvider((ref) {
  final sessionManager = ref.read(sessionManagerProvider);

  return sessionManager.authStateChanges.map(
    (_) => sessionManager.currentUser,
  );
});

final isSignedInProvider = Provider<bool>((ref) {
  final sessionManager = ref.read(sessionManagerProvider);

  return sessionManager.isSignedIn;
});