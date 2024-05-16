class ConfigurationValue {
  final dynamic value;

  ConfigurationValue(this.value);
}

class MockAzureAppConfig {
  final String connectionString;

  MockAzureAppConfig({required this.connectionString});

  Future<ConfigurationValue> getConfiguration(
      {String? key, String? label}) async {
    final value = {"result": "meu valor", "label": label};
    return ConfigurationValue(value);
  }
}

void main() async {
  const exampleKey = 'example_key';
  const exampleLabel = 'example_label';

  final service = MockAzureAppConfig(connectionString: '<CONNECTION_STRING>');

  try {
    final keyValue =
        await service.getConfiguration(key: exampleKey, label: exampleLabel);
    final value = keyValue.value;
    print('Configuração: $value');
  } catch (err) {
    print("Error");
  }
}
