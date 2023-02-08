// pagina onde o guest adiciona a proposta com:
// - depositório de imagem /video
// - titulo
// - descrição da proposta
// - categoria da proposta

// paulo / joão
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class IdeaAddPage extends StatefulWidget {
  const IdeaAddPage({super.key});
  @override
  State<IdeaAddPage> createState() => _IdeaAddPageState();
}

const List<String> dropdownlist = <String>[
  "Male",
  "Female",
  "Other",
];

class _IdeaAddPageState extends State<IdeaAddPage> {
  String dropdownvalue = dropdownlist.first;
  final List<TextEditingController> _controllers =
      List.generate(2, (i) => TextEditingController());
  var listaTexto = [
    "Titulo",
    "Descrição da Proposta",
  ];

  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'images/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    setState(() {
      uploadTask = null;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.black,
                  ),
                  Center(
                    child: Text(
                      "${(100 * progress).roundToDouble()}%",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 50,
            );
          }
        },
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pickedFile != null)
              Expanded(
                child: SafeArea(
                  child: Container(
                    color: Colors.grey,
                    child: Center(
                      child: Text(
                        pickedFile!.name,
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: selectFile,
                child: const Text(
                  "Selecione Ficheiro",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: uploadFile,
                child: const Text(
                  "Upload Ficheiro",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            buildProgress(),
            TextField(
              controller: _controllers[0],
              decoration: InputDecoration(
                labelText: 'Titulo',
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                suffix: IconButton(
                  onPressed: () {
                    _controllers[0].clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _controllers[1],
              decoration: InputDecoration(
                labelText: 'Descrição',
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                suffix: IconButton(
                  onPressed: () {
                    _controllers[1].clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: const Alignment(
                -1,
                1,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: dropdownvalue,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  icon: const Icon(
                    Icons.expand_more,
                    color: Colors.blue,
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownvalue = value!;
                    });
                  },
                  items: dropdownlist
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
