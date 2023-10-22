import 'package:buscacep/models/cep_list_model.dart';
import 'package:hive/hive.dart';

class CepHiveRepository {
  static late Box _box;
  final keyCepListModel = "key_cepListModel";

  CepHiveRepository._create();

  static Future<CepHiveRepository> load() async {
    if (Hive.isBoxOpen("key_cepListModel")) {
      _box = Hive.box("key_cepListModel");
    } else {
      _box = await Hive.openBox("key_cepListModel");
    }

    return CepHiveRepository._create();
  }

  save(CepListModel cepListModel) {
    _box.add(cepListModel);
  }

  List<CepListModel> obterDados() {
    return _box.values.cast<CepListModel>().toList();
  }
}
