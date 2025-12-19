import 'package:client/features/home/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/core/hive/hive_init.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/hive/models/question_model.dart';
import 'features/questions/viewmodel/question_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInit.init();
  await Supabase.initialize(
    url: 'https://gsiifkumzpfjjoqkuksg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdzaWlma3VtenBmampvcWt1a3NnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU4NzQwOTIsImV4cCI6MjA4MTQ1MDA5Mn0.Z3HvuuyauTHScxyFx1rfAimfCjPZiPXouBp5UYRU_1s', // ✅ Safe to put in app
  );
  runApp(ProviderScope(child: const MyApp()));
}


class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();

      ref.listen<AsyncValue<List<Question>>>(
        questionViewmodelProvider,
            (previous, next) {
          next.whenOrNull(
            error: (error, _) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.toString()),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          );
        },
      );
    }

    ref.read(questionViewmodelProvider.future);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}


