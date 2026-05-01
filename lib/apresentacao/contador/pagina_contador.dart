import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../servico/entidade/armazem_contador.dart';

class CounterPage extends StatelessWidget {
  final CounterStore _armazem = CounterStore();

  CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MobX — Teste'),
        backgroundColor: const Color(0xFFFFE600),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Contador', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Observer(
              builder: (_) {
                return Text(
                  '${_armazem.contador}',
                  style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                );
              },
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'dec',
                  onPressed: () {
                    _armazem.decrementar();
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 24),
                FloatingActionButton(
                  heroTag: 'inc',
                  onPressed: () {
                    _armazem.incrementar();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
