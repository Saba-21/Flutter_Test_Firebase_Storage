import 'package:hive/hive.dart';

part 'test_model.g.dart';

@HiveType(typeId: 1)
class TestModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final double weight;
  @HiveField(3)
  final String id;

  TestModel(this.name, this.age, this.weight, this.id);
}
