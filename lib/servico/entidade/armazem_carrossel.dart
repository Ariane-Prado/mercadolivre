import 'package:mobx/mobx.dart';
part 'armazem_carrossel.g.dart';

class ArmazemCarrossel = ArmazemCarrosselBase with _$ArmazemCarrossel;

abstract class ArmazemCarrosselBase with Store {
  @observable
  int paginaAtual = 0;

  @action
  void mudarPagina(int novaPagina) {
    paginaAtual = novaPagina;
  }

  @action
  void irParaProximaPagina(int totalBanners) {
    int proxima = paginaAtual + 1;

    if (proxima >= totalBanners) {
      proxima = 0;
    }

    paginaAtual = proxima;
  }
}
