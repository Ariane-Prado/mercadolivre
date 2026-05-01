# Mercado Livre — Clone UI

Projeto Flutter que replica a interface da tela inicial do Mercado Livre.

## Funcionalidades

- Cabeçalho com barra de busca, avatar e notificações
- Abas de categorias com seleção reativa
- Carrossel de banners com troca automática a cada 3 segundos
- Barra Meli+
- Seção de acesso rápido horizontal
- Ofertas relâmpago com temporizador regressivo em tempo real
- Grade de produtos com suporte a desconto, vídeo e badge de oferta
- Navegação inferior com troca de aba

## Tecnologias

- Flutter
- MobX + flutter_mobx (gerenciamento de estado)
- build_runner + mobx_codegen (geração de código)

## Como rodar

```bash
flutter pub get
dart run build_runner build
flutter run
```
