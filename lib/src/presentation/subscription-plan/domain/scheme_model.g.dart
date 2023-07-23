// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SchemeModel _$$_SchemeModelFromJson(Map<String, dynamic> json) =>
    _$_SchemeModel(
      schemePlanID: json['schemeplanID'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      schemeAdd1: json['schemeAdd1'] as String?,
      schemeAdd2: json['schemeAdd2'] as String?,
      trailDay: json['trailDay'] as int?,
      schemeNames: json['scheme_Names'] as String?,
      storageType: json['storageType'] as int?,
      storage: json['storage'] as String?,
      userCapacity: json['user_Capacity'] as int?,
      flag: json['flag'] as int?,
    );

Map<String, dynamic> _$$_SchemeModelToJson(_$_SchemeModel instance) =>
    <String, dynamic>{
      'schemeplanID': instance.schemePlanID,
      'price': instance.price,
      'schemeAdd1': instance.schemeAdd1,
      'schemeAdd2': instance.schemeAdd2,
      'trailDay': instance.trailDay,
      'scheme_Names': instance.schemeNames,
      'storageType': instance.storageType,
      'storage': instance.storage,
      'user_Capacity': instance.userCapacity,
      'flag': instance.flag,
    };
