import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yamabico/feature/auth/infra/amplifyconfiguration.dart';

// REF: https://dev.classmethod.jp/articles/flutter-cognito-screen-switch/
class AuthProvider extends ChangeNotifier {
  bool signedIn = false;

  Future<void> _configure() async {
    if (!Amplify.isConfigured) {
      await Amplify.addPlugins([AmplifyAuthCognito(), AmplifyAPI()]);
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured');
    }

    try {
      await Amplify.Auth.getCurrentUser();
      signedIn = true;
    } on AuthException {
      signedIn = false;
    }

    notifyListeners();
  }

  AuthProvider() {
    _configure();
  }

  // Future<void> signIn() async {
  //   try {
  //     await Amplify.Auth.signInWithWebUI();
  //     signedIn = true;
  //   } on AuthException {
  //     signedIn = false;
  //   }

  //   notifyListeners();
  // }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();
      signedIn = false;
      safePrint(signedIn);
    } on AuthException {
      safePrint('failed signed out');
      signedIn = true;
    }

    notifyListeners();
  }
}
