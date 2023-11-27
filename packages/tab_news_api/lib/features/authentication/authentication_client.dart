import 'package:tab_news_api/data/model/models.dart';
import 'package:tab_news_api/features/authentication/login.dart';
import 'package:tab_news_api/features/authentication/password_recovery.dart';
import 'package:tab_news_api/features/authentication/signup.dart';

class AuthenticationClient {

  final _login = Login();
  final _passwordRecovery = PasswordRecovery();
  final _signUp = SignUp();

  Future<SessionModel> login({
    required String email,
    required String password,
    
  }) async {
    return await _login.login(email: email, password: password);
  }

  Future<void> passwordRecovery({
    required String email,
    required String username,
  }) async {
    return await _passwordRecovery.passwordRecovery(
      email: email,
      username: username,
    );
  }

  Future<UserModel> signUp({
    required String email,
    required String username,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await _signUp.call(
      email: email,
      username: username,
      password: password,
    );
  }
}
