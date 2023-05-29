import 'package:firebase_core/firebase_core.dart';
import 'package:flutix/blocs/blocs.dart';
import 'package:flutix/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'services/services.dart';

Future<void> main() async {
  // Load .env file
  await dotenv.load(fileName: '.env');
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService.userStream,
      initialData: null,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PageBloc>(create: (ctx) => PageBloc()),
          BlocProvider<UserBloc>(create: (ctx) => UserBloc()),
          BlocProvider<ThemeBloc>(create: (ctx) => ThemeBloc()),
          BlocProvider<MovieBloc>(
            create: (ctx) => MovieBloc()..add(FetchMovies()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (ctx, themeState) => MaterialApp(
            theme: themeState.themeData,
            debugShowCheckedModeBanner: true,
            home: const Wrapper(),
          ),
        ),
      ),
    );
  }
}
