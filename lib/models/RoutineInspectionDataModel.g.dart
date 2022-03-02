// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RoutineInspectionDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineInspectionDataModel _$RoutineInspectionDataModelFromJson(
        Map<String, dynamic> json) =>
    RoutineInspectionDataModel(
      label: json['label'] as String,
      type: json['type'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
      options: json['options'] as List<dynamic>,
      required: json['required'] as bool? ?? false,
    );

Map<String, dynamic> _$RoutineInspectionDataModelToJson(
        RoutineInspectionDataModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'type': instance.type,
      'key': instance.key,
      'value': instance.value,
      'options': instance.options,
      'required': instance.required,
    };
