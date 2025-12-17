// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'commandresult_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommandResult {

 String get appBundleId; String get customIconPath; String get newCFBundleIconName; String get newCFBundleIconFile; String get previousCFBundleIconName; String get previousCFBundleIconFile;
/// Create a copy of CommandResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommandResultCopyWith<CommandResult> get copyWith => _$CommandResultCopyWithImpl<CommandResult>(this as CommandResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommandResult&&(identical(other.appBundleId, appBundleId) || other.appBundleId == appBundleId)&&(identical(other.customIconPath, customIconPath) || other.customIconPath == customIconPath)&&(identical(other.newCFBundleIconName, newCFBundleIconName) || other.newCFBundleIconName == newCFBundleIconName)&&(identical(other.newCFBundleIconFile, newCFBundleIconFile) || other.newCFBundleIconFile == newCFBundleIconFile)&&(identical(other.previousCFBundleIconName, previousCFBundleIconName) || other.previousCFBundleIconName == previousCFBundleIconName)&&(identical(other.previousCFBundleIconFile, previousCFBundleIconFile) || other.previousCFBundleIconFile == previousCFBundleIconFile));
}


@override
int get hashCode => Object.hash(runtimeType,appBundleId,customIconPath,newCFBundleIconName,newCFBundleIconFile,previousCFBundleIconName,previousCFBundleIconFile);

@override
String toString() {
  return 'CommandResult(appBundleId: $appBundleId, customIconPath: $customIconPath, newCFBundleIconName: $newCFBundleIconName, newCFBundleIconFile: $newCFBundleIconFile, previousCFBundleIconName: $previousCFBundleIconName, previousCFBundleIconFile: $previousCFBundleIconFile)';
}


}

/// @nodoc
abstract mixin class $CommandResultCopyWith<$Res>  {
  factory $CommandResultCopyWith(CommandResult value, $Res Function(CommandResult) _then) = _$CommandResultCopyWithImpl;
@useResult
$Res call({
 String appBundleId, String customIconPath, String newCFBundleIconName, String newCFBundleIconFile, String previousCFBundleIconName, String previousCFBundleIconFile
});




}
/// @nodoc
class _$CommandResultCopyWithImpl<$Res>
    implements $CommandResultCopyWith<$Res> {
  _$CommandResultCopyWithImpl(this._self, this._then);

  final CommandResult _self;
  final $Res Function(CommandResult) _then;

/// Create a copy of CommandResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? appBundleId = null,Object? customIconPath = null,Object? newCFBundleIconName = null,Object? newCFBundleIconFile = null,Object? previousCFBundleIconName = null,Object? previousCFBundleIconFile = null,}) {
  return _then(_self.copyWith(
appBundleId: null == appBundleId ? _self.appBundleId : appBundleId // ignore: cast_nullable_to_non_nullable
as String,customIconPath: null == customIconPath ? _self.customIconPath : customIconPath // ignore: cast_nullable_to_non_nullable
as String,newCFBundleIconName: null == newCFBundleIconName ? _self.newCFBundleIconName : newCFBundleIconName // ignore: cast_nullable_to_non_nullable
as String,newCFBundleIconFile: null == newCFBundleIconFile ? _self.newCFBundleIconFile : newCFBundleIconFile // ignore: cast_nullable_to_non_nullable
as String,previousCFBundleIconName: null == previousCFBundleIconName ? _self.previousCFBundleIconName : previousCFBundleIconName // ignore: cast_nullable_to_non_nullable
as String,previousCFBundleIconFile: null == previousCFBundleIconFile ? _self.previousCFBundleIconFile : previousCFBundleIconFile // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommandResult].
extension CommandResultPatterns on CommandResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommandResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommandResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommandResult value)  $default,){
final _that = this;
switch (_that) {
case _CommandResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommandResult value)?  $default,){
final _that = this;
switch (_that) {
case _CommandResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String appBundleId,  String customIconPath,  String newCFBundleIconName,  String newCFBundleIconFile,  String previousCFBundleIconName,  String previousCFBundleIconFile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommandResult() when $default != null:
return $default(_that.appBundleId,_that.customIconPath,_that.newCFBundleIconName,_that.newCFBundleIconFile,_that.previousCFBundleIconName,_that.previousCFBundleIconFile);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String appBundleId,  String customIconPath,  String newCFBundleIconName,  String newCFBundleIconFile,  String previousCFBundleIconName,  String previousCFBundleIconFile)  $default,) {final _that = this;
switch (_that) {
case _CommandResult():
return $default(_that.appBundleId,_that.customIconPath,_that.newCFBundleIconName,_that.newCFBundleIconFile,_that.previousCFBundleIconName,_that.previousCFBundleIconFile);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String appBundleId,  String customIconPath,  String newCFBundleIconName,  String newCFBundleIconFile,  String previousCFBundleIconName,  String previousCFBundleIconFile)?  $default,) {final _that = this;
switch (_that) {
case _CommandResult() when $default != null:
return $default(_that.appBundleId,_that.customIconPath,_that.newCFBundleIconName,_that.newCFBundleIconFile,_that.previousCFBundleIconName,_that.previousCFBundleIconFile);case _:
  return null;

}
}

}

