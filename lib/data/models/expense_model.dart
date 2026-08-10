
import 'package:hive/hive.dart';

class ExpenseModel extends HiveObject {
  String id;
  double amount;
  String category;
  String note;
  DateTime date;
  String paymentMethod;
  String type; // expense or income
  String? receiptPath;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.note,
    required this.date,
    required this.paymentMethod,
    required this.type,
    this.receiptPath,
  });
}

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 0;

  @override
  ExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read()};
    return ExpenseModel(
      id: fields[0] as String,
      amount: fields[1] as double,
      category: fields[2] as String,
      note: fields[3] as String,
      date: fields[4] as DateTime,
      paymentMethod: fields[5] as String,
      type: fields[6] as String,
      receiptPath: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)..write(obj.id)
      ..writeByte(1)..write(obj.amount)
      ..writeByte(2)..write(obj.category)
      ..writeByte(3)..write(obj.note)
      ..writeByte(4)..write(obj.date)
      ..writeByte(5)..write(obj.paymentMethod)
      ..writeByte(6)..write(obj.type)
      ..writeByte(7)..write(obj.receiptPath);
  }
}
