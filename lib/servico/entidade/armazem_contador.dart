import 'package:mobx/mobx.dart';
part 'armazem_contador.g.dart';

class CounterStore = CounterStoreBase with _$CounterStore;

abstract class CounterStoreBase with Store {
  @observable
  int contador = 0;

  @action
  void incrementar() {
    contador++;
  }

  @action
  void decrementar() {
    contador--;
  }
}
