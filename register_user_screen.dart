import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../color.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: myCustomColor,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nama input
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nama",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF8348)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myCustomColor),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Email input
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF8348)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myCustomColor),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Pilih foto profil
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  Text(
                    _profileImage != null
                        ? "Foto profil dipilih"
                        : "Belum memilih foto",
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                  await _pickFile(context);
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: myCustomColor,
                  ),
                  child: Text("Pilih Foto", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Tombol Daftar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: myCustomColor,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Akun Anda Telah Terdaftar')),
                );
              },
              child: Text("Daftar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','png','jpeg'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null && (!filePath.endsWith('.jpg') || !filePath.endsWith('png') || !filePath.endsWith('jpeg'))) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hanya file dengan ekstensi .jpg, .png, atau .jpeg yang diperbolehkan!')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File path: $filePath')),
      );
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected')),
      );
    }
  }
}
