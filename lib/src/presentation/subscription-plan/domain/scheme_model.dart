
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheme_model.freezed.dart';
part 'scheme_model.g.dart';

@freezed
abstract class SchemeModel with _$SchemeModel {
  factory SchemeModel({
    @JsonKey(name: 'schemeplanID') int? schemePlanID,
    double? price,
    String? schemeAdd1,
    String? schemeAdd2,
    int? trailDay,
    @JsonKey(name: 'scheme_Names') String? schemeNames,
    @JsonKey(name: 'storageType') int? storageType,
    String? storage,
    @JsonKey(name: 'user_Capacity') int? userCapacity,
    int? flag,
  }) = _SchemeModel;

  factory SchemeModel.fromJson(Map<String, dynamic> json) =>
      _$SchemeModelFromJson(json);
}


SchemeModel emptySchemeModel = SchemeModel(
  schemePlanID: null,
  price: null,
  schemeAdd1: null,
  schemeAdd2: null,
  trailDay: null,
  schemeNames: null,
  storageType: null,
  storage: null,
  userCapacity: null,
  flag: null,
);

// Now, you have an empty SchemeModel instance that you can use.

