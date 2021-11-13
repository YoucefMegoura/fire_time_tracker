import 'package:flutter/widgets.dart';

import 'auth_service.dart';

class AuthProvider extends InheritedWidget {
  Widget child;
  AuthService auth;

  AuthProvider({
    required this.child,
    required this.auth,
  }) : super(child: child);

  static AuthService? of(BuildContext context) {
    AuthProvider? provider = context.dependOnInheritedWidgetOfExactType();
    print('dsfs');
    return provider!.auth;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
