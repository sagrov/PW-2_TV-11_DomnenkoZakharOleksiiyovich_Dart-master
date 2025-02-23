import 'dart:io';

double inputDoubleOr(String prompt, {double defaultDouble = 0.0}) {
  print(prompt);
  String input = stdin.readLineSync()!.trim();
  return double.parse(input);
}

Map<String, Map<String, double>> fuelStorage = {
  'coal': {
    'qri': 20.47,
    'avin': 0.8,
    'ar': 25.20,
    'gvin': 1.5,
  },
  'fuel_oil': {
    'qri': 40.40,
    'avin': 1.0,
    'ar': 0.15,
    'gvin': 0.0,
  },
  'natural_gas': {
    'qri': 33.08,
    'avin': 1.25,
    'ar': 0.0,
    'gvin': 0.0,
  },
};

List<double> calculateEmission(String fuelId, double value) {
  double qri = fuelStorage[fuelId]!['qri']!;
  double avin = fuelStorage[fuelId]!['avin']!;
  double ar = fuelStorage[fuelId]!['ar']!;
  double gvin = fuelStorage[fuelId]!['gvin']!;

  double ktv = (1e6 / qri) * avin * (ar / (100 - gvin)) * (1 - 0.985);
  double etv = 1e-6 * ktv * qri * value;

  return [ktv, etv].map((e) => double.parse(e.toStringAsFixed(2))).toList();
}

void main() {
  double coal = inputDoubleOr("Введіть кількість вугілля, т: ", defaultDouble: 412407.75);
  double fuelOil = inputDoubleOr("Введіть кількість мазуту, т: ", defaultDouble: 175657.21);
  double naturalGas = inputDoubleOr("Введіть кількість природнього газу, т: ", defaultDouble: 195337.23);

  var ktv1Etv1 = calculateEmission('coal', coal);
  print("Показник емісії твердих частинок при спалюванні вугілля становитиме: ${ktv1Etv1[0]} г/ГДж");
  print("Валовий викид при спалюванні вугілля становитиме: ${ktv1Etv1[1]} т");

  var ktv2Etv2 = calculateEmission('fuel_oil', fuelOil);
  print("Показник емісії твердих частинок при спалюванні мазуту становитиме: ${ktv2Etv2[0]} г/ГДж");
  print("Валовий викид при спалюванні мазуту становитиме: ${ktv2Etv2[1]} т");

  var ktv3Etv3 = calculateEmission('natural_gas', naturalGas);
  print("Показник емісії твердих частинок при спалюванні природнього газу становитиме: ${ktv3Etv3[0]} г/ГДж");
  print("Валовий викид при спалюванні природнього газу становитиме: ${ktv3Etv3[1]} т");
}