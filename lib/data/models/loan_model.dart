
import 'package:hive/hive.dart';

class LoanModel extends HiveObject {
  String id;
  String friendId;
  double amount;
  String type; // lent or borrowed
  DateTime date;
  DateTime? dueDate;
  String status; // pending, paid
  String note;

  LoanModel({
    required this.id,
    required this.friendId,
    required this.amount,
    required this.type,
    required this.date,
    this.dueDate,
    required this.status,
    required this.note,
  });
}

class LoanModelAdapter extends TypeAdapter<LoanModel> {
  @override
  final int typeId = 2;

  @override
  LoanModel read(BinaryReader reader) {
    final num = reader.readByte();
    final fields = <int, dynamic>{for (int i = 0; i < num; i++) reader.readByte(): reader.read()};
    return LoanModel(
      id: fields[0] as String,
      friendId: fields[1] as String,
      amount: fields[2] as double,
      type: fields[3] as String,
      date: fields[4] as DateTime,
      dueDate: fields[5] as DateTime?,
      status: fields[6] as String,
      note: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LoanModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)..write(obj.id)
      ..writeByte(1)..write(obj.friendId)
      ..writeByte(2)..write(obj.amount)
      ..writeByte(3)..write(obj.type)
      ..writeByte(4)..write(obj.date)
      ..writeByte(5)..write(obj.dueDate)
      ..writeByte(6)..write(obj.status)
      ..writeByte(7)..write(obj.note);
  }
}
