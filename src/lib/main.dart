import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yamabico/route_type.dart';

// INFO: ディレクトリ構成参考https://qiita.com/MLLB/items/95617322a7d984b7e402

void main() async {
  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Supabase.instance.client.auth.currentUser;

    return MaterialApp(
      title: 'Yamabico',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: RouteType.routeScreenMaps(),
      initialRoute: (user == null)
          ? RouteType.guestTop().value()
          : RouteType.posts().value(),
    );
  }
}
