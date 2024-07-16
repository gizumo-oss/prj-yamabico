import 'package:flutter/material.dart';
import 'package:yamabico/feature/login/presentation/login_screen.dart';
import 'package:yamabico/feature/posts/presentation/index_screen.dart';
import 'package:yamabico/guest_top_screen.dart';
import 'package:yamabico/invalid_argument_exception.dart';

// REF: https://tech.excite.co.jp/entry/2022/09/12/120000

class RouteType {
  static const Map<String, String> _paths = {
    'guestTop': '/',
    'login': '/login',
    'posts': '/posts',
    'userDetail': '/user_detail',
  };

  final String? _value;

  RouteType(this._value) {
    // INFO: https://zenn.dev/flutteruniv_dev/articles/ae607839cd4573 (!の扱いはnullじゃないことを明示的にしている)
    if (_value == null || _value!.isEmpty) {
      throw InvalidArgumentException('値がNULLまたは空です');
    }

    if (!_paths.containsValue(_value)) {
      throw InvalidArgumentException('存在しないパスです');
    }
  }

  RouteType.guestTop() : this(_paths['guestTop']);
  RouteType.login() : this(_paths['login']);
  RouteType.posts() : this(_paths['posts']);
  RouteType.userDetail() : this(_paths['userDetail']);

  String value() {
    return _value!;
  }

  static Map<String, Widget Function(BuildContext)> routeScreenMaps() {
    return {
      _paths['guestTop']!: (context) => GuestTopScreen(),
      _paths['login']!: (context) => const LoginScreen(),
      _paths['posts']!: (context) => const IndexScreen(),
      // TODO: userDetailへの遷移を実装する
      // _paths['userDetail']!: (context) => const UserDetailScreen(),
    };
  }
}
