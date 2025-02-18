# Flutter Chat Module

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Flutter uygulamalarınızda kolayca entegre edebileceğiniz modüler ve özelleştirilebilir bir chat (sohbet) modülüdür. 

## Özellikler

- **Kolay Entegrasyon:** Minimal konfigürasyonla uygulamanıza entegre edilebilir.
- **Özelleştirilebilir Tasarım:** Renk, yazı stili ve sohbet balonları gibi UI öğeleri kolayca özelleştirilebilir.


## Başlarken

Bu rehber, projenize chat modülünü nasıl ekleyeceğinizi ve kullanacağınızı anlatmaktadır.

### Gereksinimler

- Flutter SDK (>=1.17.0)
- Dart (>=3.6.1 <4.0.0)
- [Provider](https://pub.dev/packages/provider) paketi (State management için)

### Kurulum

1. **Pubspec.yaml** dosyanıza gerekli bağımlılıkları ekleyin:

   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     provider: ^6.1.2