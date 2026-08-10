
import 'package:hive/hive.dart';

class SavingsModel extends HiveObject {
  String id;
  String title;
  double target;
  double saved;
  DateTime? deadline;
  String icon;

  SavingsModel({required this.id, required this.title, required this.target, this.saved = 0, this.deadline, this.icon = '🎯'});
}

class SavingsModelAdapter extends TypeAdapter<SavingsModel> {
  @override
  final int typeId = 4;

  @override
  SavingsModel read(BinaryReader reader) {
    final n = reader.readByte();
    final f = <int, dynamic>{for (int i = 0; i < n; i++) reader.readByte(): reader.read()};
    return SavingsModel(id: f[0] as String, title: f[1] as String, target: f[2] as double, saved: f[3] as double, deadline: f[4] as DateTime?, icon: f[5] as String);
  }

  @override
  void write(BinaryWriter writer, SavingsModel obj) {
    writer..writeByte(6)..writeByte(0)..write(obj.id)..writeByte(1)..write(obj.title)..writeByte(2)..write(obj.target)..writeByte(3)..write(obj.saved)..writeByte(4)..write(obj.deadline)..writeByte(5)..write(obj.icon);
  }
}
