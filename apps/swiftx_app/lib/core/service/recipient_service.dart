import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/model/user_model.dart';
import 'package:swiftx_app/core/service/auth_service.dart';
import 'package:swiftx_app/core/supabase.dart';

class RecipientService {
  Future<List<UserModel>> getRecipients() async {
    final user = supabase.auth.currentUser;
    final response =
        await supabase.from("users").select().neq("email", user!.email!);
    return response.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<List<UserModel>> searchRecipients(String query) async {
    final user = await locator<AuthService>().getUserData();
    final response = await supabase
        .from("users")
        .select()
        .neq("email", user.email)
        .neq("country", user.country)
        .or('username.ilike.$query%,email.ilike.%$query%,name.ilike.%$query%');
    return response.map((e) => UserModel.fromMap(e)).toList();
  }
}
