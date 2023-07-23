
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_state.freezed.dart';


@freezed
class CommonState<T> with _$CommonState<T> {
  const factory CommonState.initial() = _Initial<T>;
  const factory CommonState.loading() = _Loading<T>;
  const factory CommonState.success(T data) = Success<T>;
  const factory CommonState.error(String error) = _Error<T>;
  const factory CommonState.empty() = _Empty<T>;
}