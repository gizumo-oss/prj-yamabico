import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    return MaterialApp(
      title: 'Flutter Supabase Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Supabase Example'),
      ),
      body: const Center(
        child: Text('Welcome to Supabase with Flutter!'),
      ),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp() async {
    final response = await supabase.auth.signUp(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!context.mounted) return;
    if (response.user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: 登録に失敗しました。')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Signed up successfully! Please check your email to confirm.',
          ),
        ),
      );
    }
  }

  void _signIn() async {
    final response = await supabase.auth.signInWithPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (!context.mounted) return;
    if (response.user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: サインインに失敗しました。')),
      );
    } else {
      safePrint('test');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase Auth'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}


// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isAuth = false;

//   @override
//   void initState() {
//     super.initState();
//     _configureAmplify().then(
//       (value) => {
//         _isAuthenticated().then((result) => _isAuth = result),
//       },
//     );
//   }

//   Future<void> _configureAmplify() async {
//     try {
//       await Amplify.addPlugin(AmplifyAuthCognito());
//       await Amplify.configure(amplifyconfig);
//       safePrint('Successfully configured');
//     } on Exception catch (e) {
//       safePrint('Error configuring Amplify: $e');
//     }
//   }

//   Future<bool> _isAuthenticated() async {
//     final authState = await Amplify.Auth.fetchAuthSession();
//     return authState.isSignedIn;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute:
//           _isAuth ? RouteType.posts().value() : RouteType.guestTop().value(),
//       routes: RouteType.routeScreenMaps(),
//     );
//   }
// }
