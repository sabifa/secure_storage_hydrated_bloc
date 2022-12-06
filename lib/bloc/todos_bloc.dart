import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:secure_storage_hydrated_bloc/models/todo.dart';

part 'todos_bloc.freezed.dart';
part 'todos_bloc.g.dart';

@freezed
class TodosEvent with _$TodosEvent {
  const factory TodosEvent.started() = _Started;
}

@freezed
class TodosState with _$TodosState {
  const factory TodosState.loadInProgress() = _LoadInProgress;
  const factory TodosState.loadSuccess(
    List<Todo> todos,
  ) = _LoadSuccess;
  const factory TodosState.loadFailure(String error) = _LoadFailure;

  factory TodosState.fromJson(Map<String, dynamic> json) =>
      _$TodosStateFromJson(json);
}

class TodosBloc extends HydratedBloc<TodosEvent, TodosState> {
  late Client client;

  TodosBloc() : super(const _LoadInProgress()) {
    client = Client();

    on<_Started>(_handleStarted);
  }

  Future _handleStarted(
    _Started event,
    Emitter<TodosState> emit,
  ) async {
    emit(const _LoadInProgress());

    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/todos');
      final localHeaders = {
        'Accept': 'application/json',
        'content-type': 'application/json',
      };

      final response = await client.get(uri, headers: localHeaders);
      final todoList = jsonDecode(response.body) as List;

      emit(_LoadSuccess(
        todoList.map((e) => Todo.fromJson(e as Map<String, dynamic>)).toList(),
      ));
    } catch (e) {
      print('Error: while fetching data: $e');
      emit(_LoadFailure(e.toString()));
    }
  }

  @override
  TodosState fromJson(Map<String, dynamic> json) => TodosState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TodosState state) => state.toJson();
}
