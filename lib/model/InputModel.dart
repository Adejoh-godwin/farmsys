class Input {
  final int id;
  final String name;
  final String phone;
  final String fnpk;
  final String furea;
  final String forganic;
  final String micronutrient;
  final String knapsack;
  final String insecticide;
  final String hlagon;
  final String hnsco;
  static const String TABLENAME = "farmers";

  Input({
    this.fnpk,
    this.furea,
    this.forganic,
    this.micronutrient,
    this.knapsack,
    this.insecticide,
    this.hlagon,
    this.hnsco,
    this.id,
    this.name,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'fnpk': fnpk,
      'furea': furea,
      'forganic': forganic,
      'knapsack': knapsack,
      'micronutrient': micronutrient,
      'insecticide': insecticide,
      'hlagon': hlagon,
      'hnsco': hnsco
    };
  }
}
