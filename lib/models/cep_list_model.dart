import 'package:hive/hive.dart';
part 'cep_list_model.g.dart';

@HiveType(typeId: 0)
class CepListModel extends HiveObject {
  @HiveField(0)
  String cep = "";
  @HiveField(1)
  String? addressName;
  @HiveField(2)
  String? district;
  @HiveField(3)
  String? city;
  @HiveField(4)
  String? state;
  @HiveField(5)
  String? ddd;
  @HiveField(6)
  DateTime? date = DateTime.now();

  CepListModel();

  CepListModel.vazio() {
    cep = "";
    addressName = "";
    district = "";
    city = "";
    state = "";
    ddd = "";
    date = DateTime.now();
  }

  CepListModel.create(this.cep, this.addressName, this.district, this.city, this.state, this.ddd, this.date);
}
