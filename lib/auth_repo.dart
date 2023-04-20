import 'package:get/get.dart';

import 'api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_constants.dart';
import 'signin_body.dart';
import 'signup_body_model.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.token) ?? "None";
  }

  Future<Response> login(SignInBody signInBody) async {
    return await apiClient.postData(
        AppConstants.LOGIN_URI, signInBody.toJson());
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<void> saveUserNumberAndPassword(
      //String number,
      String password) async {
    try {
      //   await sharedPreferences.setString(AppConstants.Phone, number);
      await sharedPreferences.setString(AppConstants.Password, password);
    } catch (e) {
      throw e;
    }
  }

  bool clearSharedDate() {
    sharedPreferences.remove(AppConstants.token);
    // sharedPreferences.remove(AppConstants.Phone);

    sharedPreferences.remove(AppConstants.Password);
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;
  }
}
