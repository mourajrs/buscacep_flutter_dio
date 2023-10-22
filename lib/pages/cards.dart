import 'package:buscacep/models/cep_list_model.dart';
import 'package:buscacep/repositories/cep_hive_repository.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({super.key});

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  List<CepListModel> results = [];
  late CepHiveRepository cepHiveRepository;

  @override
  void initState() {
    super.initState();
    initializeRepository();
  }

  Future<void> initializeRepository() async {
    cepHiveRepository = await CepHiveRepository.load();
    results = cepHiveRepository.obterDados();
    results.sort((a, b) => b.date!.compareTo(a.date!));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 190),
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 51, 51, 182),
              title: const Text(
                'Suas localizações',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final dateFormat = DateFormat('dd/MM/yyyy');
                  return Card(
                    child: ListTile(
                      title: Text('CEP: ${results[index].cep}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(results[index].addressName!),
                          Text("Cidade: ${results[index].city!} - ${results[index].state!}"),
                          Text("DDD: ${results[index].ddd}"),
                          Text("Busca realizada: ${dateFormat.format(results[index].date!)}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )));
  }
}
