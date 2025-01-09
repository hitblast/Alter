// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppCollection on Isar {
  IsarCollection<App> get apps => this.collection();
}

const AppSchema = CollectionSchema(
  name: r'App',
  id: -3570643489031920837,
  properties: {
    r'customIconPath': PropertySchema(
      id: 0,
      name: r'customIconPath',
      type: IsarType.string,
    ),
    r'newCFBundleIconFile': PropertySchema(
      id: 1,
      name: r'newCFBundleIconFile',
      type: IsarType.string,
    ),
    r'newCFBundleIconName': PropertySchema(
      id: 2,
      name: r'newCFBundleIconName',
      type: IsarType.string,
    ),
    r'path': PropertySchema(
      id: 3,
      name: r'path',
      type: IsarType.string,
    ),
    r'previousCFBundleIconFile': PropertySchema(
      id: 4,
      name: r'previousCFBundleIconFile',
      type: IsarType.string,
    ),
    r'previousCFBundleIconName': PropertySchema(
      id: 5,
      name: r'previousCFBundleIconName',
      type: IsarType.string,
    )
  },
  estimateSize: _appEstimateSize,
  serialize: _appSerialize,
  deserialize: _appDeserialize,
  deserializeProp: _appDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appGetId,
  getLinks: _appGetLinks,
  attach: _appAttach,
  version: '3.1.0+1',
);

int _appEstimateSize(
  App object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.customIconPath.length * 3;
  bytesCount += 3 + object.newCFBundleIconFile.length * 3;
  bytesCount += 3 + object.newCFBundleIconName.length * 3;
  bytesCount += 3 + object.path.length * 3;
  bytesCount += 3 + object.previousCFBundleIconFile.length * 3;
  bytesCount += 3 + object.previousCFBundleIconName.length * 3;
  return bytesCount;
}

void _appSerialize(
  App object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.customIconPath);
  writer.writeString(offsets[1], object.newCFBundleIconFile);
  writer.writeString(offsets[2], object.newCFBundleIconName);
  writer.writeString(offsets[3], object.path);
  writer.writeString(offsets[4], object.previousCFBundleIconFile);
  writer.writeString(offsets[5], object.previousCFBundleIconName);
}

App _appDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = App();
  object.customIconPath = reader.readString(offsets[0]);
  object.id = id;
  object.newCFBundleIconFile = reader.readString(offsets[1]);
  object.newCFBundleIconName = reader.readString(offsets[2]);
  object.path = reader.readString(offsets[3]);
  object.previousCFBundleIconFile = reader.readString(offsets[4]);
  object.previousCFBundleIconName = reader.readString(offsets[5]);
  return object;
}

P _appDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appGetId(App object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appGetLinks(App object) {
  return [];
}

void _appAttach(IsarCollection<dynamic> col, Id id, App object) {
  object.id = id;
}

extension AppQueryWhereSort on QueryBuilder<App, App, QWhere> {
  QueryBuilder<App, App, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppQueryWhere on QueryBuilder<App, App, QWhereClause> {
  QueryBuilder<App, App, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<App, App, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<App, App, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<App, App, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<App, App, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppQueryFilter on QueryBuilder<App, App, QFilterCondition> {
  QueryBuilder<App, App, QAfterFilterCondition> customIconPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customIconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> customIconPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'customIconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> customIconPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'customIconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> customIconPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'customIconPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> customIconPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'customIconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> customIconPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'customIconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> customIconPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'customIconPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> customIconPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'customIconPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> customIconPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'customIconPath',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> customIconPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'customIconPath',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconFileEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconFileGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconFileLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconFileBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newCFBundleIconFile',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconFileStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'newCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconFileEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'newCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconFileContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'newCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconFileMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'newCFBundleIconFile',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconFileIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newCFBundleIconFile',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      newCFBundleIconFileIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'newCFBundleIconFile',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newCFBundleIconName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'newCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'newCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'newCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'newCFBundleIconName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> newCFBundleIconNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newCFBundleIconName',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      newCFBundleIconNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'newCFBundleIconName',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> pathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> pathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> pathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> pathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'path',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> pathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> pathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> pathContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'path',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> pathMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'path',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> pathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> pathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'path',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> previousCFBundleIconFileEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previousCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconFileGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'previousCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconFileLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'previousCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> previousCFBundleIconFileBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'previousCFBundleIconFile',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconFileStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'previousCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconFileEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'previousCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconFileContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'previousCFBundleIconFile',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> previousCFBundleIconFileMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'previousCFBundleIconFile',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconFileIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previousCFBundleIconFile',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconFileIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'previousCFBundleIconFile',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> previousCFBundleIconNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previousCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'previousCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'previousCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> previousCFBundleIconNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'previousCFBundleIconName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'previousCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'previousCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconNameContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'previousCFBundleIconName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition> previousCFBundleIconNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'previousCFBundleIconName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previousCFBundleIconName',
        value: '',
      ));
    });
  }

  QueryBuilder<App, App, QAfterFilterCondition>
      previousCFBundleIconNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'previousCFBundleIconName',
        value: '',
      ));
    });
  }
}

