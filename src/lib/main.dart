import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yamabico/feature/posts/presentation/index_screen.dart';
import 'package:yamabico/guest_top_screen.dart';
import 'package:yamabico/provider/auth_provider.dart';
import 'package:yamabico/route_type.dart';

// INFO: ディレクトリ構成参考https://qiita.com/MLLB/items/95617322a7d984b7e402

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = context.watch<AuthProvider>();

    return MaterialApp(
      title: 'Yambico',
      routes: RouteType.routeScreenMaps(),
      home: authProvider.signedIn
        ? const IndexScreen()
        : const GuestTopScreen(),
    );
  }
}
