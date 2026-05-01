import 'package:mobx/mobx.dart';
part 'armazem_navegacao.g.dart';

class ArmazemNavegacao = ArmazemNavegacaoBase with _$ArmazemNavegacao;

abstract class ArmazemNavegacaoBase with Store {
  @observable
  int abaSelecionada = 0;

  @observable
  int categoriaSelecionada = 0;

  @action
  void selecionarAba(int indice) {
    abaSelecionada = indice;
  }

  @action
  void selecionarCategoria(int indice) {
    categoriaSelecionada = indice;
  }
}
