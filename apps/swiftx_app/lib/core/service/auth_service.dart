import 'package:swiftx_app/core/model/user_model.dart';
import 'package:swiftx_app/core/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  /// Signs a user up with a email and password.
  Future<AuthResponse> signUpUser({
    required String password,
    required String email,
    required String phone,
    required String name,
    required String username,
    required String country,
  }) async {
    return await supabase.auth.signUp(email: email, password: password, data: {
      'name': name,
      'phone': phone,
      'username': username,
      'country': country,
    });
  }

  Future<AuthResponse> signInUser(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<UserModel> getUserData({String? email}) async {
    final user = supabase.auth.currentUser;
    final response =
        await supabase.from("users").select().eq("email", email ?? user!.email!).single();
    return UserModel.fromMap(response);
  }

  Future<bool> checkUsername(String username) async {
    final response =
        await supabase.from("users").select().eq("username", username);
    return response.isNotEmpty;
  }

  Future<void> signOut() async {
    return await supabase.auth.signOut();
  }

  Future<void> verifyUser() async {
    final user = supabase.auth.currentUser;
    return await supabase.from("users").update({"verified": true}).eq(
      "email",
      user!.email!,
    );
  }

  bool isUserSignedIn() {
    return supabase.auth.currentUser != null;
  }

  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }
}
