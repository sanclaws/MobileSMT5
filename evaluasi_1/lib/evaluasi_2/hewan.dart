class Hewan {
  double berat;

  Hewan(this.berat);

  void makan() {
    berat += 1;
  }

  void lari() {
    berat -= 0.5;
    if (berat < 0) berat = 0; // biar nggak minus
  }
}