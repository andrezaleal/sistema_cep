import 'package:flutter/material.dart';
import 'package:via_cep_api/model/cep_api_model.dart';
import 'package:via_cep_api/repositories/cep_api_repository.dart';
import 'package:via_cep_api/shared/widgets/modal_add_edit_cep.dart';

class Ceps extends StatefulWidget {
  const Ceps({super.key});

  @override
  State<Ceps> createState() => _CepsState();
}

class _CepsState extends State<Ceps> {
  CepApiRepository cepApiRepository = CepApiRepository();
  var _cepApiModel = CepApiModel([]);
  var cepContoller = TextEditingController();
  var ufContoller = TextEditingController();
  var logradouroContoller = TextEditingController();
  var cidadeController = TextEditingController();
  var carregando = false;

  @override
  void initState() {
    super.initState();
    obterCeps();
  }

  void obterCeps() async {
    setState(() {
      carregando = true;
    });
    _cepApiModel = await cepApiRepository.readCEP();
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ceps"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              carregando
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                          itemCount: _cepApiModel.cep.length,
                          itemBuilder: (BuildContext bc, int index) {
                            var ceps = _cepApiModel.cep[index];
                            return Dismissible(
                              onDismissed:
                                  (DismissDirection dismissDirection) async {
                                await cepApiRepository.delete(ceps.objectId);
                                obterCeps();
                              },
                              key: Key(ceps.cep),
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                elevation: 8,
                                shadowColor: Colors.grey,
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Text("Cep: ${ceps.cep}"),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text("Logradouro: ${ceps.logradouro}"),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Cidade: ${ceps.cidade}"),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text("UF: ${ceps.estado}"),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          cepContoller.text = ceps.cep;
                                          logradouroContoller.text =
                                              ceps.logradouro;
                                          ufContoller.text = ceps.estado;
                                          cidadeController.text = ceps.cidade;
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext bc) {
                                                return ModalAddOrEditCep(
                                                  cepContoller: cepContoller,
                                                  logradouroContoller:
                                                      logradouroContoller,
                                                  ufContoller: ufContoller,
                                                  cidadeController:
                                                      cidadeController,
                                                  onAdd: () async {
                                                    ceps.cep =
                                                        cepContoller.text;
                                                    ceps.cidade =
                                                        cidadeController.text;
                                                    ceps.estado =
                                                        ufContoller.text;
                                                    ceps.logradouro =
                                                        logradouroContoller
                                                            .text;
                                                    await cepApiRepository
                                                        .update(ceps);
                                                    Navigator.pop(context);
                                                    obterCeps();
                                                    setState(() {});
                                                  },
                                                );
                                              });
                                        },
                                        label: const Text("Editar"),
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 10,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(0,
                                              25), // Ajuste a altura desejada
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            cepContoller.text = "";
            logradouroContoller.text = "";
            ufContoller.text = "";
            cidadeController.text = "";
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return ModalAddOrEditCep(
                    cepContoller: cepContoller,
                    logradouroContoller: logradouroContoller,
                    ufContoller: ufContoller,
                    cidadeController: cidadeController,
                    onAdd: () async {
                      await cepApiRepository.create(CEPModel.criar(
                          cepContoller.text,
                          ufContoller.text,
                          logradouroContoller.text,
                          cidadeController.text));
                      Navigator.pop(context);
                      obterCeps();
                      setState(() {});
                    },
                  );
                });
          },
        ),
      ),
    );
  }
}
