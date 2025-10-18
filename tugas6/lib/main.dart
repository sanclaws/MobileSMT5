import 'package:flutter/material.dart';

void main() {
  runApp(const FormMahasiswaApp());
}

class FormMahasiswaApp extends StatelessWidget {
  const FormMahasiswaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Data Mahasiswa',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _nimController = TextEditingController();
  final _noHpController = TextEditingController();
  String? _jenisKelamin;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Data dikirim ke halaman hasil
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HasilPage(
            nama: _namaController.text,
            nim: _nimController.text,
            email: _emailController.text,
            noHp: _noHpController.text,
            jenisKelamin: _jenisKelamin ?? '-',
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _nimController.dispose();
    _noHpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Mahasiswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  prefixIcon: Icon(Icons.confirmation_number),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM wajib diisi';
                  } else if (value.length < 5) {
                    return 'NIM minimal 5 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  } else if (!value.endsWith('@unsika.ac.id')) {
                    return 'Gunakan email dengan domain @unsika.ac.id';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _noHpController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP wajib diisi';
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Nomor HP hanya boleh berisi angka';
                  } else if (value.length < 10) {
                    return 'Nomor HP minimal 10 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Jenis Kelamin',
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(),
                ),
                value: _jenisKelamin,
                items: const [
                  DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                  DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                ],
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Pilih jenis kelamin' : null,
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Simpan'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HasilPage extends StatelessWidget {
  final String nama;
  final String nim;
  final String email;
  final String noHp;
  final String jenisKelamin;

  const HasilPage({
    super.key,
    required this.nama,
    required this.nim,
    required this.email,
    required this.noHp,
    required this.jenisKelamin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Mahasiswa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Nama Lengkap'),
                subtitle: Text(nama),
              ),
              ListTile(
                leading: const Icon(Icons.confirmation_number),
                title: const Text('NIM'),
                subtitle: Text(nim),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(email),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Nomor HP'),
                subtitle: Text(noHp),
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Jenis Kelamin'),
                subtitle: Text(jenisKelamin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
