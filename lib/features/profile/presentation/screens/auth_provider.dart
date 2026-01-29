// // lib/features/auth/presentation/providers/auth_provider.dart
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthProvider with ChangeNotifier {
//   User? _currentUser;
//   bool _isLoading = false;

//   User? get currentUser => _currentUser;
//   bool get isLoading => _isLoading;

//   AuthProvider() {
//     _init();
//   }

//   Future<void> _init() async {
//     final supabase = Supabase.instance.client;
//     final currentSession = supabase.auth.currentSession;
    
//     if (currentSession != null) {
//       _currentUser = currentSession.user;
//     }
    
//     supabase.auth.onAuthStateChange.listen((data) {
//       final session = data.session;
//       _currentUser = session?.user;
//       notifyListeners();
//     });
//   }

//   Future<void> signOut() async {
//     try {
//       _isLoading = true;
//       notifyListeners();
      
//       final supabase = Supabase.instance.client;
//       await supabase.auth.signOut();
      
//       _currentUser = null;
//     } catch (error) {
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }