import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'RoutineInspectionDataModel.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class RoutineInspectionDataModel {
  String label;
  String type;
  String key;
  String value;

  List<dynamic> options;

  @JsonKey(defaultValue: false)
  bool required;

  RoutineInspectionDataModel(
      {required this.label,
      required this.type,
      required this.key,
      required this.value,
      required this.options,
      required this.required});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RoutineInspectionDataModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineInspectionDataModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RoutineInspectionDataModelToJson(this);
}
