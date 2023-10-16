// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:via_cep_api/model/cep_api_model.dart';
import 'package:via_cep_api/model/via_cep_model.dart';
import 'package:via_cep_api/repositories/cep_api_repository.dart';
import 'package:via_cep_api/repositories/via_cep_repository.dart';
import 'package:via_cep_api/shared/widgets/cep_status_text.dart';
import 'package:via_cep_api/shared/widgets/menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viacepModel = ViaCEPModel();
  var viaCepRepository = ViaCepRepository();
  var cepApiRepository = CepApiRepository();
  var isExistCep = false;

  Future<void> checkCepInDatabase(String cep) async {
    CepApiModel result = await cepApiRepository.isCepInDatabase(cep);

    if (result.cep.isNotEmpty) {
      isExistCep = true;
    } else {
      isExistCep = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Menu(),
        appBar: AppBar(
          title: const Text("Buscador de CEP"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text(
                "Consulta CEP",
                style: TextStyle(fontSize: 16),
              ),
              TextField(
                controller: cepController,
                keyboardType: TextInputType.number,
                onChanged: (String value) async {
                  var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                  if (cep.length == 8) {
                    setState(() {
                      loading = true;
                    });
                    viacepModel = await viaCepRepository.consultarCep(cep);
                    viacepModel.localidade ?? "";
                    viacepModel.uf ?? "";
                    viacepModel.logradouro ?? "";
                  } else {
                    setState(() {
                      viacepModel = ViaCEPModel();
                    });
                  }
                  setState(() {
                    loading = false;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                viacepModel.logradouro ?? "",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}",
                style: const TextStyle(fontSize: 16),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () async {
                    String cep = cepController.text;
                    await checkCepInDatabase(cep);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CepStatusDialog(isInDatabase: isExistCep, cepController: cepController,);
                      },
                    );
                  },
                  child: const Text('Verificar CEP no Banco de Dados'),
                ),
              ),
              Visibility(
                  visible: loading,
                  child: const Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
      
      ),
    );
  }
}
