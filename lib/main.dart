import 'package:buscacep/busca_cep.dart';
import 'package:buscacep/models/cep_list_model.dart';
import 'package:buscacep/repositories/cep_hive_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(CepListModelAdapter());
  await CepHiveRepository.load();
  runApp(const BuscaCep());
}
