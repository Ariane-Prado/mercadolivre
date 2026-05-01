import 'package:mobx/mobx.dart';
part 'armazem_ofertas_relampago.g.dart';

class ArmazemOfertasRelampago = ArmazemOfertasRelampagoBase with _$ArmazemOfertasRelampago;

abstract class ArmazemOfertasRelampagoBase with Store {
  @observable
  int segundos = 6599;

  @action
  void diminuirUmSegundo() {
    if (segundos > 0) {
      segundos = segundos - 1;
    }
  }
}
