import 'hewan.dart';

class Kucing extends Hewan {
  String warnaBulu;

  Kucing(String nama, double berat, this.warnaBulu) : super(nama, berat);

  @override
  String makan(double porsi) {
    super.makan(porsi);
    return "Kucing $nama sedang makan sebanyak $porsi gram.";
  }
}
