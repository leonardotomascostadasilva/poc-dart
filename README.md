A simple command-line application.
package: https://pub.dev/packages/azure_app_config/example

ex: https://github.com/iamwalter/azure_app_config/blob/develop/example/main.dart


## RFC: Introdução de Recursos e Melhorias para Interação com o Azure App Configuration

Resumo
O Azure App Configuration é um serviço de gerenciamento de configurações hospedado pela Microsoft Azure, permitindo que os desenvolvedores armazenem, gerenciem e distribuam configurações de aplicativos. Este RFC propõe melhorias e recursos adicionais para a interação com o Azure App Configuration, visando facilitar o uso e ampliar a funcionalidade da integração com o serviço.

### Motivação
Atualmente, a interação com o Azure App Configuration em Dart pode ser melhorada e expandida para fornecer uma experiência mais robusta e intuitiva para os desenvolvedores. As melhorias propostas visam simplificar a configuração, aumentar a flexibilidade na manipulação de recursos e fornecer mais informações úteis durante a interação com o serviço.

### Detalhes da Proposta
Adição de Documentação Detalhada: Será adicionada documentação detalhada sobre como configurar o Azure App Configuration, incluindo instruções passo a passo sobre como obter uma Connection String, criar e gerenciar chaves de configuração, e como utilizar os recursos do serviço.

**Melhoria na Manipulação de Exceções**: Será aprimorada a manipulação de exceções durante a interação com o serviço, fornecendo mensagens de erro mais descritivas e orientações sobre como resolver problemas comuns.

**Aprimoramento da Interface de Programação**: Serão introduzidos métodos e classes adicionais para facilitar tarefas comuns, como obtenção de configurações, verificação de recursos habilitados, filtragem de chaves de configuração, entre outros.
### Exemplo de Uso Aprimorado
Aqui está um exemplo de como a interação com o Azure App Configuration pode ser aprimorada usando as melhorias propostas:

```dart
import 'dart:developer' as developer;

import 'package:azure_app_config/azure_app_config.dart';

void main() async {
  const exampleKey = 'example_key';
  const exampleLabel = 'example_label';

  final service = AzureAppConfig(connectionString: '<CONNECTION_STRING>');

  late KeyValue keyValue;

  try {
    keyValue = await service.getKeyValue(key: exampleKey, label: exampleLabel);
  } catch (err) {
    developer.log('Error occurred while getting key value: $err');
  }

  developer.log(keyValue.value);

  final featureFlag = keyValue.asFeatureFlag();

  if (featureFlag != null) {
    developer.log('${featureFlag.enabled}');
  }

  try {
    service.registerFeatureFilter(
      FeatureFilter.targeting(
        user: 'test.user@company.com',
      ),
    );
    final isFeatureEnabled =
        await service.getFeatureEnabled(key: exampleKey, label: exampleLabel);

    developer.log('$isFeatureEnabled');
  } catch (err) {
    developer.log('Error occurred while checking if feature is enabled: $err');
  }

  try {
    final keyValues = await service.findKeyValuesBy(
      key: '.appconfig.*',
      label: AzureFilters.noLabel,
    );

    for (final keyValue in keyValues) {
      developer.log(keyValue.value);
    }

  } on AzureFilterValidationException catch (e) {
    developer.log(e.errorResponse.detail ?? 'Error occurred!');
  }
}

```
O codigo acima é fornecido no próprio link do pacote

### Considerações Finais
Essas melhorias propostas visam aprimorar a experiência do desenvolvedor ao interagir com o Azure App Configuration em Dart, tornando a integração mais fácil, flexível e informativa. Com essas mudanças, esperamos facilitar o desenvolvimento de aplicativos que utilizam o serviço Azure App Configuration e melhorar a eficiência e a confiabilidade das operações realizadas com ele.
