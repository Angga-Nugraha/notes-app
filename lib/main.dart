import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/data/model/notes_model.dart';
import 'package:notes_app/view/bloc/notes_bloc/note_bloc.dart';
import 'package:notes_app/view/bloc/pdf_bloc/pdf_bloc.dart';
import "injection.dart" as di;

import 'view/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di.init();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(NoteModelAdapter().typeId)) {
    Hive.registerAdapter(NoteModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NoteBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PDFBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.grey.shade300,
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Colors.black87,
                  onPrimary: Colors.white,
                  secondary: Colors.black87,
                  onSecondary: Colors.white,
                )),
        home: const HomePage(),
      ),
    );
  }
}
