import 'dart:ui';
import 'package:flutter/material.dart';

class AppBG extends StatelessWidget {
  const AppBG({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            // Fundo cinza claro
            Container(
              color: const Color(0xFFD9D9D9),
            ),

            // Grupo de círculos centralizado
            LayoutBuilder(
              builder: (context, constraints) {
                final centerY = constraints.maxHeight / 2;
                final centerX = constraints.maxWidth / 2;

                return Stack(
                  children: [
                    // Círculo laranja (acima)
                    Positioned(
                      top: centerY - 230,
                      left: centerX - 120,
                      child: Container(
                        width: 500,
                        height: 500,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD49B79),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Círculo verde (meio)
                    Positioned(
                      top: centerY - 100,
                      left: centerX - 100,
                      child: Container(
                        width: 460,
                        height: 460,
                        decoration: const BoxDecoration(
                          color: Color(0xFF7E8970),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Círculo amarelo (embaixo)
                    Positioned(
                      top: centerY + 30,
                      left: centerX - 70,
                      child: Container(
                        width: 400,
                        height: 400,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8E5C7),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            // Camada de blur (vidro fosco)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 65, sigmaY: 65),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}