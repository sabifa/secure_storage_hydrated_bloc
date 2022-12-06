import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:secure_storage_hydrated_bloc/widgets/home_page.dart';

import 'bloc/todos_bloc.dart';
import 'secure_hydrated_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secureHydratedStorage = SecureHydratedStorage();
  await secureHydratedStorage.initialize();

  HydratedBloc.storage = secureHydratedStorage;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TodosBloc()..add(const TodosEvent.started()),
        child: const HomePage(),
      ),
    );
  }
}
