
import 'package:hive/hive.dart';

class BudgetModel extends HiveObject {
  String id;
  String category;
  double limit;
  double spent;

  BudgetModel({required this.id, required this.category, required this.limit, this.spent = 0});
}

class BudgetModelAdapter extends TypeAdapter<BudgetModel> {
  @override
  final int typeId = 3;

  @override
  BudgetModel read(BinaryReader reader) {
    final n = reader.readByte();
    final f = <int, dynamic>{for (int i = 0; i < n; i++) reader.readByte(): reader.read()};
    return BudgetModel(id: f[0] as String, category: f[1] as String, limit: f[2] as double, spent: f[3] as double);
  }

  @override
  void write(BinaryWriter writer, BudgetModel obj) {
    writer..writeByte(4)..writeByte(0)..write(obj.id)..writeByte(1)..write(obj.category)..writeByte(2)..write(obj.limit)..writeByte(3)..write(obj.spent);
  }
}
