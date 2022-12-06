// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoadInProgress _$$_LoadInProgressFromJson(Map<String, dynamic> json) =>
    _$_LoadInProgress(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LoadInProgressToJson(_$_LoadInProgress instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_LoadSuccess _$$_LoadSuccessFromJson(Map<String, dynamic> json) =>
    _$_LoadSuccess(
      (json['todos'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LoadSuccessToJson(_$_LoadSuccess instance) =>
    <String, dynamic>{
      'todos': instance.todos,
      'runtimeType': instance.$type,
    };

_$_LoadFailure _$$_LoadFailureFromJson(Map<String, dynamic> json) =>
    _$_LoadFailure(
      json['error'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_LoadFailureToJson(_$_LoadFailure instance) =>
    <String, dynamic>{
      'error': instance.error,
      'runtimeType': instance.$type,
    };
