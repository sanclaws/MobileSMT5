import 'package:flutter/material.dart';

void main() => runApp(
  const MyApp(),
); //ini pakai tanda sama dengan lebih besar karena untuk cuma shortcut kalau isi fungsi hanya 1 baris.

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Halaman Formulir',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const FormMahasiswaPage(),
  );
}

class FormMahasiswaPage extends StatefulWidget {
  const FormMahasiswaPage({super.key});
  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final cNama = TextEditingController();
  final cNPM = TextEditingController();
  final cEmail = TextEditingController();
  final cAlamat = TextEditingController();

  //boleh null
  DateTime?
  tglLahir; //tanda tanya buat null tipedata Datetime boleh null (null bakal nampilin tanda ?)
  TimeOfDay? jamBimbingan;

  String get tglLahirLabel =>
      tglLahir ==
          null //getter tujuannya mempermudah pengambilan nilai atau sebuah variabel
      ? 'Pilih Tanggal Lahir' //penulisan lain dari ifelse: primary pengganti ifelse
      : '${tglLahir!.day}/${tglLahir!.month}/${tglLahir!.year}'; //kalau false dia bakal nampilin ini
  String get jamLabel => jamBimbingan == null
      ? 'Pilih Jam Bimbingan'
      : '${jamBimbingan!.hour}:${jamBimbingan!.minute}';

  @override
  void dispose() {
    cNama.dispose();
    cNPM.dispose();
    cEmail.dispose();
    cAlamat.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final res = await showDatePicker(
      context: context,
      firstDate: DateTime(2004),
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (res != null) setState(() => tglLahir = res); //ngecek res nya ada isinya apa ngga, kalau ada dia bakal nampilin setState dan res
  }

  Future<void> _pickTime() async { //function async dipake proses punya waktu lebih lama untuk prosesnya berjalan tanpa mengganggu baris utama tsb dan proses nya cukup berat cth: akses database, data internet) kalau ga pake async programnya bakal macet
    final res = await showTimePicker( //await buat nunggu proses showTimePicker selesai baru lanjut ke proses berikutnya
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (res != null) setState(() => jamBimbingan = res);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate() ||
    tglLahir == null ||
    jamBimbingan == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar (content: Text('Data belum lengkap!')));
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data'),
        content: Text(
          'Nama: ${cNama.text}\nNPM: ${cNPM.text}\nEmail: ${cEmail.text}\nAlamat: ${cAlamat.text}\nTanggal Lahir: $tglLahirLabel\nJam Bimbingan: $jamLabel',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Formulir Mahasiswa')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: cNama,
              decoration: const InputDecoration(labelText: 'Nama'),
              validator: (value) =>
              value == null || value.isEmpty ? 'Nama harus diisi' : null,
            ),
            TextFormField(
              controller: cNPM,
              decoration: const InputDecoration(labelText: 'NPM'),
              keyboardType: TextInputType.number,
              validator: (value) =>
              value == null || value.isEmpty ? 'NPM harus diisi' : null,
            ),
            TextFormField(
              controller: cEmail,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email harus diisi';
                final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                return ok ? null : 'Format email salah';
              },
            ),
            TextFormField(
              controller: cAlamat,
              decoration: const InputDecoration(labelText: 'Alamat'),
              maxLines: 3,
              validator: (value) =>
              value == null || value.isEmpty ? 'Alamat harus diisi' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickDate,
              child: Text(tglLahirLabel),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickTime,
              child: Text(jamLabel),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _simpan,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    ),
  );
}