extension AppQueryObject on QueryBuilder<App, App, QFilterCondition> {}

extension AppQueryLinks on QueryBuilder<App, App, QFilterCondition> {}

extension AppQuerySortBy on QueryBuilder<App, App, QSortBy> {
  QueryBuilder<App, App, QAfterSortBy> sortByCustomIconPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customIconPath', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByCustomIconPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customIconPath', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByNewCFBundleIconFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newCFBundleIconFile', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByNewCFBundleIconFileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newCFBundleIconFile', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByNewCFBundleIconName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newCFBundleIconName', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByNewCFBundleIconNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newCFBundleIconName', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByPreviousCFBundleIconFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousCFBundleIconFile', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByPreviousCFBundleIconFileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousCFBundleIconFile', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByPreviousCFBundleIconName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousCFBundleIconName', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> sortByPreviousCFBundleIconNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousCFBundleIconName', Sort.desc);
    });
  }
}

extension AppQuerySortThenBy on QueryBuilder<App, App, QSortThenBy> {
  QueryBuilder<App, App, QAfterSortBy> thenByCustomIconPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customIconPath', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByCustomIconPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'customIconPath', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByNewCFBundleIconFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newCFBundleIconFile', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByNewCFBundleIconFileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newCFBundleIconFile', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByNewCFBundleIconName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newCFBundleIconName', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByNewCFBundleIconNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newCFBundleIconName', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'path', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByPreviousCFBundleIconFile() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousCFBundleIconFile', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByPreviousCFBundleIconFileDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousCFBundleIconFile', Sort.desc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByPreviousCFBundleIconName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousCFBundleIconName', Sort.asc);
    });
  }

  QueryBuilder<App, App, QAfterSortBy> thenByPreviousCFBundleIconNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousCFBundleIconName', Sort.desc);
    });
  }
}

extension AppQueryWhereDistinct on QueryBuilder<App, App, QDistinct> {
  QueryBuilder<App, App, QDistinct> distinctByCustomIconPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'customIconPath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<App, App, QDistinct> distinctByNewCFBundleIconFile(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newCFBundleIconFile',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<App, App, QDistinct> distinctByNewCFBundleIconName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newCFBundleIconName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<App, App, QDistinct> distinctByPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'path', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<App, App, QDistinct> distinctByPreviousCFBundleIconFile(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'previousCFBundleIconFile',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<App, App, QDistinct> distinctByPreviousCFBundleIconName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'previousCFBundleIconName',
          caseSensitive: caseSensitive);
    });
  }
}

extension AppQueryProperty on QueryBuilder<App, App, QQueryProperty> {
  QueryBuilder<App, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<App, String, QQueryOperations> customIconPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'customIconPath');
    });
  }

  QueryBuilder<App, String, QQueryOperations> newCFBundleIconFileProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newCFBundleIconFile');
    });
  }

  QueryBuilder<App, String, QQueryOperations> newCFBundleIconNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newCFBundleIconName');
    });
  }

  QueryBuilder<App, String, QQueryOperations> pathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'path');
    });
  }

  QueryBuilder<App, String, QQueryOperations>
      previousCFBundleIconFileProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'previousCFBundleIconFile');
    });
  }

  QueryBuilder<App, String, QQueryOperations>
      previousCFBundleIconNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'previousCFBundleIconName');
    });
  }
}
