import 'package:buscacep/models/cep_list_model.dart';
import 'package:buscacep/models/cep_model.dart';
import 'package:buscacep/pages/cards.dart';
import 'package:buscacep/repositories/cep_hive_repository.dart';
import 'package:buscacep/repositories/cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EnterPage extends StatefulWidget {
  const EnterPage({super.key});

  @override
  State<EnterPage> createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  var result = <CepListModel>[];
  late CepHiveRepository cepHiveRepository;
  var cepListModel = CepListModel.vazio();
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var cepModel = CepModel();
  var cepRepository = CepRepository();

  List<CepListModel> results = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterDados();
  }

  void obterDados() async {
    cepHiveRepository = await CepHiveRepository.load();
    final dados = cepHiveRepository.obterDados();
    if (dados.isNotEmpty) {
      setState(() {
        cepListModel = dados.first;
        cepController.text = cepListModel.cep;
      });
    }
    setState(() {
      cepController.text = "";
    });
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
                'Localiza ai!',
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 160.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: Column(children: [
                  Text(
                    "Ta confuso? Se Localiza, Qual seu CEP?",
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: cepController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Digite o CEP',
                      hintText: 'Ex: 01001000',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    autofocus: true,
                    onPressed: () async {
                      var cep = cepController.text.trim();
                      cepController.text = cep.replaceAll(RegExp(r'[^0-9]'), "");
                      if (cepController.text == 8 && cepController.text != null) {
                        setState(() {
                          loading = true;
                        });
                        cepModel = await cepRepository.consultar(cep);
                        setState(() {
                          loading = false;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("CEP não encontrado"),
                          ),
                        );
                      }

                      final result = CepListModel.create(
                        cepModel.cep ?? "",
                        cepModel.logradouro,
                        cepModel.bairro,
                        cepModel.localidade,
                        cepModel.uf,
                        cepModel.ddd,
                        cepListModel.date,
                      );

                      await cepHiveRepository.save(result);

                      results.add(result);

                      setState(() {
                        cepController.text = "";
                      });

                      Future.delayed(const Duration(milliseconds: 2), () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressCard()));
                      });
                    },
                    child: const Text('Buscar'),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Future.delayed(const Duration(milliseconds: 2), () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressCard()));
                        });
                      },
                      child: const Text("Suas localizações")),
                ]),
              ),
            )));
  }
}
