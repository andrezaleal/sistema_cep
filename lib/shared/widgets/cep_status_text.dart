import 'package:flutter/material.dart';
import 'package:via_cep_api/pages/ceps.dart';

class CepStatusDialog extends StatelessWidget {
  final bool isInDatabase;
  final TextEditingController cepController;

  const CepStatusDialog({super.key, required this.isInDatabase, required this.cepController});

  @override
  Widget build(BuildContext context) {
    String message = isInDatabase
        ? "O CEP já está no banco de dados. Deseja editá-lo?"
        : "O CEP não está no banco de dados. Deseja adicioná-lo?";

    return AlertDialog(
      title: const Text("Status do CEP"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Ceps()));
                cepController.clear();
                 //Navigator.of(context).pop();
          },
          child: const Text("Sim"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Não"),
        ),
      ],
    );
  }
}
