import 'package:draw_straight_line_app/app/router/router.dart';
import 'package:draw_straight_line_app/model/provider/shape_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Proper Supabase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseKey = dotenv.env['SUPABASE_KEY'];
  if (supabaseUrl == null || supabaseKey == null) {
    throw Exception("Missing Supabase configuration. Check your .env file.");
  }
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  //---x

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ShapeProvider())],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Draw Straight Line App',

      debugShowCheckedModeBanner: false,
    );
  }
}
