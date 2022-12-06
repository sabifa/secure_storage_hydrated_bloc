import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_storage_hydrated_bloc/bloc/todos_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          TextButton(
            onPressed: () => context.read<TodosBloc>().add(const TodosEvent.started()),
            child: const Text('Refresh'),
          ),
          Expanded(
            child: BlocBuilder<TodosBloc, TodosState>(
              builder: (context, state) => state.maybeWhen(
                loadSuccess: (todos) => ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(todos[index].title),
                    subtitle: Text(todos[index].completed.toString()),
                  ),
                ),
                loadFailure: (e) => Text(e),
                orElse: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
