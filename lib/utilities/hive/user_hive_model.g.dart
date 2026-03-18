// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHiveModelAdapter extends TypeAdapter<UserHiveModel> {
  @override
  final int typeId = 1;

  @override
  UserHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHiveModel(
      userId: fields[0] as String,
      email: fields[1] as String,
      userName: fields[2] as String,
      subscriptionId: fields[3] as int,
      subscriptionInTokenAllowed: fields[4] as int,
      subscriptionOutTokenAllowed: fields[5] as int,
      userInToken: fields[6] as int,
      userOutToken: fields[7] as int,
      token: fields[8] as String? ?? '',
      subscriptionFriendlyName: fields[9] as String? ?? '', imageUrl: '', create_at: fields[11] as DateTime? ?? null,
    );
  }

  @override
  void write(BinaryWriter writer, UserHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.subscriptionId)
      ..writeByte(4)
      ..write(obj.subscriptionInTokenAllowed)
      ..writeByte(5)
      ..write(obj.subscriptionOutTokenAllowed)
      ..writeByte(6)
      ..write(obj.userInToken)
      ..writeByte(7)
      ..write(obj.userOutToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
