// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bodymind_database.dart';

// ignore_for_file: type=lint
class TbOnboardStatus extends Table
    with TableInfo<TbOnboardStatus, TbOnboardStatusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TbOnboardStatus(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _onboardSnMeta = const VerificationMeta(
    'onboardSn',
  );
  late final GeneratedColumn<int> onboardSn = GeneratedColumn<int>(
    'onboard_sn',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY',
  );
  static const VerificationMeta _onboardYnMeta = const VerificationMeta(
    'onboardYn',
  );
  late final GeneratedColumn<String> onboardYn = GeneratedColumn<String>(
    'onboard_yn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [onboardSn, onboardYn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_onboard_status';
  @override
  VerificationContext validateIntegrity(
    Insertable<TbOnboardStatusData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('onboard_sn')) {
      context.handle(
        _onboardSnMeta,
        onboardSn.isAcceptableOrUnknown(data['onboard_sn']!, _onboardSnMeta),
      );
    }
    if (data.containsKey('onboard_yn')) {
      context.handle(
        _onboardYnMeta,
        onboardYn.isAcceptableOrUnknown(data['onboard_yn']!, _onboardYnMeta),
      );
    } else if (isInserting) {
      context.missing(_onboardYnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {onboardSn};
  @override
  TbOnboardStatusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbOnboardStatusData(
      onboardSn: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}onboard_sn'],
      ),
      onboardYn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}onboard_yn'],
      )!,
    );
  }

  @override
  TbOnboardStatus createAlias(String alias) {
    return TbOnboardStatus(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TbOnboardStatusData extends DataClass
    implements Insertable<TbOnboardStatusData> {
  final int? onboardSn;
  final String onboardYn;
  const TbOnboardStatusData({this.onboardSn, required this.onboardYn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || onboardSn != null) {
      map['onboard_sn'] = Variable<int>(onboardSn);
    }
    map['onboard_yn'] = Variable<String>(onboardYn);
    return map;
  }

  TbOnboardStatusCompanion toCompanion(bool nullToAbsent) {
    return TbOnboardStatusCompanion(
      onboardSn: onboardSn == null && nullToAbsent
          ? const Value.absent()
          : Value(onboardSn),
      onboardYn: Value(onboardYn),
    );
  }

  factory TbOnboardStatusData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbOnboardStatusData(
      onboardSn: serializer.fromJson<int?>(json['onboard_sn']),
      onboardYn: serializer.fromJson<String>(json['onboard_yn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'onboard_sn': serializer.toJson<int?>(onboardSn),
      'onboard_yn': serializer.toJson<String>(onboardYn),
    };
  }

  TbOnboardStatusData copyWith({
    Value<int?> onboardSn = const Value.absent(),
    String? onboardYn,
  }) => TbOnboardStatusData(
    onboardSn: onboardSn.present ? onboardSn.value : this.onboardSn,
    onboardYn: onboardYn ?? this.onboardYn,
  );
  TbOnboardStatusData copyWithCompanion(TbOnboardStatusCompanion data) {
    return TbOnboardStatusData(
      onboardSn: data.onboardSn.present ? data.onboardSn.value : this.onboardSn,
      onboardYn: data.onboardYn.present ? data.onboardYn.value : this.onboardYn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbOnboardStatusData(')
          ..write('onboardSn: $onboardSn, ')
          ..write('onboardYn: $onboardYn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(onboardSn, onboardYn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbOnboardStatusData &&
          other.onboardSn == this.onboardSn &&
          other.onboardYn == this.onboardYn);
}

class TbOnboardStatusCompanion extends UpdateCompanion<TbOnboardStatusData> {
  final Value<int?> onboardSn;
  final Value<String> onboardYn;
  const TbOnboardStatusCompanion({
    this.onboardSn = const Value.absent(),
    this.onboardYn = const Value.absent(),
  });
  TbOnboardStatusCompanion.insert({
    this.onboardSn = const Value.absent(),
    required String onboardYn,
  }) : onboardYn = Value(onboardYn);
  static Insertable<TbOnboardStatusData> custom({
    Expression<int>? onboardSn,
    Expression<String>? onboardYn,
  }) {
    return RawValuesInsertable({
      if (onboardSn != null) 'onboard_sn': onboardSn,
      if (onboardYn != null) 'onboard_yn': onboardYn,
    });
  }

  TbOnboardStatusCompanion copyWith({
    Value<int?>? onboardSn,
    Value<String>? onboardYn,
  }) {
    return TbOnboardStatusCompanion(
      onboardSn: onboardSn ?? this.onboardSn,
      onboardYn: onboardYn ?? this.onboardYn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (onboardSn.present) {
      map['onboard_sn'] = Variable<int>(onboardSn.value);
    }
    if (onboardYn.present) {
      map['onboard_yn'] = Variable<String>(onboardYn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbOnboardStatusCompanion(')
          ..write('onboardSn: $onboardSn, ')
          ..write('onboardYn: $onboardYn')
          ..write(')'))
        .toString();
  }
}

class TbUserInfo extends Table with TableInfo<TbUserInfo, TbUserInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TbUserInfo(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nickNameMeta = const VerificationMeta(
    'nickName',
  );
  late final GeneratedColumn<String> nickName = GeneratedColumn<String>(
    'nick_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
    'age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [nickName, age, height, weight, gender];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_user_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<TbUserInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('nick_name')) {
      context.handle(
        _nickNameMeta,
        nickName.isAcceptableOrUnknown(data['nick_name']!, _nickNameMeta),
      );
    } else if (isInserting) {
      context.missing(_nickNameMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
        _ageMeta,
        age.isAcceptableOrUnknown(data['age']!, _ageMeta),
      );
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TbUserInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbUserInfoData(
      nickName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nick_name'],
      )!,
      age: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}age'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
    );
  }

  @override
  TbUserInfo createAlias(String alias) {
    return TbUserInfo(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TbUserInfoData extends DataClass implements Insertable<TbUserInfoData> {
  final String nickName;
  final int age;
  final double height;
  final double weight;
  final String gender;
  const TbUserInfoData({
    required this.nickName,
    required this.age,
    required this.height,
    required this.weight,
    required this.gender,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['nick_name'] = Variable<String>(nickName);
    map['age'] = Variable<int>(age);
    map['height'] = Variable<double>(height);
    map['weight'] = Variable<double>(weight);
    map['gender'] = Variable<String>(gender);
    return map;
  }

  TbUserInfoCompanion toCompanion(bool nullToAbsent) {
    return TbUserInfoCompanion(
      nickName: Value(nickName),
      age: Value(age),
      height: Value(height),
      weight: Value(weight),
      gender: Value(gender),
    );
  }

  factory TbUserInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbUserInfoData(
      nickName: serializer.fromJson<String>(json['nick_name']),
      age: serializer.fromJson<int>(json['age']),
      height: serializer.fromJson<double>(json['height']),
      weight: serializer.fromJson<double>(json['weight']),
      gender: serializer.fromJson<String>(json['gender']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'nick_name': serializer.toJson<String>(nickName),
      'age': serializer.toJson<int>(age),
      'height': serializer.toJson<double>(height),
      'weight': serializer.toJson<double>(weight),
      'gender': serializer.toJson<String>(gender),
    };
  }

  TbUserInfoData copyWith({
    String? nickName,
    int? age,
    double? height,
    double? weight,
    String? gender,
  }) => TbUserInfoData(
    nickName: nickName ?? this.nickName,
    age: age ?? this.age,
    height: height ?? this.height,
    weight: weight ?? this.weight,
    gender: gender ?? this.gender,
  );
  TbUserInfoData copyWithCompanion(TbUserInfoCompanion data) {
    return TbUserInfoData(
      nickName: data.nickName.present ? data.nickName.value : this.nickName,
      age: data.age.present ? data.age.value : this.age,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      gender: data.gender.present ? data.gender.value : this.gender,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbUserInfoData(')
          ..write('nickName: $nickName, ')
          ..write('age: $age, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('gender: $gender')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(nickName, age, height, weight, gender);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbUserInfoData &&
          other.nickName == this.nickName &&
          other.age == this.age &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.gender == this.gender);
}

class TbUserInfoCompanion extends UpdateCompanion<TbUserInfoData> {
  final Value<String> nickName;
  final Value<int> age;
  final Value<double> height;
  final Value<double> weight;
  final Value<String> gender;
  final Value<int> rowid;
  const TbUserInfoCompanion({
    this.nickName = const Value.absent(),
    this.age = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.gender = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TbUserInfoCompanion.insert({
    required String nickName,
    required int age,
    required double height,
    required double weight,
    required String gender,
    this.rowid = const Value.absent(),
  }) : nickName = Value(nickName),
       age = Value(age),
       height = Value(height),
       weight = Value(weight),
       gender = Value(gender);
  static Insertable<TbUserInfoData> custom({
    Expression<String>? nickName,
    Expression<int>? age,
    Expression<double>? height,
    Expression<double>? weight,
    Expression<String>? gender,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (nickName != null) 'nick_name': nickName,
      if (age != null) 'age': age,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (gender != null) 'gender': gender,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TbUserInfoCompanion copyWith({
    Value<String>? nickName,
    Value<int>? age,
    Value<double>? height,
    Value<double>? weight,
    Value<String>? gender,
    Value<int>? rowid,
  }) {
    return TbUserInfoCompanion(
      nickName: nickName ?? this.nickName,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (nickName.present) {
      map['nick_name'] = Variable<String>(nickName.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbUserInfoCompanion(')
          ..write('nickName: $nickName, ')
          ..write('age: $age, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('gender: $gender, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class TbDailyHrProxyInfo extends Table
    with TableInfo<TbDailyHrProxyInfo, TbDailyHrProxyInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TbDailyHrProxyInfo(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _isrtDtMeta = const VerificationMeta('isrtDt');
  late final GeneratedColumn<String> isrtDt = GeneratedColumn<String>(
    'isrt_dt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY',
  );
  static const VerificationMeta _restBaseMeta = const VerificationMeta(
    'restBase',
  );
  late final GeneratedColumn<double> restBase = GeneratedColumn<double>(
    'rest_base',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _varBaseMeta = const VerificationMeta(
    'varBase',
  );
  late final GeneratedColumn<double> varBase = GeneratedColumn<double>(
    'var_base',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _highBaseMeta = const VerificationMeta(
    'highBase',
  );
  late final GeneratedColumn<double> highBase = GeneratedColumn<double>(
    'high_base',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  @override
  List<GeneratedColumn> get $columns => [isrtDt, restBase, varBase, highBase];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_daily_hr_proxy_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<TbDailyHrProxyInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('isrt_dt')) {
      context.handle(
        _isrtDtMeta,
        isrtDt.isAcceptableOrUnknown(data['isrt_dt']!, _isrtDtMeta),
      );
    }
    if (data.containsKey('rest_base')) {
      context.handle(
        _restBaseMeta,
        restBase.isAcceptableOrUnknown(data['rest_base']!, _restBaseMeta),
      );
    }
    if (data.containsKey('var_base')) {
      context.handle(
        _varBaseMeta,
        varBase.isAcceptableOrUnknown(data['var_base']!, _varBaseMeta),
      );
    }
    if (data.containsKey('high_base')) {
      context.handle(
        _highBaseMeta,
        highBase.isAcceptableOrUnknown(data['high_base']!, _highBaseMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {isrtDt};
  @override
  TbDailyHrProxyInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbDailyHrProxyInfoData(
      isrtDt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isrt_dt'],
      ),
      restBase: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rest_base'],
      ),
      varBase: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}var_base'],
      ),
      highBase: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}high_base'],
      ),
    );
  }

  @override
  TbDailyHrProxyInfo createAlias(String alias) {
    return TbDailyHrProxyInfo(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TbDailyHrProxyInfoData extends DataClass
    implements Insertable<TbDailyHrProxyInfoData> {
  final String? isrtDt;
  final double? restBase;
  final double? varBase;
  final double? highBase;
  const TbDailyHrProxyInfoData({
    this.isrtDt,
    this.restBase,
    this.varBase,
    this.highBase,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || isrtDt != null) {
      map['isrt_dt'] = Variable<String>(isrtDt);
    }
    if (!nullToAbsent || restBase != null) {
      map['rest_base'] = Variable<double>(restBase);
    }
    if (!nullToAbsent || varBase != null) {
      map['var_base'] = Variable<double>(varBase);
    }
    if (!nullToAbsent || highBase != null) {
      map['high_base'] = Variable<double>(highBase);
    }
    return map;
  }

  TbDailyHrProxyInfoCompanion toCompanion(bool nullToAbsent) {
    return TbDailyHrProxyInfoCompanion(
      isrtDt: isrtDt == null && nullToAbsent
          ? const Value.absent()
          : Value(isrtDt),
      restBase: restBase == null && nullToAbsent
          ? const Value.absent()
          : Value(restBase),
      varBase: varBase == null && nullToAbsent
          ? const Value.absent()
          : Value(varBase),
      highBase: highBase == null && nullToAbsent
          ? const Value.absent()
          : Value(highBase),
    );
  }

  factory TbDailyHrProxyInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbDailyHrProxyInfoData(
      isrtDt: serializer.fromJson<String?>(json['isrt_dt']),
      restBase: serializer.fromJson<double?>(json['rest_base']),
      varBase: serializer.fromJson<double?>(json['var_base']),
      highBase: serializer.fromJson<double?>(json['high_base']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'isrt_dt': serializer.toJson<String?>(isrtDt),
      'rest_base': serializer.toJson<double?>(restBase),
      'var_base': serializer.toJson<double?>(varBase),
      'high_base': serializer.toJson<double?>(highBase),
    };
  }

  TbDailyHrProxyInfoData copyWith({
    Value<String?> isrtDt = const Value.absent(),
    Value<double?> restBase = const Value.absent(),
    Value<double?> varBase = const Value.absent(),
    Value<double?> highBase = const Value.absent(),
  }) => TbDailyHrProxyInfoData(
    isrtDt: isrtDt.present ? isrtDt.value : this.isrtDt,
    restBase: restBase.present ? restBase.value : this.restBase,
    varBase: varBase.present ? varBase.value : this.varBase,
    highBase: highBase.present ? highBase.value : this.highBase,
  );
  TbDailyHrProxyInfoData copyWithCompanion(TbDailyHrProxyInfoCompanion data) {
    return TbDailyHrProxyInfoData(
      isrtDt: data.isrtDt.present ? data.isrtDt.value : this.isrtDt,
      restBase: data.restBase.present ? data.restBase.value : this.restBase,
      varBase: data.varBase.present ? data.varBase.value : this.varBase,
      highBase: data.highBase.present ? data.highBase.value : this.highBase,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbDailyHrProxyInfoData(')
          ..write('isrtDt: $isrtDt, ')
          ..write('restBase: $restBase, ')
          ..write('varBase: $varBase, ')
          ..write('highBase: $highBase')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(isrtDt, restBase, varBase, highBase);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbDailyHrProxyInfoData &&
          other.isrtDt == this.isrtDt &&
          other.restBase == this.restBase &&
          other.varBase == this.varBase &&
          other.highBase == this.highBase);
}

class TbDailyHrProxyInfoCompanion
    extends UpdateCompanion<TbDailyHrProxyInfoData> {
  final Value<String?> isrtDt;
  final Value<double?> restBase;
  final Value<double?> varBase;
  final Value<double?> highBase;
  final Value<int> rowid;
  const TbDailyHrProxyInfoCompanion({
    this.isrtDt = const Value.absent(),
    this.restBase = const Value.absent(),
    this.varBase = const Value.absent(),
    this.highBase = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TbDailyHrProxyInfoCompanion.insert({
    this.isrtDt = const Value.absent(),
    this.restBase = const Value.absent(),
    this.varBase = const Value.absent(),
    this.highBase = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<TbDailyHrProxyInfoData> custom({
    Expression<String>? isrtDt,
    Expression<double>? restBase,
    Expression<double>? varBase,
    Expression<double>? highBase,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (isrtDt != null) 'isrt_dt': isrtDt,
      if (restBase != null) 'rest_base': restBase,
      if (varBase != null) 'var_base': varBase,
      if (highBase != null) 'high_base': highBase,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TbDailyHrProxyInfoCompanion copyWith({
    Value<String?>? isrtDt,
    Value<double?>? restBase,
    Value<double?>? varBase,
    Value<double?>? highBase,
    Value<int>? rowid,
  }) {
    return TbDailyHrProxyInfoCompanion(
      isrtDt: isrtDt ?? this.isrtDt,
      restBase: restBase ?? this.restBase,
      varBase: varBase ?? this.varBase,
      highBase: highBase ?? this.highBase,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (isrtDt.present) {
      map['isrt_dt'] = Variable<String>(isrtDt.value);
    }
    if (restBase.present) {
      map['rest_base'] = Variable<double>(restBase.value);
    }
    if (varBase.present) {
      map['var_base'] = Variable<double>(varBase.value);
    }
    if (highBase.present) {
      map['high_base'] = Variable<double>(highBase.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbDailyHrProxyInfoCompanion(')
          ..write('isrtDt: $isrtDt, ')
          ..write('restBase: $restBase, ')
          ..write('varBase: $varBase, ')
          ..write('highBase: $highBase, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class TbFeatureActInfo extends Table
    with TableInfo<TbFeatureActInfo, TbFeatureActInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TbFeatureActInfo(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _isrtDtMeta = const VerificationMeta('isrtDt');
  late final GeneratedColumn<String> isrtDt = GeneratedColumn<String>(
    'isrt_dt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY',
  );
  static const VerificationMeta _stepCountMeta = const VerificationMeta(
    'stepCount',
  );
  late final GeneratedColumn<int> stepCount = GeneratedColumn<int>(
    'step_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _distanceMeta = const VerificationMeta(
    'distance',
  );
  late final GeneratedColumn<double> distance = GeneratedColumn<double>(
    'distance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _calorieMeta = const VerificationMeta(
    'calorie',
  );
  late final GeneratedColumn<double> calorie = GeneratedColumn<double>(
    'calorie',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [isrtDt, stepCount, distance, calorie];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_feature_act_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<TbFeatureActInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('isrt_dt')) {
      context.handle(
        _isrtDtMeta,
        isrtDt.isAcceptableOrUnknown(data['isrt_dt']!, _isrtDtMeta),
      );
    }
    if (data.containsKey('step_count')) {
      context.handle(
        _stepCountMeta,
        stepCount.isAcceptableOrUnknown(data['step_count']!, _stepCountMeta),
      );
    } else if (isInserting) {
      context.missing(_stepCountMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(
        _distanceMeta,
        distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta),
      );
    } else if (isInserting) {
      context.missing(_distanceMeta);
    }
    if (data.containsKey('calorie')) {
      context.handle(
        _calorieMeta,
        calorie.isAcceptableOrUnknown(data['calorie']!, _calorieMeta),
      );
    } else if (isInserting) {
      context.missing(_calorieMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {isrtDt};
  @override
  TbFeatureActInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbFeatureActInfoData(
      isrtDt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isrt_dt'],
      ),
      stepCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_count'],
      )!,
      distance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance'],
      )!,
      calorie: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calorie'],
      )!,
    );
  }

  @override
  TbFeatureActInfo createAlias(String alias) {
    return TbFeatureActInfo(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TbFeatureActInfoData extends DataClass
    implements Insertable<TbFeatureActInfoData> {
  final String? isrtDt;
  final int stepCount;
  final double distance;
  final double calorie;
  const TbFeatureActInfoData({
    this.isrtDt,
    required this.stepCount,
    required this.distance,
    required this.calorie,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || isrtDt != null) {
      map['isrt_dt'] = Variable<String>(isrtDt);
    }
    map['step_count'] = Variable<int>(stepCount);
    map['distance'] = Variable<double>(distance);
    map['calorie'] = Variable<double>(calorie);
    return map;
  }

  TbFeatureActInfoCompanion toCompanion(bool nullToAbsent) {
    return TbFeatureActInfoCompanion(
      isrtDt: isrtDt == null && nullToAbsent
          ? const Value.absent()
          : Value(isrtDt),
      stepCount: Value(stepCount),
      distance: Value(distance),
      calorie: Value(calorie),
    );
  }

  factory TbFeatureActInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbFeatureActInfoData(
      isrtDt: serializer.fromJson<String?>(json['isrt_dt']),
      stepCount: serializer.fromJson<int>(json['step_count']),
      distance: serializer.fromJson<double>(json['distance']),
      calorie: serializer.fromJson<double>(json['calorie']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'isrt_dt': serializer.toJson<String?>(isrtDt),
      'step_count': serializer.toJson<int>(stepCount),
      'distance': serializer.toJson<double>(distance),
      'calorie': serializer.toJson<double>(calorie),
    };
  }

  TbFeatureActInfoData copyWith({
    Value<String?> isrtDt = const Value.absent(),
    int? stepCount,
    double? distance,
    double? calorie,
  }) => TbFeatureActInfoData(
    isrtDt: isrtDt.present ? isrtDt.value : this.isrtDt,
    stepCount: stepCount ?? this.stepCount,
    distance: distance ?? this.distance,
    calorie: calorie ?? this.calorie,
  );
  TbFeatureActInfoData copyWithCompanion(TbFeatureActInfoCompanion data) {
    return TbFeatureActInfoData(
      isrtDt: data.isrtDt.present ? data.isrtDt.value : this.isrtDt,
      stepCount: data.stepCount.present ? data.stepCount.value : this.stepCount,
      distance: data.distance.present ? data.distance.value : this.distance,
      calorie: data.calorie.present ? data.calorie.value : this.calorie,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureActInfoData(')
          ..write('isrtDt: $isrtDt, ')
          ..write('stepCount: $stepCount, ')
          ..write('distance: $distance, ')
          ..write('calorie: $calorie')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(isrtDt, stepCount, distance, calorie);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbFeatureActInfoData &&
          other.isrtDt == this.isrtDt &&
          other.stepCount == this.stepCount &&
          other.distance == this.distance &&
          other.calorie == this.calorie);
}

class TbFeatureActInfoCompanion extends UpdateCompanion<TbFeatureActInfoData> {
  final Value<String?> isrtDt;
  final Value<int> stepCount;
  final Value<double> distance;
  final Value<double> calorie;
  final Value<int> rowid;
  const TbFeatureActInfoCompanion({
    this.isrtDt = const Value.absent(),
    this.stepCount = const Value.absent(),
    this.distance = const Value.absent(),
    this.calorie = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TbFeatureActInfoCompanion.insert({
    this.isrtDt = const Value.absent(),
    required int stepCount,
    required double distance,
    required double calorie,
    this.rowid = const Value.absent(),
  }) : stepCount = Value(stepCount),
       distance = Value(distance),
       calorie = Value(calorie);
  static Insertable<TbFeatureActInfoData> custom({
    Expression<String>? isrtDt,
    Expression<int>? stepCount,
    Expression<double>? distance,
    Expression<double>? calorie,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (isrtDt != null) 'isrt_dt': isrtDt,
      if (stepCount != null) 'step_count': stepCount,
      if (distance != null) 'distance': distance,
      if (calorie != null) 'calorie': calorie,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TbFeatureActInfoCompanion copyWith({
    Value<String?>? isrtDt,
    Value<int>? stepCount,
    Value<double>? distance,
    Value<double>? calorie,
    Value<int>? rowid,
  }) {
    return TbFeatureActInfoCompanion(
      isrtDt: isrtDt ?? this.isrtDt,
      stepCount: stepCount ?? this.stepCount,
      distance: distance ?? this.distance,
      calorie: calorie ?? this.calorie,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (isrtDt.present) {
      map['isrt_dt'] = Variable<String>(isrtDt.value);
    }
    if (stepCount.present) {
      map['step_count'] = Variable<int>(stepCount.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double>(distance.value);
    }
    if (calorie.present) {
      map['calorie'] = Variable<double>(calorie.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureActInfoCompanion(')
          ..write('isrtDt: $isrtDt, ')
          ..write('stepCount: $stepCount, ')
          ..write('distance: $distance, ')
          ..write('calorie: $calorie, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class TbFeatureHrInfo extends Table
    with TableInfo<TbFeatureHrInfo, TbFeatureHrInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TbFeatureHrInfo(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _isrtDtMeta = const VerificationMeta('isrtDt');
  late final GeneratedColumn<String> isrtDt = GeneratedColumn<String>(
    'isrt_dt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY',
  );
  static const VerificationMeta _hrLstMeta = const VerificationMeta('hrLst');
  late final GeneratedColumn<String> hrLst = GeneratedColumn<String>(
    'hr_lst',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [isrtDt, hrLst];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_feature_hr_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<TbFeatureHrInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('isrt_dt')) {
      context.handle(
        _isrtDtMeta,
        isrtDt.isAcceptableOrUnknown(data['isrt_dt']!, _isrtDtMeta),
      );
    }
    if (data.containsKey('hr_lst')) {
      context.handle(
        _hrLstMeta,
        hrLst.isAcceptableOrUnknown(data['hr_lst']!, _hrLstMeta),
      );
    } else if (isInserting) {
      context.missing(_hrLstMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {isrtDt};
  @override
  TbFeatureHrInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbFeatureHrInfoData(
      isrtDt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}isrt_dt'],
      ),
      hrLst: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hr_lst'],
      )!,
    );
  }

  @override
  TbFeatureHrInfo createAlias(String alias) {
    return TbFeatureHrInfo(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TbFeatureHrInfoData extends DataClass
    implements Insertable<TbFeatureHrInfoData> {
  final String? isrtDt;
  final String hrLst;
  const TbFeatureHrInfoData({this.isrtDt, required this.hrLst});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || isrtDt != null) {
      map['isrt_dt'] = Variable<String>(isrtDt);
    }
    map['hr_lst'] = Variable<String>(hrLst);
    return map;
  }

  TbFeatureHrInfoCompanion toCompanion(bool nullToAbsent) {
    return TbFeatureHrInfoCompanion(
      isrtDt: isrtDt == null && nullToAbsent
          ? const Value.absent()
          : Value(isrtDt),
      hrLst: Value(hrLst),
    );
  }

  factory TbFeatureHrInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbFeatureHrInfoData(
      isrtDt: serializer.fromJson<String?>(json['isrt_dt']),
      hrLst: serializer.fromJson<String>(json['hr_lst']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'isrt_dt': serializer.toJson<String?>(isrtDt),
      'hr_lst': serializer.toJson<String>(hrLst),
    };
  }

  TbFeatureHrInfoData copyWith({
    Value<String?> isrtDt = const Value.absent(),
    String? hrLst,
  }) => TbFeatureHrInfoData(
    isrtDt: isrtDt.present ? isrtDt.value : this.isrtDt,
    hrLst: hrLst ?? this.hrLst,
  );
  TbFeatureHrInfoData copyWithCompanion(TbFeatureHrInfoCompanion data) {
    return TbFeatureHrInfoData(
      isrtDt: data.isrtDt.present ? data.isrtDt.value : this.isrtDt,
      hrLst: data.hrLst.present ? data.hrLst.value : this.hrLst,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureHrInfoData(')
          ..write('isrtDt: $isrtDt, ')
          ..write('hrLst: $hrLst')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(isrtDt, hrLst);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbFeatureHrInfoData &&
          other.isrtDt == this.isrtDt &&
          other.hrLst == this.hrLst);
}

class TbFeatureHrInfoCompanion extends UpdateCompanion<TbFeatureHrInfoData> {
  final Value<String?> isrtDt;
  final Value<String> hrLst;
  final Value<int> rowid;
  const TbFeatureHrInfoCompanion({
    this.isrtDt = const Value.absent(),
    this.hrLst = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TbFeatureHrInfoCompanion.insert({
    this.isrtDt = const Value.absent(),
    required String hrLst,
    this.rowid = const Value.absent(),
  }) : hrLst = Value(hrLst);
  static Insertable<TbFeatureHrInfoData> custom({
    Expression<String>? isrtDt,
    Expression<String>? hrLst,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (isrtDt != null) 'isrt_dt': isrtDt,
      if (hrLst != null) 'hr_lst': hrLst,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TbFeatureHrInfoCompanion copyWith({
    Value<String?>? isrtDt,
    Value<String>? hrLst,
    Value<int>? rowid,
  }) {
    return TbFeatureHrInfoCompanion(
      isrtDt: isrtDt ?? this.isrtDt,
      hrLst: hrLst ?? this.hrLst,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (isrtDt.present) {
      map['isrt_dt'] = Variable<String>(isrtDt.value);
    }
    if (hrLst.present) {
      map['hr_lst'] = Variable<String>(hrLst.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureHrInfoCompanion(')
          ..write('isrtDt: $isrtDt, ')
          ..write('hrLst: $hrLst, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class TbFeatureSleepInfo extends Table
    with TableInfo<TbFeatureSleepInfo, TbFeatureSleepInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TbFeatureSleepInfo(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slpSnMeta = const VerificationMeta('slpSn');
  late final GeneratedColumn<int> slpSn = GeneratedColumn<int>(
    'slp_sn',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _baseDateMeta = const VerificationMeta(
    'baseDate',
  );
  late final GeneratedColumn<String> baseDate = GeneratedColumn<String>(
    'base_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  late final GeneratedColumn<String> startAt = GeneratedColumn<String>(
    'start_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  late final GeneratedColumn<String> endAt = GeneratedColumn<String>(
    'end_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: '',
  );
  static const VerificationMeta _totalInbedMMeta = const VerificationMeta(
    'totalInbedM',
  );
  late final GeneratedColumn<int> totalInbedM = GeneratedColumn<int>(
    'total_inbed_m',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _totalSlpMMeta = const VerificationMeta(
    'totalSlpM',
  );
  late final GeneratedColumn<int> totalSlpM = GeneratedColumn<int>(
    'total_slp_m',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _totalAwakeMMeta = const VerificationMeta(
    'totalAwakeM',
  );
  late final GeneratedColumn<int> totalAwakeM = GeneratedColumn<int>(
    'total_awake_m',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _totalLightMMeta = const VerificationMeta(
    'totalLightM',
  );
  late final GeneratedColumn<int> totalLightM = GeneratedColumn<int>(
    'total_light_m',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _totalDeepMMeta = const VerificationMeta(
    'totalDeepM',
  );
  late final GeneratedColumn<int> totalDeepM = GeneratedColumn<int>(
    'total_deep_m',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _totalRemMMeta = const VerificationMeta(
    'totalRemM',
  );
  late final GeneratedColumn<int> totalRemM = GeneratedColumn<int>(
    'total_rem_m',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    slpSn,
    baseDate,
    startAt,
    endAt,
    totalInbedM,
    totalSlpM,
    totalAwakeM,
    totalLightM,
    totalDeepM,
    totalRemM,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_feature_sleep_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<TbFeatureSleepInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slp_sn')) {
      context.handle(
        _slpSnMeta,
        slpSn.isAcceptableOrUnknown(data['slp_sn']!, _slpSnMeta),
      );
    }
    if (data.containsKey('base_date')) {
      context.handle(
        _baseDateMeta,
        baseDate.isAcceptableOrUnknown(data['base_date']!, _baseDateMeta),
      );
    } else if (isInserting) {
      context.missing(_baseDateMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    }
    if (data.containsKey('total_inbed_m')) {
      context.handle(
        _totalInbedMMeta,
        totalInbedM.isAcceptableOrUnknown(
          data['total_inbed_m']!,
          _totalInbedMMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalInbedMMeta);
    }
    if (data.containsKey('total_slp_m')) {
      context.handle(
        _totalSlpMMeta,
        totalSlpM.isAcceptableOrUnknown(data['total_slp_m']!, _totalSlpMMeta),
      );
    } else if (isInserting) {
      context.missing(_totalSlpMMeta);
    }
    if (data.containsKey('total_awake_m')) {
      context.handle(
        _totalAwakeMMeta,
        totalAwakeM.isAcceptableOrUnknown(
          data['total_awake_m']!,
          _totalAwakeMMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAwakeMMeta);
    }
    if (data.containsKey('total_light_m')) {
      context.handle(
        _totalLightMMeta,
        totalLightM.isAcceptableOrUnknown(
          data['total_light_m']!,
          _totalLightMMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalLightMMeta);
    }
    if (data.containsKey('total_deep_m')) {
      context.handle(
        _totalDeepMMeta,
        totalDeepM.isAcceptableOrUnknown(
          data['total_deep_m']!,
          _totalDeepMMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalDeepMMeta);
    }
    if (data.containsKey('total_rem_m')) {
      context.handle(
        _totalRemMMeta,
        totalRemM.isAcceptableOrUnknown(data['total_rem_m']!, _totalRemMMeta),
      );
    } else if (isInserting) {
      context.missing(_totalRemMMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slpSn};
  @override
  TbFeatureSleepInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbFeatureSleepInfoData(
      slpSn: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slp_sn'],
      )!,
      baseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_date'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_at'],
      ),
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_at'],
      ),
      totalInbedM: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_inbed_m'],
      )!,
      totalSlpM: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_slp_m'],
      )!,
      totalAwakeM: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_awake_m'],
      )!,
      totalLightM: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_light_m'],
      )!,
      totalDeepM: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_deep_m'],
      )!,
      totalRemM: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_rem_m'],
      )!,
    );
  }

  @override
  TbFeatureSleepInfo createAlias(String alias) {
    return TbFeatureSleepInfo(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TbFeatureSleepInfoData extends DataClass
    implements Insertable<TbFeatureSleepInfoData> {
  final int slpSn;
  final String baseDate;

  /// 'YYYY-MM-DD' (기상일 기준 추천)
  final String? startAt;

  /// 수면 시작(ISO)
  final String? endAt;

  /// 수면 종료(ISO)
  final int totalInbedM;
  final int totalSlpM;
  final int totalAwakeM;
  final int totalLightM;
  final int totalDeepM;
  final int totalRemM;
  const TbFeatureSleepInfoData({
    required this.slpSn,
    required this.baseDate,
    this.startAt,
    this.endAt,
    required this.totalInbedM,
    required this.totalSlpM,
    required this.totalAwakeM,
    required this.totalLightM,
    required this.totalDeepM,
    required this.totalRemM,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slp_sn'] = Variable<int>(slpSn);
    map['base_date'] = Variable<String>(baseDate);
    if (!nullToAbsent || startAt != null) {
      map['start_at'] = Variable<String>(startAt);
    }
    if (!nullToAbsent || endAt != null) {
      map['end_at'] = Variable<String>(endAt);
    }
    map['total_inbed_m'] = Variable<int>(totalInbedM);
    map['total_slp_m'] = Variable<int>(totalSlpM);
    map['total_awake_m'] = Variable<int>(totalAwakeM);
    map['total_light_m'] = Variable<int>(totalLightM);
    map['total_deep_m'] = Variable<int>(totalDeepM);
    map['total_rem_m'] = Variable<int>(totalRemM);
    return map;
  }

  TbFeatureSleepInfoCompanion toCompanion(bool nullToAbsent) {
    return TbFeatureSleepInfoCompanion(
      slpSn: Value(slpSn),
      baseDate: Value(baseDate),
      startAt: startAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startAt),
      endAt: endAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endAt),
      totalInbedM: Value(totalInbedM),
      totalSlpM: Value(totalSlpM),
      totalAwakeM: Value(totalAwakeM),
      totalLightM: Value(totalLightM),
      totalDeepM: Value(totalDeepM),
      totalRemM: Value(totalRemM),
    );
  }

  factory TbFeatureSleepInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbFeatureSleepInfoData(
      slpSn: serializer.fromJson<int>(json['slp_sn']),
      baseDate: serializer.fromJson<String>(json['base_date']),
      startAt: serializer.fromJson<String?>(json['start_at']),
      endAt: serializer.fromJson<String?>(json['end_at']),
      totalInbedM: serializer.fromJson<int>(json['total_inbed_m']),
      totalSlpM: serializer.fromJson<int>(json['total_slp_m']),
      totalAwakeM: serializer.fromJson<int>(json['total_awake_m']),
      totalLightM: serializer.fromJson<int>(json['total_light_m']),
      totalDeepM: serializer.fromJson<int>(json['total_deep_m']),
      totalRemM: serializer.fromJson<int>(json['total_rem_m']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slp_sn': serializer.toJson<int>(slpSn),
      'base_date': serializer.toJson<String>(baseDate),
      'start_at': serializer.toJson<String?>(startAt),
      'end_at': serializer.toJson<String?>(endAt),
      'total_inbed_m': serializer.toJson<int>(totalInbedM),
      'total_slp_m': serializer.toJson<int>(totalSlpM),
      'total_awake_m': serializer.toJson<int>(totalAwakeM),
      'total_light_m': serializer.toJson<int>(totalLightM),
      'total_deep_m': serializer.toJson<int>(totalDeepM),
      'total_rem_m': serializer.toJson<int>(totalRemM),
    };
  }

  TbFeatureSleepInfoData copyWith({
    int? slpSn,
    String? baseDate,
    Value<String?> startAt = const Value.absent(),
    Value<String?> endAt = const Value.absent(),
    int? totalInbedM,
    int? totalSlpM,
    int? totalAwakeM,
    int? totalLightM,
    int? totalDeepM,
    int? totalRemM,
  }) => TbFeatureSleepInfoData(
    slpSn: slpSn ?? this.slpSn,
    baseDate: baseDate ?? this.baseDate,
    startAt: startAt.present ? startAt.value : this.startAt,
    endAt: endAt.present ? endAt.value : this.endAt,
    totalInbedM: totalInbedM ?? this.totalInbedM,
    totalSlpM: totalSlpM ?? this.totalSlpM,
    totalAwakeM: totalAwakeM ?? this.totalAwakeM,
    totalLightM: totalLightM ?? this.totalLightM,
    totalDeepM: totalDeepM ?? this.totalDeepM,
    totalRemM: totalRemM ?? this.totalRemM,
  );
  TbFeatureSleepInfoData copyWithCompanion(TbFeatureSleepInfoCompanion data) {
    return TbFeatureSleepInfoData(
      slpSn: data.slpSn.present ? data.slpSn.value : this.slpSn,
      baseDate: data.baseDate.present ? data.baseDate.value : this.baseDate,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      totalInbedM: data.totalInbedM.present
          ? data.totalInbedM.value
          : this.totalInbedM,
      totalSlpM: data.totalSlpM.present ? data.totalSlpM.value : this.totalSlpM,
      totalAwakeM: data.totalAwakeM.present
          ? data.totalAwakeM.value
          : this.totalAwakeM,
      totalLightM: data.totalLightM.present
          ? data.totalLightM.value
          : this.totalLightM,
      totalDeepM: data.totalDeepM.present
          ? data.totalDeepM.value
          : this.totalDeepM,
      totalRemM: data.totalRemM.present ? data.totalRemM.value : this.totalRemM,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureSleepInfoData(')
          ..write('slpSn: $slpSn, ')
          ..write('baseDate: $baseDate, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('totalInbedM: $totalInbedM, ')
          ..write('totalSlpM: $totalSlpM, ')
          ..write('totalAwakeM: $totalAwakeM, ')
          ..write('totalLightM: $totalLightM, ')
          ..write('totalDeepM: $totalDeepM, ')
          ..write('totalRemM: $totalRemM')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    slpSn,
    baseDate,
    startAt,
    endAt,
    totalInbedM,
    totalSlpM,
    totalAwakeM,
    totalLightM,
    totalDeepM,
    totalRemM,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbFeatureSleepInfoData &&
          other.slpSn == this.slpSn &&
          other.baseDate == this.baseDate &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.totalInbedM == this.totalInbedM &&
          other.totalSlpM == this.totalSlpM &&
          other.totalAwakeM == this.totalAwakeM &&
          other.totalLightM == this.totalLightM &&
          other.totalDeepM == this.totalDeepM &&
          other.totalRemM == this.totalRemM);
}

class TbFeatureSleepInfoCompanion
    extends UpdateCompanion<TbFeatureSleepInfoData> {
  final Value<int> slpSn;
  final Value<String> baseDate;
  final Value<String?> startAt;
  final Value<String?> endAt;
  final Value<int> totalInbedM;
  final Value<int> totalSlpM;
  final Value<int> totalAwakeM;
  final Value<int> totalLightM;
  final Value<int> totalDeepM;
  final Value<int> totalRemM;
  const TbFeatureSleepInfoCompanion({
    this.slpSn = const Value.absent(),
    this.baseDate = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.totalInbedM = const Value.absent(),
    this.totalSlpM = const Value.absent(),
    this.totalAwakeM = const Value.absent(),
    this.totalLightM = const Value.absent(),
    this.totalDeepM = const Value.absent(),
    this.totalRemM = const Value.absent(),
  });
  TbFeatureSleepInfoCompanion.insert({
    this.slpSn = const Value.absent(),
    required String baseDate,
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    required int totalInbedM,
    required int totalSlpM,
    required int totalAwakeM,
    required int totalLightM,
    required int totalDeepM,
    required int totalRemM,
  }) : baseDate = Value(baseDate),
       totalInbedM = Value(totalInbedM),
       totalSlpM = Value(totalSlpM),
       totalAwakeM = Value(totalAwakeM),
       totalLightM = Value(totalLightM),
       totalDeepM = Value(totalDeepM),
       totalRemM = Value(totalRemM);
  static Insertable<TbFeatureSleepInfoData> custom({
    Expression<int>? slpSn,
    Expression<String>? baseDate,
    Expression<String>? startAt,
    Expression<String>? endAt,
    Expression<int>? totalInbedM,
    Expression<int>? totalSlpM,
    Expression<int>? totalAwakeM,
    Expression<int>? totalLightM,
    Expression<int>? totalDeepM,
    Expression<int>? totalRemM,
  }) {
    return RawValuesInsertable({
      if (slpSn != null) 'slp_sn': slpSn,
      if (baseDate != null) 'base_date': baseDate,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (totalInbedM != null) 'total_inbed_m': totalInbedM,
      if (totalSlpM != null) 'total_slp_m': totalSlpM,
      if (totalAwakeM != null) 'total_awake_m': totalAwakeM,
      if (totalLightM != null) 'total_light_m': totalLightM,
      if (totalDeepM != null) 'total_deep_m': totalDeepM,
      if (totalRemM != null) 'total_rem_m': totalRemM,
    });
  }

  TbFeatureSleepInfoCompanion copyWith({
    Value<int>? slpSn,
    Value<String>? baseDate,
    Value<String?>? startAt,
    Value<String?>? endAt,
    Value<int>? totalInbedM,
    Value<int>? totalSlpM,
    Value<int>? totalAwakeM,
    Value<int>? totalLightM,
    Value<int>? totalDeepM,
    Value<int>? totalRemM,
  }) {
    return TbFeatureSleepInfoCompanion(
      slpSn: slpSn ?? this.slpSn,
      baseDate: baseDate ?? this.baseDate,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      totalInbedM: totalInbedM ?? this.totalInbedM,
      totalSlpM: totalSlpM ?? this.totalSlpM,
      totalAwakeM: totalAwakeM ?? this.totalAwakeM,
      totalLightM: totalLightM ?? this.totalLightM,
      totalDeepM: totalDeepM ?? this.totalDeepM,
      totalRemM: totalRemM ?? this.totalRemM,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slpSn.present) {
      map['slp_sn'] = Variable<int>(slpSn.value);
    }
    if (baseDate.present) {
      map['base_date'] = Variable<String>(baseDate.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<String>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<String>(endAt.value);
    }
    if (totalInbedM.present) {
      map['total_inbed_m'] = Variable<int>(totalInbedM.value);
    }
    if (totalSlpM.present) {
      map['total_slp_m'] = Variable<int>(totalSlpM.value);
    }
    if (totalAwakeM.present) {
      map['total_awake_m'] = Variable<int>(totalAwakeM.value);
    }
    if (totalLightM.present) {
      map['total_light_m'] = Variable<int>(totalLightM.value);
    }
    if (totalDeepM.present) {
      map['total_deep_m'] = Variable<int>(totalDeepM.value);
    }
    if (totalRemM.present) {
      map['total_rem_m'] = Variable<int>(totalRemM.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureSleepInfoCompanion(')
          ..write('slpSn: $slpSn, ')
          ..write('baseDate: $baseDate, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('totalInbedM: $totalInbedM, ')
          ..write('totalSlpM: $totalSlpM, ')
          ..write('totalAwakeM: $totalAwakeM, ')
          ..write('totalLightM: $totalLightM, ')
          ..write('totalDeepM: $totalDeepM, ')
          ..write('totalRemM: $totalRemM')
          ..write(')'))
        .toString();
  }
}

class TbFeatureSleepDetail extends Table
    with TableInfo<TbFeatureSleepDetail, TbFeatureSleepDetailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TbFeatureSleepDetail(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slpDetailSnMeta = const VerificationMeta(
    'slpDetailSn',
  );
  late final GeneratedColumn<int> slpDetailSn = GeneratedColumn<int>(
    'slp_detail_sn',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _slpSnMeta = const VerificationMeta('slpSn');
  late final GeneratedColumn<int> slpSn = GeneratedColumn<int>(
    'slp_sn',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  late final GeneratedColumn<String> stage = GeneratedColumn<String>(
    'stage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  late final GeneratedColumn<String> startAt = GeneratedColumn<String>(
    'start_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _endAtMeta = const VerificationMeta('endAt');
  late final GeneratedColumn<String> endAt = GeneratedColumn<String>(
    'end_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _durationMMeta = const VerificationMeta(
    'durationM',
  );
  late final GeneratedColumn<int> durationM = GeneratedColumn<int>(
    'duration_m',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    slpDetailSn,
    slpSn,
    stage,
    startAt,
    endAt,
    durationM,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_feature_sleep_detail';
  @override
  VerificationContext validateIntegrity(
    Insertable<TbFeatureSleepDetailData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slp_detail_sn')) {
      context.handle(
        _slpDetailSnMeta,
        slpDetailSn.isAcceptableOrUnknown(
          data['slp_detail_sn']!,
          _slpDetailSnMeta,
        ),
      );
    }
    if (data.containsKey('slp_sn')) {
      context.handle(
        _slpSnMeta,
        slpSn.isAcceptableOrUnknown(data['slp_sn']!, _slpSnMeta),
      );
    } else if (isInserting) {
      context.missing(_slpSnMeta);
    }
    if (data.containsKey('stage')) {
      context.handle(
        _stageMeta,
        stage.isAcceptableOrUnknown(data['stage']!, _stageMeta),
      );
    } else if (isInserting) {
      context.missing(_stageMeta);
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startAtMeta);
    }
    if (data.containsKey('end_at')) {
      context.handle(
        _endAtMeta,
        endAt.isAcceptableOrUnknown(data['end_at']!, _endAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endAtMeta);
    }
    if (data.containsKey('duration_m')) {
      context.handle(
        _durationMMeta,
        durationM.isAcceptableOrUnknown(data['duration_m']!, _durationMMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slpDetailSn};
  @override
  TbFeatureSleepDetailData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbFeatureSleepDetailData(
      slpDetailSn: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slp_detail_sn'],
      )!,
      slpSn: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slp_sn'],
      )!,
      stage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stage'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_at'],
      )!,
      endAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_at'],
      )!,
      durationM: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_m'],
      )!,
    );
  }

  @override
  TbFeatureSleepDetail createAlias(String alias) {
    return TbFeatureSleepDetail(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'FOREIGN KEY(slp_sn)REFERENCES tb_feature_sleep_info(slp_sn)ON DELETE CASCADE',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class TbFeatureSleepDetailData extends DataClass
    implements Insertable<TbFeatureSleepDetailData> {
  final int slpDetailSn;
  final int slpSn;
  final String stage;

  /// 'AWAKE','LIGHT','DEEP','REM'
  final String startAt;

  /// 구간 시작(ISO)
  final String endAt;

  /// 구간 끝(ISO)
  final int durationM;
  const TbFeatureSleepDetailData({
    required this.slpDetailSn,
    required this.slpSn,
    required this.stage,
    required this.startAt,
    required this.endAt,
    required this.durationM,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slp_detail_sn'] = Variable<int>(slpDetailSn);
    map['slp_sn'] = Variable<int>(slpSn);
    map['stage'] = Variable<String>(stage);
    map['start_at'] = Variable<String>(startAt);
    map['end_at'] = Variable<String>(endAt);
    map['duration_m'] = Variable<int>(durationM);
    return map;
  }

  TbFeatureSleepDetailCompanion toCompanion(bool nullToAbsent) {
    return TbFeatureSleepDetailCompanion(
      slpDetailSn: Value(slpDetailSn),
      slpSn: Value(slpSn),
      stage: Value(stage),
      startAt: Value(startAt),
      endAt: Value(endAt),
      durationM: Value(durationM),
    );
  }

  factory TbFeatureSleepDetailData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbFeatureSleepDetailData(
      slpDetailSn: serializer.fromJson<int>(json['slp_detail_sn']),
      slpSn: serializer.fromJson<int>(json['slp_sn']),
      stage: serializer.fromJson<String>(json['stage']),
      startAt: serializer.fromJson<String>(json['start_at']),
      endAt: serializer.fromJson<String>(json['end_at']),
      durationM: serializer.fromJson<int>(json['duration_m']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slp_detail_sn': serializer.toJson<int>(slpDetailSn),
      'slp_sn': serializer.toJson<int>(slpSn),
      'stage': serializer.toJson<String>(stage),
      'start_at': serializer.toJson<String>(startAt),
      'end_at': serializer.toJson<String>(endAt),
      'duration_m': serializer.toJson<int>(durationM),
    };
  }

  TbFeatureSleepDetailData copyWith({
    int? slpDetailSn,
    int? slpSn,
    String? stage,
    String? startAt,
    String? endAt,
    int? durationM,
  }) => TbFeatureSleepDetailData(
    slpDetailSn: slpDetailSn ?? this.slpDetailSn,
    slpSn: slpSn ?? this.slpSn,
    stage: stage ?? this.stage,
    startAt: startAt ?? this.startAt,
    endAt: endAt ?? this.endAt,
    durationM: durationM ?? this.durationM,
  );
  TbFeatureSleepDetailData copyWithCompanion(
    TbFeatureSleepDetailCompanion data,
  ) {
    return TbFeatureSleepDetailData(
      slpDetailSn: data.slpDetailSn.present
          ? data.slpDetailSn.value
          : this.slpDetailSn,
      slpSn: data.slpSn.present ? data.slpSn.value : this.slpSn,
      stage: data.stage.present ? data.stage.value : this.stage,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      endAt: data.endAt.present ? data.endAt.value : this.endAt,
      durationM: data.durationM.present ? data.durationM.value : this.durationM,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureSleepDetailData(')
          ..write('slpDetailSn: $slpDetailSn, ')
          ..write('slpSn: $slpSn, ')
          ..write('stage: $stage, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('durationM: $durationM')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(slpDetailSn, slpSn, stage, startAt, endAt, durationM);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbFeatureSleepDetailData &&
          other.slpDetailSn == this.slpDetailSn &&
          other.slpSn == this.slpSn &&
          other.stage == this.stage &&
          other.startAt == this.startAt &&
          other.endAt == this.endAt &&
          other.durationM == this.durationM);
}

class TbFeatureSleepDetailCompanion
    extends UpdateCompanion<TbFeatureSleepDetailData> {
  final Value<int> slpDetailSn;
  final Value<int> slpSn;
  final Value<String> stage;
  final Value<String> startAt;
  final Value<String> endAt;
  final Value<int> durationM;
  const TbFeatureSleepDetailCompanion({
    this.slpDetailSn = const Value.absent(),
    this.slpSn = const Value.absent(),
    this.stage = const Value.absent(),
    this.startAt = const Value.absent(),
    this.endAt = const Value.absent(),
    this.durationM = const Value.absent(),
  });
  TbFeatureSleepDetailCompanion.insert({
    this.slpDetailSn = const Value.absent(),
    required int slpSn,
    required String stage,
    required String startAt,
    required String endAt,
    required int durationM,
  }) : slpSn = Value(slpSn),
       stage = Value(stage),
       startAt = Value(startAt),
       endAt = Value(endAt),
       durationM = Value(durationM);
  static Insertable<TbFeatureSleepDetailData> custom({
    Expression<int>? slpDetailSn,
    Expression<int>? slpSn,
    Expression<String>? stage,
    Expression<String>? startAt,
    Expression<String>? endAt,
    Expression<int>? durationM,
  }) {
    return RawValuesInsertable({
      if (slpDetailSn != null) 'slp_detail_sn': slpDetailSn,
      if (slpSn != null) 'slp_sn': slpSn,
      if (stage != null) 'stage': stage,
      if (startAt != null) 'start_at': startAt,
      if (endAt != null) 'end_at': endAt,
      if (durationM != null) 'duration_m': durationM,
    });
  }

  TbFeatureSleepDetailCompanion copyWith({
    Value<int>? slpDetailSn,
    Value<int>? slpSn,
    Value<String>? stage,
    Value<String>? startAt,
    Value<String>? endAt,
    Value<int>? durationM,
  }) {
    return TbFeatureSleepDetailCompanion(
      slpDetailSn: slpDetailSn ?? this.slpDetailSn,
      slpSn: slpSn ?? this.slpSn,
      stage: stage ?? this.stage,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
      durationM: durationM ?? this.durationM,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slpDetailSn.present) {
      map['slp_detail_sn'] = Variable<int>(slpDetailSn.value);
    }
    if (slpSn.present) {
      map['slp_sn'] = Variable<int>(slpSn.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(stage.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<String>(startAt.value);
    }
    if (endAt.present) {
      map['end_at'] = Variable<String>(endAt.value);
    }
    if (durationM.present) {
      map['duration_m'] = Variable<int>(durationM.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureSleepDetailCompanion(')
          ..write('slpDetailSn: $slpDetailSn, ')
          ..write('slpSn: $slpSn, ')
          ..write('stage: $stage, ')
          ..write('startAt: $startAt, ')
          ..write('endAt: $endAt, ')
          ..write('durationM: $durationM')
          ..write(')'))
        .toString();
  }
}

class TbFeatureExerciseInfo extends Table
    with TableInfo<TbFeatureExerciseInfo, TbFeatureExerciseInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TbFeatureExerciseInfo(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exSnMeta = const VerificationMeta('exSn');
  late final GeneratedColumn<int> exSn = GeneratedColumn<int>(
    'ex_sn',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'PRIMARY KEY AUTOINCREMENT',
  );
  static const VerificationMeta _baseDateMeta = const VerificationMeta(
    'baseDate',
  );
  late final GeneratedColumn<String> baseDate = GeneratedColumn<String>(
    'base_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _metricKindMeta = const VerificationMeta(
    'metricKind',
  );
  late final GeneratedColumn<String> metricKind = GeneratedColumn<String>(
    'metric_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _metricValMeta = const VerificationMeta(
    'metricVal',
  );
  late final GeneratedColumn<double> metricVal = GeneratedColumn<double>(
    'metric_val',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _distanceMeta = const VerificationMeta(
    'distance',
  );
  late final GeneratedColumn<double> distance = GeneratedColumn<double>(
    'distance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _calorieMeta = const VerificationMeta(
    'calorie',
  );
  late final GeneratedColumn<double> calorie = GeneratedColumn<double>(
    'calorie',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _startHhmmMeta = const VerificationMeta(
    'startHhmm',
  );
  late final GeneratedColumn<String> startHhmm = GeneratedColumn<String>(
    'start_hhmm',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _endHhmmMeta = const VerificationMeta(
    'endHhmm',
  );
  late final GeneratedColumn<String> endHhmm = GeneratedColumn<String>(
    'end_hhmm',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [
    exSn,
    baseDate,
    type,
    metricKind,
    metricVal,
    distance,
    calorie,
    startHhmm,
    endHhmm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_feature_exercise_info';
  @override
  VerificationContext validateIntegrity(
    Insertable<TbFeatureExerciseInfoData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ex_sn')) {
      context.handle(
        _exSnMeta,
        exSn.isAcceptableOrUnknown(data['ex_sn']!, _exSnMeta),
      );
    }
    if (data.containsKey('base_date')) {
      context.handle(
        _baseDateMeta,
        baseDate.isAcceptableOrUnknown(data['base_date']!, _baseDateMeta),
      );
    } else if (isInserting) {
      context.missing(_baseDateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('metric_kind')) {
      context.handle(
        _metricKindMeta,
        metricKind.isAcceptableOrUnknown(data['metric_kind']!, _metricKindMeta),
      );
    } else if (isInserting) {
      context.missing(_metricKindMeta);
    }
    if (data.containsKey('metric_val')) {
      context.handle(
        _metricValMeta,
        metricVal.isAcceptableOrUnknown(data['metric_val']!, _metricValMeta),
      );
    } else if (isInserting) {
      context.missing(_metricValMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(
        _distanceMeta,
        distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta),
      );
    } else if (isInserting) {
      context.missing(_distanceMeta);
    }
    if (data.containsKey('calorie')) {
      context.handle(
        _calorieMeta,
        calorie.isAcceptableOrUnknown(data['calorie']!, _calorieMeta),
      );
    } else if (isInserting) {
      context.missing(_calorieMeta);
    }
    if (data.containsKey('start_hhmm')) {
      context.handle(
        _startHhmmMeta,
        startHhmm.isAcceptableOrUnknown(data['start_hhmm']!, _startHhmmMeta),
      );
    } else if (isInserting) {
      context.missing(_startHhmmMeta);
    }
    if (data.containsKey('end_hhmm')) {
      context.handle(
        _endHhmmMeta,
        endHhmm.isAcceptableOrUnknown(data['end_hhmm']!, _endHhmmMeta),
      );
    } else if (isInserting) {
      context.missing(_endHhmmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {exSn};
  @override
  TbFeatureExerciseInfoData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbFeatureExerciseInfoData(
      exSn: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ex_sn'],
      )!,
      baseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_date'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
      metricKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metric_kind'],
      )!,
      metricVal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}metric_val'],
      )!,
      distance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance'],
      )!,
      calorie: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calorie'],
      )!,
      startHhmm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_hhmm'],
      )!,
      endHhmm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_hhmm'],
      )!,
    );
  }

  @override
  TbFeatureExerciseInfo createAlias(String alias) {
    return TbFeatureExerciseInfo(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class TbFeatureExerciseInfoData extends DataClass
    implements Insertable<TbFeatureExerciseInfoData> {
  final int exSn;
  final String baseDate;

  /// 'YYYYMMDD' 예: 20260201
  final int type;

  /// 'run', 'walk', 'swim', 'paddle' 등
  final String metricKind;

  /// 'step' | 'stroke' | 'paddle'
  final double metricVal;

  /// 걸음수/스트로크/패들 횟수 등(공용 변수)
  final double distance;
  final double calorie;
  final String startHhmm;

  /// 'HHmm'
  final String endHhmm;
  const TbFeatureExerciseInfoData({
    required this.exSn,
    required this.baseDate,
    required this.type,
    required this.metricKind,
    required this.metricVal,
    required this.distance,
    required this.calorie,
    required this.startHhmm,
    required this.endHhmm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ex_sn'] = Variable<int>(exSn);
    map['base_date'] = Variable<String>(baseDate);
    map['type'] = Variable<int>(type);
    map['metric_kind'] = Variable<String>(metricKind);
    map['metric_val'] = Variable<double>(metricVal);
    map['distance'] = Variable<double>(distance);
    map['calorie'] = Variable<double>(calorie);
    map['start_hhmm'] = Variable<String>(startHhmm);
    map['end_hhmm'] = Variable<String>(endHhmm);
    return map;
  }

  TbFeatureExerciseInfoCompanion toCompanion(bool nullToAbsent) {
    return TbFeatureExerciseInfoCompanion(
      exSn: Value(exSn),
      baseDate: Value(baseDate),
      type: Value(type),
      metricKind: Value(metricKind),
      metricVal: Value(metricVal),
      distance: Value(distance),
      calorie: Value(calorie),
      startHhmm: Value(startHhmm),
      endHhmm: Value(endHhmm),
    );
  }

  factory TbFeatureExerciseInfoData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbFeatureExerciseInfoData(
      exSn: serializer.fromJson<int>(json['ex_sn']),
      baseDate: serializer.fromJson<String>(json['base_date']),
      type: serializer.fromJson<int>(json['type']),
      metricKind: serializer.fromJson<String>(json['metric_kind']),
      metricVal: serializer.fromJson<double>(json['metric_val']),
      distance: serializer.fromJson<double>(json['distance']),
      calorie: serializer.fromJson<double>(json['calorie']),
      startHhmm: serializer.fromJson<String>(json['start_hhmm']),
      endHhmm: serializer.fromJson<String>(json['end_hhmm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ex_sn': serializer.toJson<int>(exSn),
      'base_date': serializer.toJson<String>(baseDate),
      'type': serializer.toJson<int>(type),
      'metric_kind': serializer.toJson<String>(metricKind),
      'metric_val': serializer.toJson<double>(metricVal),
      'distance': serializer.toJson<double>(distance),
      'calorie': serializer.toJson<double>(calorie),
      'start_hhmm': serializer.toJson<String>(startHhmm),
      'end_hhmm': serializer.toJson<String>(endHhmm),
    };
  }

  TbFeatureExerciseInfoData copyWith({
    int? exSn,
    String? baseDate,
    int? type,
    String? metricKind,
    double? metricVal,
    double? distance,
    double? calorie,
    String? startHhmm,
    String? endHhmm,
  }) => TbFeatureExerciseInfoData(
    exSn: exSn ?? this.exSn,
    baseDate: baseDate ?? this.baseDate,
    type: type ?? this.type,
    metricKind: metricKind ?? this.metricKind,
    metricVal: metricVal ?? this.metricVal,
    distance: distance ?? this.distance,
    calorie: calorie ?? this.calorie,
    startHhmm: startHhmm ?? this.startHhmm,
    endHhmm: endHhmm ?? this.endHhmm,
  );
  TbFeatureExerciseInfoData copyWithCompanion(
    TbFeatureExerciseInfoCompanion data,
  ) {
    return TbFeatureExerciseInfoData(
      exSn: data.exSn.present ? data.exSn.value : this.exSn,
      baseDate: data.baseDate.present ? data.baseDate.value : this.baseDate,
      type: data.type.present ? data.type.value : this.type,
      metricKind: data.metricKind.present
          ? data.metricKind.value
          : this.metricKind,
      metricVal: data.metricVal.present ? data.metricVal.value : this.metricVal,
      distance: data.distance.present ? data.distance.value : this.distance,
      calorie: data.calorie.present ? data.calorie.value : this.calorie,
      startHhmm: data.startHhmm.present ? data.startHhmm.value : this.startHhmm,
      endHhmm: data.endHhmm.present ? data.endHhmm.value : this.endHhmm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureExerciseInfoData(')
          ..write('exSn: $exSn, ')
          ..write('baseDate: $baseDate, ')
          ..write('type: $type, ')
          ..write('metricKind: $metricKind, ')
          ..write('metricVal: $metricVal, ')
          ..write('distance: $distance, ')
          ..write('calorie: $calorie, ')
          ..write('startHhmm: $startHhmm, ')
          ..write('endHhmm: $endHhmm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    exSn,
    baseDate,
    type,
    metricKind,
    metricVal,
    distance,
    calorie,
    startHhmm,
    endHhmm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbFeatureExerciseInfoData &&
          other.exSn == this.exSn &&
          other.baseDate == this.baseDate &&
          other.type == this.type &&
          other.metricKind == this.metricKind &&
          other.metricVal == this.metricVal &&
          other.distance == this.distance &&
          other.calorie == this.calorie &&
          other.startHhmm == this.startHhmm &&
          other.endHhmm == this.endHhmm);
}

class TbFeatureExerciseInfoCompanion
    extends UpdateCompanion<TbFeatureExerciseInfoData> {
  final Value<int> exSn;
  final Value<String> baseDate;
  final Value<int> type;
  final Value<String> metricKind;
  final Value<double> metricVal;
  final Value<double> distance;
  final Value<double> calorie;
  final Value<String> startHhmm;
  final Value<String> endHhmm;
  const TbFeatureExerciseInfoCompanion({
    this.exSn = const Value.absent(),
    this.baseDate = const Value.absent(),
    this.type = const Value.absent(),
    this.metricKind = const Value.absent(),
    this.metricVal = const Value.absent(),
    this.distance = const Value.absent(),
    this.calorie = const Value.absent(),
    this.startHhmm = const Value.absent(),
    this.endHhmm = const Value.absent(),
  });
  TbFeatureExerciseInfoCompanion.insert({
    this.exSn = const Value.absent(),
    required String baseDate,
    required int type,
    required String metricKind,
    required double metricVal,
    required double distance,
    required double calorie,
    required String startHhmm,
    required String endHhmm,
  }) : baseDate = Value(baseDate),
       type = Value(type),
       metricKind = Value(metricKind),
       metricVal = Value(metricVal),
       distance = Value(distance),
       calorie = Value(calorie),
       startHhmm = Value(startHhmm),
       endHhmm = Value(endHhmm);
  static Insertable<TbFeatureExerciseInfoData> custom({
    Expression<int>? exSn,
    Expression<String>? baseDate,
    Expression<int>? type,
    Expression<String>? metricKind,
    Expression<double>? metricVal,
    Expression<double>? distance,
    Expression<double>? calorie,
    Expression<String>? startHhmm,
    Expression<String>? endHhmm,
  }) {
    return RawValuesInsertable({
      if (exSn != null) 'ex_sn': exSn,
      if (baseDate != null) 'base_date': baseDate,
      if (type != null) 'type': type,
      if (metricKind != null) 'metric_kind': metricKind,
      if (metricVal != null) 'metric_val': metricVal,
      if (distance != null) 'distance': distance,
      if (calorie != null) 'calorie': calorie,
      if (startHhmm != null) 'start_hhmm': startHhmm,
      if (endHhmm != null) 'end_hhmm': endHhmm,
    });
  }

  TbFeatureExerciseInfoCompanion copyWith({
    Value<int>? exSn,
    Value<String>? baseDate,
    Value<int>? type,
    Value<String>? metricKind,
    Value<double>? metricVal,
    Value<double>? distance,
    Value<double>? calorie,
    Value<String>? startHhmm,
    Value<String>? endHhmm,
  }) {
    return TbFeatureExerciseInfoCompanion(
      exSn: exSn ?? this.exSn,
      baseDate: baseDate ?? this.baseDate,
      type: type ?? this.type,
      metricKind: metricKind ?? this.metricKind,
      metricVal: metricVal ?? this.metricVal,
      distance: distance ?? this.distance,
      calorie: calorie ?? this.calorie,
      startHhmm: startHhmm ?? this.startHhmm,
      endHhmm: endHhmm ?? this.endHhmm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exSn.present) {
      map['ex_sn'] = Variable<int>(exSn.value);
    }
    if (baseDate.present) {
      map['base_date'] = Variable<String>(baseDate.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (metricKind.present) {
      map['metric_kind'] = Variable<String>(metricKind.value);
    }
    if (metricVal.present) {
      map['metric_val'] = Variable<double>(metricVal.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double>(distance.value);
    }
    if (calorie.present) {
      map['calorie'] = Variable<double>(calorie.value);
    }
    if (startHhmm.present) {
      map['start_hhmm'] = Variable<String>(startHhmm.value);
    }
    if (endHhmm.present) {
      map['end_hhmm'] = Variable<String>(endHhmm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureExerciseInfoCompanion(')
          ..write('exSn: $exSn, ')
          ..write('baseDate: $baseDate, ')
          ..write('type: $type, ')
          ..write('metricKind: $metricKind, ')
          ..write('metricVal: $metricVal, ')
          ..write('distance: $distance, ')
          ..write('calorie: $calorie, ')
          ..write('startHhmm: $startHhmm, ')
          ..write('endHhmm: $endHhmm')
          ..write(')'))
        .toString();
  }
}

class TbFeatureExerciseHr extends Table
    with TableInfo<TbFeatureExerciseHr, TbFeatureExerciseHrData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  TbFeatureExerciseHr(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _exSnMeta = const VerificationMeta('exSn');
  late final GeneratedColumn<int> exSn = GeneratedColumn<int>(
    'ex_sn',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL PRIMARY KEY',
  );
  static const VerificationMeta _hrLstMeta = const VerificationMeta('hrLst');
  late final GeneratedColumn<String> hrLst = GeneratedColumn<String>(
    'hr_lst',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  static const VerificationMeta _stepSecMeta = const VerificationMeta(
    'stepSec',
  );
  late final GeneratedColumn<int> stepSec = GeneratedColumn<int>(
    'step_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [exSn, hrLst, stepSec];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tb_feature_exercise_hr';
  @override
  VerificationContext validateIntegrity(
    Insertable<TbFeatureExerciseHrData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ex_sn')) {
      context.handle(
        _exSnMeta,
        exSn.isAcceptableOrUnknown(data['ex_sn']!, _exSnMeta),
      );
    }
    if (data.containsKey('hr_lst')) {
      context.handle(
        _hrLstMeta,
        hrLst.isAcceptableOrUnknown(data['hr_lst']!, _hrLstMeta),
      );
    } else if (isInserting) {
      context.missing(_hrLstMeta);
    }
    if (data.containsKey('step_sec')) {
      context.handle(
        _stepSecMeta,
        stepSec.isAcceptableOrUnknown(data['step_sec']!, _stepSecMeta),
      );
    } else if (isInserting) {
      context.missing(_stepSecMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {exSn};
  @override
  TbFeatureExerciseHrData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbFeatureExerciseHrData(
      exSn: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ex_sn'],
      )!,
      hrLst: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hr_lst'],
      )!,
      stepSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_sec'],
      )!,
    );
  }

  @override
  TbFeatureExerciseHr createAlias(String alias) {
    return TbFeatureExerciseHr(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const [
    'FOREIGN KEY(ex_sn)REFERENCES tb_feature_exercise_info(ex_sn)ON DELETE CASCADE',
  ];
  @override
  bool get dontWriteConstraints => true;
}

class TbFeatureExerciseHrData extends DataClass
    implements Insertable<TbFeatureExerciseHrData> {
  final int exSn;
  final String hrLst;

  /// CSV: "90,91,100,120"
  final int stepSec;
  const TbFeatureExerciseHrData({
    required this.exSn,
    required this.hrLst,
    required this.stepSec,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ex_sn'] = Variable<int>(exSn);
    map['hr_lst'] = Variable<String>(hrLst);
    map['step_sec'] = Variable<int>(stepSec);
    return map;
  }

  TbFeatureExerciseHrCompanion toCompanion(bool nullToAbsent) {
    return TbFeatureExerciseHrCompanion(
      exSn: Value(exSn),
      hrLst: Value(hrLst),
      stepSec: Value(stepSec),
    );
  }

  factory TbFeatureExerciseHrData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbFeatureExerciseHrData(
      exSn: serializer.fromJson<int>(json['ex_sn']),
      hrLst: serializer.fromJson<String>(json['hr_lst']),
      stepSec: serializer.fromJson<int>(json['step_sec']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ex_sn': serializer.toJson<int>(exSn),
      'hr_lst': serializer.toJson<String>(hrLst),
      'step_sec': serializer.toJson<int>(stepSec),
    };
  }

  TbFeatureExerciseHrData copyWith({int? exSn, String? hrLst, int? stepSec}) =>
      TbFeatureExerciseHrData(
        exSn: exSn ?? this.exSn,
        hrLst: hrLst ?? this.hrLst,
        stepSec: stepSec ?? this.stepSec,
      );
  TbFeatureExerciseHrData copyWithCompanion(TbFeatureExerciseHrCompanion data) {
    return TbFeatureExerciseHrData(
      exSn: data.exSn.present ? data.exSn.value : this.exSn,
      hrLst: data.hrLst.present ? data.hrLst.value : this.hrLst,
      stepSec: data.stepSec.present ? data.stepSec.value : this.stepSec,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureExerciseHrData(')
          ..write('exSn: $exSn, ')
          ..write('hrLst: $hrLst, ')
          ..write('stepSec: $stepSec')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(exSn, hrLst, stepSec);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbFeatureExerciseHrData &&
          other.exSn == this.exSn &&
          other.hrLst == this.hrLst &&
          other.stepSec == this.stepSec);
}

class TbFeatureExerciseHrCompanion
    extends UpdateCompanion<TbFeatureExerciseHrData> {
  final Value<int> exSn;
  final Value<String> hrLst;
  final Value<int> stepSec;
  const TbFeatureExerciseHrCompanion({
    this.exSn = const Value.absent(),
    this.hrLst = const Value.absent(),
    this.stepSec = const Value.absent(),
  });
  TbFeatureExerciseHrCompanion.insert({
    this.exSn = const Value.absent(),
    required String hrLst,
    required int stepSec,
  }) : hrLst = Value(hrLst),
       stepSec = Value(stepSec);
  static Insertable<TbFeatureExerciseHrData> custom({
    Expression<int>? exSn,
    Expression<String>? hrLst,
    Expression<int>? stepSec,
  }) {
    return RawValuesInsertable({
      if (exSn != null) 'ex_sn': exSn,
      if (hrLst != null) 'hr_lst': hrLst,
      if (stepSec != null) 'step_sec': stepSec,
    });
  }

  TbFeatureExerciseHrCompanion copyWith({
    Value<int>? exSn,
    Value<String>? hrLst,
    Value<int>? stepSec,
  }) {
    return TbFeatureExerciseHrCompanion(
      exSn: exSn ?? this.exSn,
      hrLst: hrLst ?? this.hrLst,
      stepSec: stepSec ?? this.stepSec,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (exSn.present) {
      map['ex_sn'] = Variable<int>(exSn.value);
    }
    if (hrLst.present) {
      map['hr_lst'] = Variable<String>(hrLst.value);
    }
    if (stepSec.present) {
      map['step_sec'] = Variable<int>(stepSec.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbFeatureExerciseHrCompanion(')
          ..write('exSn: $exSn, ')
          ..write('hrLst: $hrLst, ')
          ..write('stepSec: $stepSec')
          ..write(')'))
        .toString();
  }
}

abstract class _$BodymindDatabase extends GeneratedDatabase {
  _$BodymindDatabase(QueryExecutor e) : super(e);
  $BodymindDatabaseManager get managers => $BodymindDatabaseManager(this);
  late final TbOnboardStatus tbOnboardStatus = TbOnboardStatus(this);
  late final TbUserInfo tbUserInfo = TbUserInfo(this);
  late final TbDailyHrProxyInfo tbDailyHrProxyInfo = TbDailyHrProxyInfo(this);
  late final TbFeatureActInfo tbFeatureActInfo = TbFeatureActInfo(this);
  late final TbFeatureHrInfo tbFeatureHrInfo = TbFeatureHrInfo(this);
  late final TbFeatureSleepInfo tbFeatureSleepInfo = TbFeatureSleepInfo(this);
  late final TbFeatureSleepDetail tbFeatureSleepDetail = TbFeatureSleepDetail(
    this,
  );
  late final TbFeatureExerciseInfo tbFeatureExerciseInfo =
      TbFeatureExerciseInfo(this);
  late final TbFeatureExerciseHr tbFeatureExerciseHr = TbFeatureExerciseHr(
    this,
  );
  late final Index idxExBaseDate = Index(
    'idx_ex_base_date',
    'CREATE INDEX idx_ex_base_date ON tb_feature_exercise_info (base_date)',
  );
  late final Index idxExHrExSn = Index(
    'idx_ex_hr_ex_sn',
    'CREATE INDEX idx_ex_hr_ex_sn ON tb_feature_exercise_hr (ex_sn)',
  );
  late final Index uxSleepDetail = Index(
    'ux_sleep_detail',
    'CREATE UNIQUE INDEX ux_sleep_detail ON tb_feature_sleep_detail (slp_sn, stage, start_at, end_at)',
  );
  Selectable<String> selectOnboardStatus() {
    return customSelect(
      'SELECT onboard_yn FROM tb_onboard_status',
      variables: [],
      readsFrom: {tbOnboardStatus},
    ).map((QueryRow row) => row.read<String>('onboard_yn'));
  }

  Future<int> insertOnboardStatus(int? onboardSn, String onboardYn) {
    return customInsert(
      'INSERT OR REPLACE INTO tb_onboard_status (onboard_sn, onboard_yn) VALUES (?1, ?2)',
      variables: [Variable<int>(onboardSn), Variable<String>(onboardYn)],
      updates: {tbOnboardStatus},
    );
  }

  Future<int> deleteOnboardStatus() {
    return customUpdate(
      'DELETE FROM tb_onboard_status',
      variables: [],
      updates: {tbOnboardStatus},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<TbUserInfoData> selectUserInfo() {
    return customSelect(
      'SELECT * FROM tb_user_info',
      variables: [],
      readsFrom: {tbUserInfo},
    ).asyncMap(tbUserInfo.mapFromRow);
  }

  Future<int> insertUserInfo(
    String nickName,
    int age,
    double height,
    double weight,
    String gender,
  ) {
    return customInsert(
      'INSERT OR REPLACE INTO tb_user_info (nick_name, age, height, weight, gender) VALUES (?1, ?2, ?3, ?4, ?5)',
      variables: [
        Variable<String>(nickName),
        Variable<int>(age),
        Variable<double>(height),
        Variable<double>(weight),
        Variable<String>(gender),
      ],
      updates: {tbUserInfo},
    );
  }

  Future<int> deleteUserInfo() {
    return customUpdate(
      'DELETE FROM tb_user_info',
      variables: [],
      updates: {tbUserInfo},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> insertHrProxy(
    String? isrtDt,
    double? restBase,
    double? varBase,
    double? highBase,
  ) {
    return customInsert(
      'INSERT OR REPLACE INTO tb_daily_hr_proxy_info (isrt_dt, rest_base, var_base, high_base) VALUES (?1, ?2, ?3, ?4)',
      variables: [
        Variable<String>(isrtDt),
        Variable<double>(restBase),
        Variable<double>(varBase),
        Variable<double>(highBase),
      ],
      updates: {tbDailyHrProxyInfo},
    );
  }

  Future<int> insertFeatureHrInfo(String? isrtDt, String hrLst) {
    return customInsert(
      'INSERT OR REPLACE INTO tb_feature_hr_info (isrt_dt, hr_lst) VALUES (?1, ?2)',
      variables: [Variable<String>(isrtDt), Variable<String>(hrLst)],
      updates: {tbFeatureHrInfo},
    );
  }

  Selectable<TbFeatureHrInfoData> selectFeatureHr(String previousDay) {
    return customSelect(
      'SELECT isrt_dt, hr_lst FROM tb_feature_hr_info WHERE isrt_dt BETWEEN strftime(\'%Y%m%d\', \'now\', \'localtime\', ?1) AND strftime(\'%Y%m%d\', \'now\', \'localtime\')',
      variables: [Variable<String>(previousDay)],
      readsFrom: {tbFeatureHrInfo},
    ).asyncMap(tbFeatureHrInfo.mapFromRow);
  }

  Selectable<TbFeatureHrInfoData> selectHrDtlForDate(String? slctDt) {
    return customSelect(
      'SELECT isrt_dt, hr_lst FROM tb_feature_hr_info WHERE isrt_dt = ?1',
      variables: [Variable<String>(slctDt)],
      readsFrom: {tbFeatureHrInfo},
    ).asyncMap(tbFeatureHrInfo.mapFromRow);
  }

  Future<int> insertFeatureActInfo(
    String? isrtDt,
    int stepCount,
    double distance,
    double calorie,
  ) {
    return customInsert(
      'INSERT OR REPLACE INTO tb_feature_act_info (isrt_dt, step_count, distance, calorie) VALUES (?1, ?2, ?3, ?4)',
      variables: [
        Variable<String>(isrtDt),
        Variable<int>(stepCount),
        Variable<double>(distance),
        Variable<double>(calorie),
      ],
      updates: {tbFeatureActInfo},
    );
  }

  Selectable<TbFeatureActInfoData> selectFeatureAct() {
    return customSelect(
      'SELECT isrt_dt, step_count, distance, calorie FROM tb_feature_act_info WHERE isrt_dt BETWEEN strftime(\'%Y%m%d\', \'now\', \'localtime\', \'-6 day\') AND strftime(\'%Y%m%d\', \'now\', \'localtime\')',
      variables: [],
      readsFrom: {tbFeatureActInfo},
    ).asyncMap(tbFeatureActInfo.mapFromRow);
  }

  Selectable<SelectFeatureExerciseResult> selectFeatureExercise() {
    return customSelect(
      'SELECT i.base_date, i.ex_sn, i.type, i.metric_kind, i.metric_val, i.distance, i.calorie, i.start_hhmm, i.end_hhmm, h.hr_idx, h.hr, h.step_sec FROM tb_feature_exercise_info AS i JOIN tb_feature_exercise_hr AS h ON h.ex_sn = i.ex_sn WHERE i.base_date BETWEEN strftime(\'%Y%m%d\', \'now\', \'localtime\', \'-6 day\') AND strftime(\'%Y%m%d\', \'now\', \'localtime\') ORDER BY i.base_date, i.start_hhmm, h.hr_idx',
      variables: [],
      readsFrom: {tbFeatureExerciseInfo, tbFeatureExerciseHr},
    ).map(
      (QueryRow row) => SelectFeatureExerciseResult(
        baseDate: row.read<String>('base_date'),
        exSn: row.read<int>('ex_sn'),
        type: row.read<int>('type'),
        metricKind: row.read<String>('metric_kind'),
        metricVal: row.read<double>('metric_val'),
        distance: row.read<double>('distance'),
        calorie: row.read<double>('calorie'),
        startHhmm: row.read<String>('start_hhmm'),
        endHhmm: row.read<String>('end_hhmm'),
        hrIdx: row.readNullable<String>('hr_idx'),
        hr: row.readNullable<String>('hr'),
        stepSec: row.read<int>('step_sec'),
      ),
    );
  }

  Future<int> insertExerciseInfo(
    String baseDate,
    int type,
    String metricKind,
    double metricVal,
    double distance,
    double calorie,
    String startHhmm,
    String endHhmm,
  ) {
    return customInsert(
      'INSERT INTO tb_feature_exercise_info (base_date, type, metric_kind, metric_val, distance, calorie, start_hhmm, end_hhmm) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8)',
      variables: [
        Variable<String>(baseDate),
        Variable<int>(type),
        Variable<String>(metricKind),
        Variable<double>(metricVal),
        Variable<double>(distance),
        Variable<double>(calorie),
        Variable<String>(startHhmm),
        Variable<String>(endHhmm),
      ],
      updates: {tbFeatureExerciseInfo},
    );
  }

  Future<int> insertFeatureSleepInfo(
    String totalInbedM,
    String? totalSlpM,
    String? totalAwakeM,
    int totalLightM,
    int totalDeepM,
    int totalRemM,
  ) {
    return customInsert(
      'INSERT INTO tb_feature_sleep_info (base_date, start_at, end_at, total_inbed_m, total_slp_m, total_awake_m, total_light_m, total_deep_m, total_rem_m) VALUES (?1, ?2, ?3, ?4, ?5, ?6) ON CONFLICT (base_date) DO UPDATE SET start_at = excluded.start_at, end_at = excluded.end_at, total_inbed_m = excluded.total_inbed_m, total_slp_m = excluded.total_slp_m, total_awake_m = excluded.total_awake_m, total_light_m = excluded.total_light_m, total_deep_m = excluded.total_deep_m, total_rem_m = excluded.total_rem_m',
      variables: [
        Variable<String>(totalInbedM),
        Variable<String>(totalSlpM),
        Variable<String>(totalAwakeM),
        Variable<int>(totalLightM),
        Variable<int>(totalDeepM),
        Variable<int>(totalRemM),
      ],
      updates: {tbFeatureSleepInfo},
    );
  }

  Selectable<SelectFeatureSleepSegmentaionResult>
  selectFeatureSleepSegmentaion() {
    return customSelect(
      'SELECT i.base_date, i.start_at, i.end_at, d.stage, d.start_at AS seg_start, d.end_at AS seg_end, d.duration_m FROM tb_feature_sleep_info AS i JOIN tb_feature_sleep_detail AS d ON d.slp_sn = i.slp_sn WHERE i.base_date BETWEEN strftime(\'%Y%m%d\', \'now\', \'localtime\', \'-6 day\') AND strftime(\'%Y%m%d\', \'now\', \'localtime\') ORDER BY i.base_date, d.start_at',
      variables: [],
      readsFrom: {tbFeatureSleepInfo, tbFeatureSleepDetail},
    ).map(
      (QueryRow row) => SelectFeatureSleepSegmentaionResult(
        baseDate: row.read<String>('base_date'),
        startAt: row.readNullable<String>('start_at'),
        endAt: row.readNullable<String>('end_at'),
        stage: row.read<String>('stage'),
        segStart: row.read<String>('seg_start'),
        segEnd: row.read<String>('seg_end'),
        durationM: row.read<int>('duration_m'),
      ),
    );
  }

  Selectable<SelectFeatureSleepInfoResult> selectFeatureSleepInfo() {
    return customSelect(
      'SELECT i.base_date, SUM(d.duration_m) AS total_m, SUM(CASE WHEN d.stage = \'AWAKE\' THEN d.duration_m ELSE 0 END) AS awake_m, SUM(CASE WHEN d.stage = \'LIGHT\' THEN d.duration_m ELSE 0 END) AS light_m, SUM(CASE WHEN d.stage = \'REM\' THEN d.duration_m ELSE 0 END) AS rem_m, SUM(CASE WHEN d.stage = \'DEEP\' THEN d.duration_m ELSE 0 END) AS deep_m, COUNT(*) AS segment_cnt FROM tb_feature_sleep_info AS i JOIN tb_feature_sleep_detail AS d ON d.slp_sn = i.slp_sn WHERE i.base_date BETWEEN strftime(\'%Y%m%d\', \'now\', \'localtime\', \'-6 day\') AND strftime(\'%Y%m%d\', \'now\', \'localtime\') GROUP BY i.base_date ORDER BY i.base_date',
      variables: [],
      readsFrom: {tbFeatureSleepInfo, tbFeatureSleepDetail},
    ).map(
      (QueryRow row) => SelectFeatureSleepInfoResult(
        baseDate: row.read<String>('base_date'),
        totalM: row.readNullable<int>('total_m'),
        awakeM: row.readNullable<int>('awake_m'),
        lightM: row.readNullable<int>('light_m'),
        remM: row.readNullable<int>('rem_m'),
        deepM: row.readNullable<int>('deep_m'),
        segmentCnt: row.read<int>('segment_cnt'),
      ),
    );
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    tbOnboardStatus,
    tbUserInfo,
    tbDailyHrProxyInfo,
    tbFeatureActInfo,
    tbFeatureHrInfo,
    tbFeatureSleepInfo,
    tbFeatureSleepDetail,
    tbFeatureExerciseInfo,
    tbFeatureExerciseHr,
    idxExBaseDate,
    idxExHrExSn,
    uxSleepDetail,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tb_feature_sleep_info',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tb_feature_sleep_detail', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tb_feature_exercise_info',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tb_feature_exercise_hr', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $TbOnboardStatusCreateCompanionBuilder =
    TbOnboardStatusCompanion Function({
      Value<int?> onboardSn,
      required String onboardYn,
    });
typedef $TbOnboardStatusUpdateCompanionBuilder =
    TbOnboardStatusCompanion Function({
      Value<int?> onboardSn,
      Value<String> onboardYn,
    });

class $TbOnboardStatusFilterComposer
    extends Composer<_$BodymindDatabase, TbOnboardStatus> {
  $TbOnboardStatusFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get onboardSn => $composableBuilder(
    column: $table.onboardSn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get onboardYn => $composableBuilder(
    column: $table.onboardYn,
    builder: (column) => ColumnFilters(column),
  );
}

class $TbOnboardStatusOrderingComposer
    extends Composer<_$BodymindDatabase, TbOnboardStatus> {
  $TbOnboardStatusOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get onboardSn => $composableBuilder(
    column: $table.onboardSn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get onboardYn => $composableBuilder(
    column: $table.onboardYn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TbOnboardStatusAnnotationComposer
    extends Composer<_$BodymindDatabase, TbOnboardStatus> {
  $TbOnboardStatusAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get onboardSn =>
      $composableBuilder(column: $table.onboardSn, builder: (column) => column);

  GeneratedColumn<String> get onboardYn =>
      $composableBuilder(column: $table.onboardYn, builder: (column) => column);
}

class $TbOnboardStatusTableManager
    extends
        RootTableManager<
          _$BodymindDatabase,
          TbOnboardStatus,
          TbOnboardStatusData,
          $TbOnboardStatusFilterComposer,
          $TbOnboardStatusOrderingComposer,
          $TbOnboardStatusAnnotationComposer,
          $TbOnboardStatusCreateCompanionBuilder,
          $TbOnboardStatusUpdateCompanionBuilder,
          (
            TbOnboardStatusData,
            BaseReferences<
              _$BodymindDatabase,
              TbOnboardStatus,
              TbOnboardStatusData
            >,
          ),
          TbOnboardStatusData,
          PrefetchHooks Function()
        > {
  $TbOnboardStatusTableManager(_$BodymindDatabase db, TbOnboardStatus table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TbOnboardStatusFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TbOnboardStatusOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TbOnboardStatusAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int?> onboardSn = const Value.absent(),
                Value<String> onboardYn = const Value.absent(),
              }) => TbOnboardStatusCompanion(
                onboardSn: onboardSn,
                onboardYn: onboardYn,
              ),
          createCompanionCallback:
              ({
                Value<int?> onboardSn = const Value.absent(),
                required String onboardYn,
              }) => TbOnboardStatusCompanion.insert(
                onboardSn: onboardSn,
                onboardYn: onboardYn,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TbOnboardStatusProcessedTableManager =
    ProcessedTableManager<
      _$BodymindDatabase,
      TbOnboardStatus,
      TbOnboardStatusData,
      $TbOnboardStatusFilterComposer,
      $TbOnboardStatusOrderingComposer,
      $TbOnboardStatusAnnotationComposer,
      $TbOnboardStatusCreateCompanionBuilder,
      $TbOnboardStatusUpdateCompanionBuilder,
      (
        TbOnboardStatusData,
        BaseReferences<
          _$BodymindDatabase,
          TbOnboardStatus,
          TbOnboardStatusData
        >,
      ),
      TbOnboardStatusData,
      PrefetchHooks Function()
    >;
typedef $TbUserInfoCreateCompanionBuilder =
    TbUserInfoCompanion Function({
      required String nickName,
      required int age,
      required double height,
      required double weight,
      required String gender,
      Value<int> rowid,
    });
typedef $TbUserInfoUpdateCompanionBuilder =
    TbUserInfoCompanion Function({
      Value<String> nickName,
      Value<int> age,
      Value<double> height,
      Value<double> weight,
      Value<String> gender,
      Value<int> rowid,
    });

class $TbUserInfoFilterComposer
    extends Composer<_$BodymindDatabase, TbUserInfo> {
  $TbUserInfoFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get nickName => $composableBuilder(
    column: $table.nickName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );
}

class $TbUserInfoOrderingComposer
    extends Composer<_$BodymindDatabase, TbUserInfo> {
  $TbUserInfoOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get nickName => $composableBuilder(
    column: $table.nickName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get age => $composableBuilder(
    column: $table.age,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TbUserInfoAnnotationComposer
    extends Composer<_$BodymindDatabase, TbUserInfo> {
  $TbUserInfoAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get nickName =>
      $composableBuilder(column: $table.nickName, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);
}

class $TbUserInfoTableManager
    extends
        RootTableManager<
          _$BodymindDatabase,
          TbUserInfo,
          TbUserInfoData,
          $TbUserInfoFilterComposer,
          $TbUserInfoOrderingComposer,
          $TbUserInfoAnnotationComposer,
          $TbUserInfoCreateCompanionBuilder,
          $TbUserInfoUpdateCompanionBuilder,
          (
            TbUserInfoData,
            BaseReferences<_$BodymindDatabase, TbUserInfo, TbUserInfoData>,
          ),
          TbUserInfoData,
          PrefetchHooks Function()
        > {
  $TbUserInfoTableManager(_$BodymindDatabase db, TbUserInfo table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TbUserInfoFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TbUserInfoOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TbUserInfoAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> nickName = const Value.absent(),
                Value<int> age = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TbUserInfoCompanion(
                nickName: nickName,
                age: age,
                height: height,
                weight: weight,
                gender: gender,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String nickName,
                required int age,
                required double height,
                required double weight,
                required String gender,
                Value<int> rowid = const Value.absent(),
              }) => TbUserInfoCompanion.insert(
                nickName: nickName,
                age: age,
                height: height,
                weight: weight,
                gender: gender,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TbUserInfoProcessedTableManager =
    ProcessedTableManager<
      _$BodymindDatabase,
      TbUserInfo,
      TbUserInfoData,
      $TbUserInfoFilterComposer,
      $TbUserInfoOrderingComposer,
      $TbUserInfoAnnotationComposer,
      $TbUserInfoCreateCompanionBuilder,
      $TbUserInfoUpdateCompanionBuilder,
      (
        TbUserInfoData,
        BaseReferences<_$BodymindDatabase, TbUserInfo, TbUserInfoData>,
      ),
      TbUserInfoData,
      PrefetchHooks Function()
    >;
typedef $TbDailyHrProxyInfoCreateCompanionBuilder =
    TbDailyHrProxyInfoCompanion Function({
      Value<String?> isrtDt,
      Value<double?> restBase,
      Value<double?> varBase,
      Value<double?> highBase,
      Value<int> rowid,
    });
typedef $TbDailyHrProxyInfoUpdateCompanionBuilder =
    TbDailyHrProxyInfoCompanion Function({
      Value<String?> isrtDt,
      Value<double?> restBase,
      Value<double?> varBase,
      Value<double?> highBase,
      Value<int> rowid,
    });

class $TbDailyHrProxyInfoFilterComposer
    extends Composer<_$BodymindDatabase, TbDailyHrProxyInfo> {
  $TbDailyHrProxyInfoFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get isrtDt => $composableBuilder(
    column: $table.isrtDt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get restBase => $composableBuilder(
    column: $table.restBase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get varBase => $composableBuilder(
    column: $table.varBase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get highBase => $composableBuilder(
    column: $table.highBase,
    builder: (column) => ColumnFilters(column),
  );
}

class $TbDailyHrProxyInfoOrderingComposer
    extends Composer<_$BodymindDatabase, TbDailyHrProxyInfo> {
  $TbDailyHrProxyInfoOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get isrtDt => $composableBuilder(
    column: $table.isrtDt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get restBase => $composableBuilder(
    column: $table.restBase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get varBase => $composableBuilder(
    column: $table.varBase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get highBase => $composableBuilder(
    column: $table.highBase,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TbDailyHrProxyInfoAnnotationComposer
    extends Composer<_$BodymindDatabase, TbDailyHrProxyInfo> {
  $TbDailyHrProxyInfoAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get isrtDt =>
      $composableBuilder(column: $table.isrtDt, builder: (column) => column);

  GeneratedColumn<double> get restBase =>
      $composableBuilder(column: $table.restBase, builder: (column) => column);

  GeneratedColumn<double> get varBase =>
      $composableBuilder(column: $table.varBase, builder: (column) => column);

  GeneratedColumn<double> get highBase =>
      $composableBuilder(column: $table.highBase, builder: (column) => column);
}

class $TbDailyHrProxyInfoTableManager
    extends
        RootTableManager<
          _$BodymindDatabase,
          TbDailyHrProxyInfo,
          TbDailyHrProxyInfoData,
          $TbDailyHrProxyInfoFilterComposer,
          $TbDailyHrProxyInfoOrderingComposer,
          $TbDailyHrProxyInfoAnnotationComposer,
          $TbDailyHrProxyInfoCreateCompanionBuilder,
          $TbDailyHrProxyInfoUpdateCompanionBuilder,
          (
            TbDailyHrProxyInfoData,
            BaseReferences<
              _$BodymindDatabase,
              TbDailyHrProxyInfo,
              TbDailyHrProxyInfoData
            >,
          ),
          TbDailyHrProxyInfoData,
          PrefetchHooks Function()
        > {
  $TbDailyHrProxyInfoTableManager(
    _$BodymindDatabase db,
    TbDailyHrProxyInfo table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TbDailyHrProxyInfoFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TbDailyHrProxyInfoOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TbDailyHrProxyInfoAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> isrtDt = const Value.absent(),
                Value<double?> restBase = const Value.absent(),
                Value<double?> varBase = const Value.absent(),
                Value<double?> highBase = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TbDailyHrProxyInfoCompanion(
                isrtDt: isrtDt,
                restBase: restBase,
                varBase: varBase,
                highBase: highBase,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String?> isrtDt = const Value.absent(),
                Value<double?> restBase = const Value.absent(),
                Value<double?> varBase = const Value.absent(),
                Value<double?> highBase = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TbDailyHrProxyInfoCompanion.insert(
                isrtDt: isrtDt,
                restBase: restBase,
                varBase: varBase,
                highBase: highBase,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TbDailyHrProxyInfoProcessedTableManager =
    ProcessedTableManager<
      _$BodymindDatabase,
      TbDailyHrProxyInfo,
      TbDailyHrProxyInfoData,
      $TbDailyHrProxyInfoFilterComposer,
      $TbDailyHrProxyInfoOrderingComposer,
      $TbDailyHrProxyInfoAnnotationComposer,
      $TbDailyHrProxyInfoCreateCompanionBuilder,
      $TbDailyHrProxyInfoUpdateCompanionBuilder,
      (
        TbDailyHrProxyInfoData,
        BaseReferences<
          _$BodymindDatabase,
          TbDailyHrProxyInfo,
          TbDailyHrProxyInfoData
        >,
      ),
      TbDailyHrProxyInfoData,
      PrefetchHooks Function()
    >;
typedef $TbFeatureActInfoCreateCompanionBuilder =
    TbFeatureActInfoCompanion Function({
      Value<String?> isrtDt,
      required int stepCount,
      required double distance,
      required double calorie,
      Value<int> rowid,
    });
typedef $TbFeatureActInfoUpdateCompanionBuilder =
    TbFeatureActInfoCompanion Function({
      Value<String?> isrtDt,
      Value<int> stepCount,
      Value<double> distance,
      Value<double> calorie,
      Value<int> rowid,
    });

class $TbFeatureActInfoFilterComposer
    extends Composer<_$BodymindDatabase, TbFeatureActInfo> {
  $TbFeatureActInfoFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get isrtDt => $composableBuilder(
    column: $table.isrtDt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepCount => $composableBuilder(
    column: $table.stepCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distance => $composableBuilder(
    column: $table.distance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calorie => $composableBuilder(
    column: $table.calorie,
    builder: (column) => ColumnFilters(column),
  );
}

class $TbFeatureActInfoOrderingComposer
    extends Composer<_$BodymindDatabase, TbFeatureActInfo> {
  $TbFeatureActInfoOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get isrtDt => $composableBuilder(
    column: $table.isrtDt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepCount => $composableBuilder(
    column: $table.stepCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distance => $composableBuilder(
    column: $table.distance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calorie => $composableBuilder(
    column: $table.calorie,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TbFeatureActInfoAnnotationComposer
    extends Composer<_$BodymindDatabase, TbFeatureActInfo> {
  $TbFeatureActInfoAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get isrtDt =>
      $composableBuilder(column: $table.isrtDt, builder: (column) => column);

  GeneratedColumn<int> get stepCount =>
      $composableBuilder(column: $table.stepCount, builder: (column) => column);

  GeneratedColumn<double> get distance =>
      $composableBuilder(column: $table.distance, builder: (column) => column);

  GeneratedColumn<double> get calorie =>
      $composableBuilder(column: $table.calorie, builder: (column) => column);
}

class $TbFeatureActInfoTableManager
    extends
        RootTableManager<
          _$BodymindDatabase,
          TbFeatureActInfo,
          TbFeatureActInfoData,
          $TbFeatureActInfoFilterComposer,
          $TbFeatureActInfoOrderingComposer,
          $TbFeatureActInfoAnnotationComposer,
          $TbFeatureActInfoCreateCompanionBuilder,
          $TbFeatureActInfoUpdateCompanionBuilder,
          (
            TbFeatureActInfoData,
            BaseReferences<
              _$BodymindDatabase,
              TbFeatureActInfo,
              TbFeatureActInfoData
            >,
          ),
          TbFeatureActInfoData,
          PrefetchHooks Function()
        > {
  $TbFeatureActInfoTableManager(_$BodymindDatabase db, TbFeatureActInfo table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TbFeatureActInfoFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TbFeatureActInfoOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TbFeatureActInfoAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> isrtDt = const Value.absent(),
                Value<int> stepCount = const Value.absent(),
                Value<double> distance = const Value.absent(),
                Value<double> calorie = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TbFeatureActInfoCompanion(
                isrtDt: isrtDt,
                stepCount: stepCount,
                distance: distance,
                calorie: calorie,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String?> isrtDt = const Value.absent(),
                required int stepCount,
                required double distance,
                required double calorie,
                Value<int> rowid = const Value.absent(),
              }) => TbFeatureActInfoCompanion.insert(
                isrtDt: isrtDt,
                stepCount: stepCount,
                distance: distance,
                calorie: calorie,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TbFeatureActInfoProcessedTableManager =
    ProcessedTableManager<
      _$BodymindDatabase,
      TbFeatureActInfo,
      TbFeatureActInfoData,
      $TbFeatureActInfoFilterComposer,
      $TbFeatureActInfoOrderingComposer,
      $TbFeatureActInfoAnnotationComposer,
      $TbFeatureActInfoCreateCompanionBuilder,
      $TbFeatureActInfoUpdateCompanionBuilder,
      (
        TbFeatureActInfoData,
        BaseReferences<
          _$BodymindDatabase,
          TbFeatureActInfo,
          TbFeatureActInfoData
        >,
      ),
      TbFeatureActInfoData,
      PrefetchHooks Function()
    >;
typedef $TbFeatureHrInfoCreateCompanionBuilder =
    TbFeatureHrInfoCompanion Function({
      Value<String?> isrtDt,
      required String hrLst,
      Value<int> rowid,
    });
typedef $TbFeatureHrInfoUpdateCompanionBuilder =
    TbFeatureHrInfoCompanion Function({
      Value<String?> isrtDt,
      Value<String> hrLst,
      Value<int> rowid,
    });

class $TbFeatureHrInfoFilterComposer
    extends Composer<_$BodymindDatabase, TbFeatureHrInfo> {
  $TbFeatureHrInfoFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get isrtDt => $composableBuilder(
    column: $table.isrtDt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hrLst => $composableBuilder(
    column: $table.hrLst,
    builder: (column) => ColumnFilters(column),
  );
}

class $TbFeatureHrInfoOrderingComposer
    extends Composer<_$BodymindDatabase, TbFeatureHrInfo> {
  $TbFeatureHrInfoOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get isrtDt => $composableBuilder(
    column: $table.isrtDt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hrLst => $composableBuilder(
    column: $table.hrLst,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TbFeatureHrInfoAnnotationComposer
    extends Composer<_$BodymindDatabase, TbFeatureHrInfo> {
  $TbFeatureHrInfoAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get isrtDt =>
      $composableBuilder(column: $table.isrtDt, builder: (column) => column);

  GeneratedColumn<String> get hrLst =>
      $composableBuilder(column: $table.hrLst, builder: (column) => column);
}

class $TbFeatureHrInfoTableManager
    extends
        RootTableManager<
          _$BodymindDatabase,
          TbFeatureHrInfo,
          TbFeatureHrInfoData,
          $TbFeatureHrInfoFilterComposer,
          $TbFeatureHrInfoOrderingComposer,
          $TbFeatureHrInfoAnnotationComposer,
          $TbFeatureHrInfoCreateCompanionBuilder,
          $TbFeatureHrInfoUpdateCompanionBuilder,
          (
            TbFeatureHrInfoData,
            BaseReferences<
              _$BodymindDatabase,
              TbFeatureHrInfo,
              TbFeatureHrInfoData
            >,
          ),
          TbFeatureHrInfoData,
          PrefetchHooks Function()
        > {
  $TbFeatureHrInfoTableManager(_$BodymindDatabase db, TbFeatureHrInfo table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TbFeatureHrInfoFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TbFeatureHrInfoOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TbFeatureHrInfoAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> isrtDt = const Value.absent(),
                Value<String> hrLst = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TbFeatureHrInfoCompanion(
                isrtDt: isrtDt,
                hrLst: hrLst,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String?> isrtDt = const Value.absent(),
                required String hrLst,
                Value<int> rowid = const Value.absent(),
              }) => TbFeatureHrInfoCompanion.insert(
                isrtDt: isrtDt,
                hrLst: hrLst,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TbFeatureHrInfoProcessedTableManager =
    ProcessedTableManager<
      _$BodymindDatabase,
      TbFeatureHrInfo,
      TbFeatureHrInfoData,
      $TbFeatureHrInfoFilterComposer,
      $TbFeatureHrInfoOrderingComposer,
      $TbFeatureHrInfoAnnotationComposer,
      $TbFeatureHrInfoCreateCompanionBuilder,
      $TbFeatureHrInfoUpdateCompanionBuilder,
      (
        TbFeatureHrInfoData,
        BaseReferences<
          _$BodymindDatabase,
          TbFeatureHrInfo,
          TbFeatureHrInfoData
        >,
      ),
      TbFeatureHrInfoData,
      PrefetchHooks Function()
    >;
typedef $TbFeatureSleepInfoCreateCompanionBuilder =
    TbFeatureSleepInfoCompanion Function({
      Value<int> slpSn,
      required String baseDate,
      Value<String?> startAt,
      Value<String?> endAt,
      required int totalInbedM,
      required int totalSlpM,
      required int totalAwakeM,
      required int totalLightM,
      required int totalDeepM,
      required int totalRemM,
    });
typedef $TbFeatureSleepInfoUpdateCompanionBuilder =
    TbFeatureSleepInfoCompanion Function({
      Value<int> slpSn,
      Value<String> baseDate,
      Value<String?> startAt,
      Value<String?> endAt,
      Value<int> totalInbedM,
      Value<int> totalSlpM,
      Value<int> totalAwakeM,
      Value<int> totalLightM,
      Value<int> totalDeepM,
      Value<int> totalRemM,
    });

class $TbFeatureSleepInfoFilterComposer
    extends Composer<_$BodymindDatabase, TbFeatureSleepInfo> {
  $TbFeatureSleepInfoFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slpSn => $composableBuilder(
    column: $table.slpSn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseDate => $composableBuilder(
    column: $table.baseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalInbedM => $composableBuilder(
    column: $table.totalInbedM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSlpM => $composableBuilder(
    column: $table.totalSlpM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAwakeM => $composableBuilder(
    column: $table.totalAwakeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalLightM => $composableBuilder(
    column: $table.totalLightM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalDeepM => $composableBuilder(
    column: $table.totalDeepM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalRemM => $composableBuilder(
    column: $table.totalRemM,
    builder: (column) => ColumnFilters(column),
  );
}

class $TbFeatureSleepInfoOrderingComposer
    extends Composer<_$BodymindDatabase, TbFeatureSleepInfo> {
  $TbFeatureSleepInfoOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slpSn => $composableBuilder(
    column: $table.slpSn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseDate => $composableBuilder(
    column: $table.baseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalInbedM => $composableBuilder(
    column: $table.totalInbedM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSlpM => $composableBuilder(
    column: $table.totalSlpM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAwakeM => $composableBuilder(
    column: $table.totalAwakeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalLightM => $composableBuilder(
    column: $table.totalLightM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalDeepM => $composableBuilder(
    column: $table.totalDeepM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalRemM => $composableBuilder(
    column: $table.totalRemM,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TbFeatureSleepInfoAnnotationComposer
    extends Composer<_$BodymindDatabase, TbFeatureSleepInfo> {
  $TbFeatureSleepInfoAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slpSn =>
      $composableBuilder(column: $table.slpSn, builder: (column) => column);

  GeneratedColumn<String> get baseDate =>
      $composableBuilder(column: $table.baseDate, builder: (column) => column);

  GeneratedColumn<String> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<String> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<int> get totalInbedM => $composableBuilder(
    column: $table.totalInbedM,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalSlpM =>
      $composableBuilder(column: $table.totalSlpM, builder: (column) => column);

  GeneratedColumn<int> get totalAwakeM => $composableBuilder(
    column: $table.totalAwakeM,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalLightM => $composableBuilder(
    column: $table.totalLightM,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalDeepM => $composableBuilder(
    column: $table.totalDeepM,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalRemM =>
      $composableBuilder(column: $table.totalRemM, builder: (column) => column);
}

class $TbFeatureSleepInfoTableManager
    extends
        RootTableManager<
          _$BodymindDatabase,
          TbFeatureSleepInfo,
          TbFeatureSleepInfoData,
          $TbFeatureSleepInfoFilterComposer,
          $TbFeatureSleepInfoOrderingComposer,
          $TbFeatureSleepInfoAnnotationComposer,
          $TbFeatureSleepInfoCreateCompanionBuilder,
          $TbFeatureSleepInfoUpdateCompanionBuilder,
          (
            TbFeatureSleepInfoData,
            BaseReferences<
              _$BodymindDatabase,
              TbFeatureSleepInfo,
              TbFeatureSleepInfoData
            >,
          ),
          TbFeatureSleepInfoData,
          PrefetchHooks Function()
        > {
  $TbFeatureSleepInfoTableManager(
    _$BodymindDatabase db,
    TbFeatureSleepInfo table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TbFeatureSleepInfoFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TbFeatureSleepInfoOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TbFeatureSleepInfoAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> slpSn = const Value.absent(),
                Value<String> baseDate = const Value.absent(),
                Value<String?> startAt = const Value.absent(),
                Value<String?> endAt = const Value.absent(),
                Value<int> totalInbedM = const Value.absent(),
                Value<int> totalSlpM = const Value.absent(),
                Value<int> totalAwakeM = const Value.absent(),
                Value<int> totalLightM = const Value.absent(),
                Value<int> totalDeepM = const Value.absent(),
                Value<int> totalRemM = const Value.absent(),
              }) => TbFeatureSleepInfoCompanion(
                slpSn: slpSn,
                baseDate: baseDate,
                startAt: startAt,
                endAt: endAt,
                totalInbedM: totalInbedM,
                totalSlpM: totalSlpM,
                totalAwakeM: totalAwakeM,
                totalLightM: totalLightM,
                totalDeepM: totalDeepM,
                totalRemM: totalRemM,
              ),
          createCompanionCallback:
              ({
                Value<int> slpSn = const Value.absent(),
                required String baseDate,
                Value<String?> startAt = const Value.absent(),
                Value<String?> endAt = const Value.absent(),
                required int totalInbedM,
                required int totalSlpM,
                required int totalAwakeM,
                required int totalLightM,
                required int totalDeepM,
                required int totalRemM,
              }) => TbFeatureSleepInfoCompanion.insert(
                slpSn: slpSn,
                baseDate: baseDate,
                startAt: startAt,
                endAt: endAt,
                totalInbedM: totalInbedM,
                totalSlpM: totalSlpM,
                totalAwakeM: totalAwakeM,
                totalLightM: totalLightM,
                totalDeepM: totalDeepM,
                totalRemM: totalRemM,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TbFeatureSleepInfoProcessedTableManager =
    ProcessedTableManager<
      _$BodymindDatabase,
      TbFeatureSleepInfo,
      TbFeatureSleepInfoData,
      $TbFeatureSleepInfoFilterComposer,
      $TbFeatureSleepInfoOrderingComposer,
      $TbFeatureSleepInfoAnnotationComposer,
      $TbFeatureSleepInfoCreateCompanionBuilder,
      $TbFeatureSleepInfoUpdateCompanionBuilder,
      (
        TbFeatureSleepInfoData,
        BaseReferences<
          _$BodymindDatabase,
          TbFeatureSleepInfo,
          TbFeatureSleepInfoData
        >,
      ),
      TbFeatureSleepInfoData,
      PrefetchHooks Function()
    >;
typedef $TbFeatureSleepDetailCreateCompanionBuilder =
    TbFeatureSleepDetailCompanion Function({
      Value<int> slpDetailSn,
      required int slpSn,
      required String stage,
      required String startAt,
      required String endAt,
      required int durationM,
    });
typedef $TbFeatureSleepDetailUpdateCompanionBuilder =
    TbFeatureSleepDetailCompanion Function({
      Value<int> slpDetailSn,
      Value<int> slpSn,
      Value<String> stage,
      Value<String> startAt,
      Value<String> endAt,
      Value<int> durationM,
    });

class $TbFeatureSleepDetailFilterComposer
    extends Composer<_$BodymindDatabase, TbFeatureSleepDetail> {
  $TbFeatureSleepDetailFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slpDetailSn => $composableBuilder(
    column: $table.slpDetailSn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slpSn => $composableBuilder(
    column: $table.slpSn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationM => $composableBuilder(
    column: $table.durationM,
    builder: (column) => ColumnFilters(column),
  );
}

class $TbFeatureSleepDetailOrderingComposer
    extends Composer<_$BodymindDatabase, TbFeatureSleepDetail> {
  $TbFeatureSleepDetailOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slpDetailSn => $composableBuilder(
    column: $table.slpDetailSn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slpSn => $composableBuilder(
    column: $table.slpSn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endAt => $composableBuilder(
    column: $table.endAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationM => $composableBuilder(
    column: $table.durationM,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TbFeatureSleepDetailAnnotationComposer
    extends Composer<_$BodymindDatabase, TbFeatureSleepDetail> {
  $TbFeatureSleepDetailAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slpDetailSn => $composableBuilder(
    column: $table.slpDetailSn,
    builder: (column) => column,
  );

  GeneratedColumn<int> get slpSn =>
      $composableBuilder(column: $table.slpSn, builder: (column) => column);

  GeneratedColumn<String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<String> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<String> get endAt =>
      $composableBuilder(column: $table.endAt, builder: (column) => column);

  GeneratedColumn<int> get durationM =>
      $composableBuilder(column: $table.durationM, builder: (column) => column);
}

class $TbFeatureSleepDetailTableManager
    extends
        RootTableManager<
          _$BodymindDatabase,
          TbFeatureSleepDetail,
          TbFeatureSleepDetailData,
          $TbFeatureSleepDetailFilterComposer,
          $TbFeatureSleepDetailOrderingComposer,
          $TbFeatureSleepDetailAnnotationComposer,
          $TbFeatureSleepDetailCreateCompanionBuilder,
          $TbFeatureSleepDetailUpdateCompanionBuilder,
          (
            TbFeatureSleepDetailData,
            BaseReferences<
              _$BodymindDatabase,
              TbFeatureSleepDetail,
              TbFeatureSleepDetailData
            >,
          ),
          TbFeatureSleepDetailData,
          PrefetchHooks Function()
        > {
  $TbFeatureSleepDetailTableManager(
    _$BodymindDatabase db,
    TbFeatureSleepDetail table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TbFeatureSleepDetailFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TbFeatureSleepDetailOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TbFeatureSleepDetailAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> slpDetailSn = const Value.absent(),
                Value<int> slpSn = const Value.absent(),
                Value<String> stage = const Value.absent(),
                Value<String> startAt = const Value.absent(),
                Value<String> endAt = const Value.absent(),
                Value<int> durationM = const Value.absent(),
              }) => TbFeatureSleepDetailCompanion(
                slpDetailSn: slpDetailSn,
                slpSn: slpSn,
                stage: stage,
                startAt: startAt,
                endAt: endAt,
                durationM: durationM,
              ),
          createCompanionCallback:
              ({
                Value<int> slpDetailSn = const Value.absent(),
                required int slpSn,
                required String stage,
                required String startAt,
                required String endAt,
                required int durationM,
              }) => TbFeatureSleepDetailCompanion.insert(
                slpDetailSn: slpDetailSn,
                slpSn: slpSn,
                stage: stage,
                startAt: startAt,
                endAt: endAt,
                durationM: durationM,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TbFeatureSleepDetailProcessedTableManager =
    ProcessedTableManager<
      _$BodymindDatabase,
      TbFeatureSleepDetail,
      TbFeatureSleepDetailData,
      $TbFeatureSleepDetailFilterComposer,
      $TbFeatureSleepDetailOrderingComposer,
      $TbFeatureSleepDetailAnnotationComposer,
      $TbFeatureSleepDetailCreateCompanionBuilder,
      $TbFeatureSleepDetailUpdateCompanionBuilder,
      (
        TbFeatureSleepDetailData,
        BaseReferences<
          _$BodymindDatabase,
          TbFeatureSleepDetail,
          TbFeatureSleepDetailData
        >,
      ),
      TbFeatureSleepDetailData,
      PrefetchHooks Function()
    >;
typedef $TbFeatureExerciseInfoCreateCompanionBuilder =
    TbFeatureExerciseInfoCompanion Function({
      Value<int> exSn,
      required String baseDate,
      required int type,
      required String metricKind,
      required double metricVal,
      required double distance,
      required double calorie,
      required String startHhmm,
      required String endHhmm,
    });
typedef $TbFeatureExerciseInfoUpdateCompanionBuilder =
    TbFeatureExerciseInfoCompanion Function({
      Value<int> exSn,
      Value<String> baseDate,
      Value<int> type,
      Value<String> metricKind,
      Value<double> metricVal,
      Value<double> distance,
      Value<double> calorie,
      Value<String> startHhmm,
      Value<String> endHhmm,
    });

class $TbFeatureExerciseInfoFilterComposer
    extends Composer<_$BodymindDatabase, TbFeatureExerciseInfo> {
  $TbFeatureExerciseInfoFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get exSn => $composableBuilder(
    column: $table.exSn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseDate => $composableBuilder(
    column: $table.baseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metricKind => $composableBuilder(
    column: $table.metricKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get metricVal => $composableBuilder(
    column: $table.metricVal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distance => $composableBuilder(
    column: $table.distance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calorie => $composableBuilder(
    column: $table.calorie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startHhmm => $composableBuilder(
    column: $table.startHhmm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endHhmm => $composableBuilder(
    column: $table.endHhmm,
    builder: (column) => ColumnFilters(column),
  );
}

class $TbFeatureExerciseInfoOrderingComposer
    extends Composer<_$BodymindDatabase, TbFeatureExerciseInfo> {
  $TbFeatureExerciseInfoOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get exSn => $composableBuilder(
    column: $table.exSn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseDate => $composableBuilder(
    column: $table.baseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metricKind => $composableBuilder(
    column: $table.metricKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get metricVal => $composableBuilder(
    column: $table.metricVal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distance => $composableBuilder(
    column: $table.distance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calorie => $composableBuilder(
    column: $table.calorie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startHhmm => $composableBuilder(
    column: $table.startHhmm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endHhmm => $composableBuilder(
    column: $table.endHhmm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TbFeatureExerciseInfoAnnotationComposer
    extends Composer<_$BodymindDatabase, TbFeatureExerciseInfo> {
  $TbFeatureExerciseInfoAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get exSn =>
      $composableBuilder(column: $table.exSn, builder: (column) => column);

  GeneratedColumn<String> get baseDate =>
      $composableBuilder(column: $table.baseDate, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get metricKind => $composableBuilder(
    column: $table.metricKind,
    builder: (column) => column,
  );

  GeneratedColumn<double> get metricVal =>
      $composableBuilder(column: $table.metricVal, builder: (column) => column);

  GeneratedColumn<double> get distance =>
      $composableBuilder(column: $table.distance, builder: (column) => column);

  GeneratedColumn<double> get calorie =>
      $composableBuilder(column: $table.calorie, builder: (column) => column);

  GeneratedColumn<String> get startHhmm =>
      $composableBuilder(column: $table.startHhmm, builder: (column) => column);

  GeneratedColumn<String> get endHhmm =>
      $composableBuilder(column: $table.endHhmm, builder: (column) => column);
}

class $TbFeatureExerciseInfoTableManager
    extends
        RootTableManager<
          _$BodymindDatabase,
          TbFeatureExerciseInfo,
          TbFeatureExerciseInfoData,
          $TbFeatureExerciseInfoFilterComposer,
          $TbFeatureExerciseInfoOrderingComposer,
          $TbFeatureExerciseInfoAnnotationComposer,
          $TbFeatureExerciseInfoCreateCompanionBuilder,
          $TbFeatureExerciseInfoUpdateCompanionBuilder,
          (
            TbFeatureExerciseInfoData,
            BaseReferences<
              _$BodymindDatabase,
              TbFeatureExerciseInfo,
              TbFeatureExerciseInfoData
            >,
          ),
          TbFeatureExerciseInfoData,
          PrefetchHooks Function()
        > {
  $TbFeatureExerciseInfoTableManager(
    _$BodymindDatabase db,
    TbFeatureExerciseInfo table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TbFeatureExerciseInfoFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TbFeatureExerciseInfoOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TbFeatureExerciseInfoAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> exSn = const Value.absent(),
                Value<String> baseDate = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<String> metricKind = const Value.absent(),
                Value<double> metricVal = const Value.absent(),
                Value<double> distance = const Value.absent(),
                Value<double> calorie = const Value.absent(),
                Value<String> startHhmm = const Value.absent(),
                Value<String> endHhmm = const Value.absent(),
              }) => TbFeatureExerciseInfoCompanion(
                exSn: exSn,
                baseDate: baseDate,
                type: type,
                metricKind: metricKind,
                metricVal: metricVal,
                distance: distance,
                calorie: calorie,
                startHhmm: startHhmm,
                endHhmm: endHhmm,
              ),
          createCompanionCallback:
              ({
                Value<int> exSn = const Value.absent(),
                required String baseDate,
                required int type,
                required String metricKind,
                required double metricVal,
                required double distance,
                required double calorie,
                required String startHhmm,
                required String endHhmm,
              }) => TbFeatureExerciseInfoCompanion.insert(
                exSn: exSn,
                baseDate: baseDate,
                type: type,
                metricKind: metricKind,
                metricVal: metricVal,
                distance: distance,
                calorie: calorie,
                startHhmm: startHhmm,
                endHhmm: endHhmm,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TbFeatureExerciseInfoProcessedTableManager =
    ProcessedTableManager<
      _$BodymindDatabase,
      TbFeatureExerciseInfo,
      TbFeatureExerciseInfoData,
      $TbFeatureExerciseInfoFilterComposer,
      $TbFeatureExerciseInfoOrderingComposer,
      $TbFeatureExerciseInfoAnnotationComposer,
      $TbFeatureExerciseInfoCreateCompanionBuilder,
      $TbFeatureExerciseInfoUpdateCompanionBuilder,
      (
        TbFeatureExerciseInfoData,
        BaseReferences<
          _$BodymindDatabase,
          TbFeatureExerciseInfo,
          TbFeatureExerciseInfoData
        >,
      ),
      TbFeatureExerciseInfoData,
      PrefetchHooks Function()
    >;
typedef $TbFeatureExerciseHrCreateCompanionBuilder =
    TbFeatureExerciseHrCompanion Function({
      Value<int> exSn,
      required String hrLst,
      required int stepSec,
    });
typedef $TbFeatureExerciseHrUpdateCompanionBuilder =
    TbFeatureExerciseHrCompanion Function({
      Value<int> exSn,
      Value<String> hrLst,
      Value<int> stepSec,
    });

class $TbFeatureExerciseHrFilterComposer
    extends Composer<_$BodymindDatabase, TbFeatureExerciseHr> {
  $TbFeatureExerciseHrFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get exSn => $composableBuilder(
    column: $table.exSn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hrLst => $composableBuilder(
    column: $table.hrLst,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepSec => $composableBuilder(
    column: $table.stepSec,
    builder: (column) => ColumnFilters(column),
  );
}

class $TbFeatureExerciseHrOrderingComposer
    extends Composer<_$BodymindDatabase, TbFeatureExerciseHr> {
  $TbFeatureExerciseHrOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get exSn => $composableBuilder(
    column: $table.exSn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hrLst => $composableBuilder(
    column: $table.hrLst,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepSec => $composableBuilder(
    column: $table.stepSec,
    builder: (column) => ColumnOrderings(column),
  );
}

class $TbFeatureExerciseHrAnnotationComposer
    extends Composer<_$BodymindDatabase, TbFeatureExerciseHr> {
  $TbFeatureExerciseHrAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get exSn =>
      $composableBuilder(column: $table.exSn, builder: (column) => column);

  GeneratedColumn<String> get hrLst =>
      $composableBuilder(column: $table.hrLst, builder: (column) => column);

  GeneratedColumn<int> get stepSec =>
      $composableBuilder(column: $table.stepSec, builder: (column) => column);
}

class $TbFeatureExerciseHrTableManager
    extends
        RootTableManager<
          _$BodymindDatabase,
          TbFeatureExerciseHr,
          TbFeatureExerciseHrData,
          $TbFeatureExerciseHrFilterComposer,
          $TbFeatureExerciseHrOrderingComposer,
          $TbFeatureExerciseHrAnnotationComposer,
          $TbFeatureExerciseHrCreateCompanionBuilder,
          $TbFeatureExerciseHrUpdateCompanionBuilder,
          (
            TbFeatureExerciseHrData,
            BaseReferences<
              _$BodymindDatabase,
              TbFeatureExerciseHr,
              TbFeatureExerciseHrData
            >,
          ),
          TbFeatureExerciseHrData,
          PrefetchHooks Function()
        > {
  $TbFeatureExerciseHrTableManager(
    _$BodymindDatabase db,
    TbFeatureExerciseHr table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $TbFeatureExerciseHrFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $TbFeatureExerciseHrOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $TbFeatureExerciseHrAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> exSn = const Value.absent(),
                Value<String> hrLst = const Value.absent(),
                Value<int> stepSec = const Value.absent(),
              }) => TbFeatureExerciseHrCompanion(
                exSn: exSn,
                hrLst: hrLst,
                stepSec: stepSec,
              ),
          createCompanionCallback:
              ({
                Value<int> exSn = const Value.absent(),
                required String hrLst,
                required int stepSec,
              }) => TbFeatureExerciseHrCompanion.insert(
                exSn: exSn,
                hrLst: hrLst,
                stepSec: stepSec,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $TbFeatureExerciseHrProcessedTableManager =
    ProcessedTableManager<
      _$BodymindDatabase,
      TbFeatureExerciseHr,
      TbFeatureExerciseHrData,
      $TbFeatureExerciseHrFilterComposer,
      $TbFeatureExerciseHrOrderingComposer,
      $TbFeatureExerciseHrAnnotationComposer,
      $TbFeatureExerciseHrCreateCompanionBuilder,
      $TbFeatureExerciseHrUpdateCompanionBuilder,
      (
        TbFeatureExerciseHrData,
        BaseReferences<
          _$BodymindDatabase,
          TbFeatureExerciseHr,
          TbFeatureExerciseHrData
        >,
      ),
      TbFeatureExerciseHrData,
      PrefetchHooks Function()
    >;

class $BodymindDatabaseManager {
  final _$BodymindDatabase _db;
  $BodymindDatabaseManager(this._db);
  $TbOnboardStatusTableManager get tbOnboardStatus =>
      $TbOnboardStatusTableManager(_db, _db.tbOnboardStatus);
  $TbUserInfoTableManager get tbUserInfo =>
      $TbUserInfoTableManager(_db, _db.tbUserInfo);
  $TbDailyHrProxyInfoTableManager get tbDailyHrProxyInfo =>
      $TbDailyHrProxyInfoTableManager(_db, _db.tbDailyHrProxyInfo);
  $TbFeatureActInfoTableManager get tbFeatureActInfo =>
      $TbFeatureActInfoTableManager(_db, _db.tbFeatureActInfo);
  $TbFeatureHrInfoTableManager get tbFeatureHrInfo =>
      $TbFeatureHrInfoTableManager(_db, _db.tbFeatureHrInfo);
  $TbFeatureSleepInfoTableManager get tbFeatureSleepInfo =>
      $TbFeatureSleepInfoTableManager(_db, _db.tbFeatureSleepInfo);
  $TbFeatureSleepDetailTableManager get tbFeatureSleepDetail =>
      $TbFeatureSleepDetailTableManager(_db, _db.tbFeatureSleepDetail);
  $TbFeatureExerciseInfoTableManager get tbFeatureExerciseInfo =>
      $TbFeatureExerciseInfoTableManager(_db, _db.tbFeatureExerciseInfo);
  $TbFeatureExerciseHrTableManager get tbFeatureExerciseHr =>
      $TbFeatureExerciseHrTableManager(_db, _db.tbFeatureExerciseHr);
}

class SelectFeatureExerciseResult {
  final String baseDate;
  final int exSn;
  final int type;
  final String metricKind;
  final double metricVal;
  final double distance;
  final double calorie;
  final String startHhmm;
  final String endHhmm;
  final String? hrIdx;
  final String? hr;
  final int stepSec;
  SelectFeatureExerciseResult({
    required this.baseDate,
    required this.exSn,
    required this.type,
    required this.metricKind,
    required this.metricVal,
    required this.distance,
    required this.calorie,
    required this.startHhmm,
    required this.endHhmm,
    this.hrIdx,
    this.hr,
    required this.stepSec,
  });
}

class SelectFeatureSleepSegmentaionResult {
  final String baseDate;
  final String? startAt;
  final String? endAt;
  final String stage;
  final String segStart;
  final String segEnd;
  final int durationM;
  SelectFeatureSleepSegmentaionResult({
    required this.baseDate,
    this.startAt,
    this.endAt,
    required this.stage,
    required this.segStart,
    required this.segEnd,
    required this.durationM,
  });
}

class SelectFeatureSleepInfoResult {
  final String baseDate;
  final int? totalM;
  final int? awakeM;
  final int? lightM;
  final int? remM;
  final int? deepM;
  final int segmentCnt;
  SelectFeatureSleepInfoResult({
    required this.baseDate,
    this.totalM,
    this.awakeM,
    this.lightM,
    this.remM,
    this.deepM,
    required this.segmentCnt,
  });
}
