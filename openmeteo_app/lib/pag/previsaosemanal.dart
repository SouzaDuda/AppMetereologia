import 'package:flutter/material.dart';
import 'package:openmeteo_app/pag/background.dart';

class Previsaosemanal extends StatelessWidget {
  const Previsaosemanal ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBG(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botão voltar
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
                    "Previsão do tempo para 7 dias",
                    style: TextStyle(
                      color: Color.fromARGB(255, 78, 73, 73),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Caixas de previsão
                  Expanded(
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7E8970),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
