import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:inside_me/services/supabase/databaseServices.dart';

class AuthServices {
  final _supabase = Supabase.instance.client;

  Future<void> signInWithEmail(String email, String password) async {
    final AuthResponse res = await _supabase.auth
        .signInWithPassword(email: email, password: password);
  }

  Future signUpWithEmail(String email, String password, String name) async {
    final AuthResponse res =
        await _supabase.auth.signUp(email: email, password: password);
    // DbServices().addUser(uid, email, name);
  }
}
