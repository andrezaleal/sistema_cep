import 'package:flutter/material.dart';

class ModalAddOrEditCep extends StatelessWidget {
  final TextEditingController cepContoller;
  final TextEditingController logradouroContoller;
  final TextEditingController ufContoller;
  final TextEditingController cidadeController;
  final Function  onAdd;


  const ModalAddOrEditCep({
    super.key,
    required this.cepContoller,
    required this.logradouroContoller,
    required this.ufContoller,
    required this.cidadeController,
    required this.onAdd

  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: const Text("Adicionar CEP"),
        content: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Cep"),
              controller: cepContoller,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Logradouro"),
              controller: logradouroContoller,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Estado"),
              controller: ufContoller,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Cidade"),
              controller: cidadeController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              onAdd();
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }
}
