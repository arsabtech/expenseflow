
import 'package:hive/hive.dart';

class FriendModel extends HiveObject {
  String id;
  String name;
  String phone;
  double totalLent;
  double totalBorrowed;

  FriendModel({
    required this.id,
    required this.name,
    required this.phone,
    this.totalLent = 0,
    this.totalBorrowed = 0,
  });
}

class FriendModelAdapter extends TypeAdapter<FriendModel> {
  @override
  final int typeId = 1;

  @override
  FriendModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read()};
    return FriendModel(
      id: fields[0] as String,
      name: fields[1] as String,
      phone: fields[2] as String,
      totalLent: fields[3] as double,
      totalBorrowed: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FriendModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)..write(obj.id)
      ..writeByte(1)..write(obj.name)
      ..writeByte(2)..write(obj.phone)
      ..writeByte(3)..write(obj.totalLent)
      ..writeByte(4)..write(obj.totalBorrowed);
  }
}
