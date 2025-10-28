import 'package:flutter/material.dart';
import 'package:openmeteo_app/pag/background.dart';
import 'package:openmeteo_app/api/creditos_api.dart';

class Creditos extends StatelessWidget {
  const Creditos({super.key});

  @override
  Widget build(BuildContext context) {
    final api = openMeteoInfo;

    return Scaffold(
      body: Stack(
        children: [
          const AppBG(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Row(
                        children: [
                          Icon(Icons.arrow_back, color: Color.fromARGB(255, 78, 73, 73)),
                          SizedBox(width: 5),
                          Text("VOLTAR",
                              style: TextStyle(color: Color.fromARGB(255, 78, 73, 73))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Créditos da API",
                      style: TextStyle(
                        color: Color.fromARGB(255, 78, 73, 73),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Nome da API: ${api.nome}",
                      style: const TextStyle(color: Color.fromARGB(255, 78, 73, 73), fontSize: 16),
                    ),
                    Text(
                      "Documentação: ${api.urlDocumentacao}",
                      style: const TextStyle(color: Color.fromARGB(255, 78, 73, 73), fontSize: 16),
                    ),
                    Text(
                      "URL de Acesso: ${api.urlAcesso}",
                      style: const TextStyle(color: Color.fromARGB(255, 78, 73, 73), fontSize: 16),
                    ),
                    Text(
                      "Autenticação: ${api.autenticacao}",
                      style: const TextStyle(color: Color.fromARGB(255, 78, 73, 73), fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Métodos Disponíveis:",
                      style: TextStyle(
                          color: Color.fromARGB(255, 78, 73, 73),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    ...api.metodos
                        .map((m) => Text("- $m",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 78, 73, 73), fontSize: 16)))
                        .toList(),
                    const SizedBox(height: 20),
                    const Text(
                      "Atributos:",
                      style: TextStyle(
                          color: Color.fromARGB(255, 78, 73, 73),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    ...api.atributos.entries.map(
                      (e) => Text("${e.key}: ${e.value}",
                          style: const TextStyle(color: Color.fromARGB(255, 78, 73, 73),)),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Dados Retornados:",
                      style: TextStyle(
                          color: Color.fromARGB(255, 78, 73, 73),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    ...api.dadosRetornados.entries.map(
                      (e) => Text("${e.key}: ${e.value}",
                          style: const TextStyle(color: Color.fromARGB(255, 78, 73, 73))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