/// @nodoc


class _CommandResult implements CommandResult {
  const _CommandResult({required this.appBundleId, required this.customIconPath, required this.newCFBundleIconName, required this.newCFBundleIconFile, required this.previousCFBundleIconName, required this.previousCFBundleIconFile});
  

@override final  String appBundleId;
@override final  String customIconPath;
@override final  String newCFBundleIconName;
@override final  String newCFBundleIconFile;
@override final  String previousCFBundleIconName;
@override final  String previousCFBundleIconFile;

/// Create a copy of CommandResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommandResultCopyWith<_CommandResult> get copyWith => __$CommandResultCopyWithImpl<_CommandResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommandResult&&(identical(other.appBundleId, appBundleId) || other.appBundleId == appBundleId)&&(identical(other.customIconPath, customIconPath) || other.customIconPath == customIconPath)&&(identical(other.newCFBundleIconName, newCFBundleIconName) || other.newCFBundleIconName == newCFBundleIconName)&&(identical(other.newCFBundleIconFile, newCFBundleIconFile) || other.newCFBundleIconFile == newCFBundleIconFile)&&(identical(other.previousCFBundleIconName, previousCFBundleIconName) || other.previousCFBundleIconName == previousCFBundleIconName)&&(identical(other.previousCFBundleIconFile, previousCFBundleIconFile) || other.previousCFBundleIconFile == previousCFBundleIconFile));
}


@override
int get hashCode => Object.hash(runtimeType,appBundleId,customIconPath,newCFBundleIconName,newCFBundleIconFile,previousCFBundleIconName,previousCFBundleIconFile);

@override
String toString() {
  return 'CommandResult(appBundleId: $appBundleId, customIconPath: $customIconPath, newCFBundleIconName: $newCFBundleIconName, newCFBundleIconFile: $newCFBundleIconFile, previousCFBundleIconName: $previousCFBundleIconName, previousCFBundleIconFile: $previousCFBundleIconFile)';
}


}

/// @nodoc
abstract mixin class _$CommandResultCopyWith<$Res> implements $CommandResultCopyWith<$Res> {
  factory _$CommandResultCopyWith(_CommandResult value, $Res Function(_CommandResult) _then) = __$CommandResultCopyWithImpl;
@override @useResult
$Res call({
 String appBundleId, String customIconPath, String newCFBundleIconName, String newCFBundleIconFile, String previousCFBundleIconName, String previousCFBundleIconFile
});




}
/// @nodoc
class __$CommandResultCopyWithImpl<$Res>
    implements _$CommandResultCopyWith<$Res> {
  __$CommandResultCopyWithImpl(this._self, this._then);

  final _CommandResult _self;
  final $Res Function(_CommandResult) _then;

/// Create a copy of CommandResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? appBundleId = null,Object? customIconPath = null,Object? newCFBundleIconName = null,Object? newCFBundleIconFile = null,Object? previousCFBundleIconName = null,Object? previousCFBundleIconFile = null,}) {
  return _then(_CommandResult(
appBundleId: null == appBundleId ? _self.appBundleId : appBundleId // ignore: cast_nullable_to_non_nullable
as String,customIconPath: null == customIconPath ? _self.customIconPath : customIconPath // ignore: cast_nullable_to_non_nullable
as String,newCFBundleIconName: null == newCFBundleIconName ? _self.newCFBundleIconName : newCFBundleIconName // ignore: cast_nullable_to_non_nullable
as String,newCFBundleIconFile: null == newCFBundleIconFile ? _self.newCFBundleIconFile : newCFBundleIconFile // ignore: cast_nullable_to_non_nullable
as String,previousCFBundleIconName: null == previousCFBundleIconName ? _self.previousCFBundleIconName : previousCFBundleIconName // ignore: cast_nullable_to_non_nullable
as String,previousCFBundleIconFile: null == previousCFBundleIconFile ? _self.previousCFBundleIconFile : previousCFBundleIconFile // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
