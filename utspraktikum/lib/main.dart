import 'package:flutter/material.dart';

void main() {
  runApp(const SimpleNotesApp());
}

class Note {
  final String title;
  final String content;
  final DateTime date;

  Note({
    required this.title,
    required this.content,
    required this.date,
  });
}

class SimpleNotesApp extends StatefulWidget {
  const SimpleNotesApp({super.key});

  @override
  State<SimpleNotesApp> createState() => _SimpleNotesAppState();
}

class _SimpleNotesAppState extends State<SimpleNotesApp> {
  int _selectedIndex = 0;
  final List<Note> _notes = [
    Note(
      title: "Belajar Flutter",
      content: "Menyelesaikan tugas UTS Pemrograman Perangkat Bergerak.",
      date: DateTime.now(),
    ),
    Note(
      title: "Beli Bahan Presentasi",
      content: "Cari template PowerPoint yang bagus dan latihan bicara.",
      date: DateTime.now(),
    ),
  ];

  void _addNote(Note note) {
    setState(() {
      _notes.add(note);
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      NotesListPage(notes: _notes),
      AddNotePage(onAdd: _addNote),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Catatan Sederhana',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Catatan Sederhana"),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.indigo,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: "Catatan",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Tambah",
            ),
          ],
        ),
      ),
    );
  }
}

class NotesListPage extends StatelessWidget {
  final List<Note> notes;
  const NotesListPage({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    return notes.isEmpty
        ? const Center(child: Text("Belum ada catatan."))
        : ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.book, color: Colors.indigo),
                  title: Text(
                    note.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${note.content}\n${note.date.toLocal()}".split('.')[0],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fitur hapus belum tersedia")),
                      );
                    },
                  ),
                ),
              );
            },
          );
  }
}

class AddNotePage extends StatefulWidget {
  final Function(Note) onAdd;
  const AddNotePage({super.key, required this.onAdd});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newNote = Note(
        title: _titleController.text,
        content: _contentController.text,
        date: DateTime.now(),
      );
      widget.onAdd(newNote);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Catatan berhasil ditambahkan!")),
      );
      _titleController.clear();
      _contentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Judul Catatan",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Judul tidak boleh kosong";
                } else if (value.length < 3) {
                  return "Judul minimal 3 karakter";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: "Isi Catatan",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Isi catatan tidak boleh kosong";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.save),
              label: const Text("Simpan Catatan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
