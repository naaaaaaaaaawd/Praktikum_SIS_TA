/*
  Muhamad Ridwan Pratama
  162024015
  Tugas Akhir 4
*/

import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imagePathController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _imagePathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Produk Baru',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: const Color(0xFFFBF5F8),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  prefixIcon: Icon(Icons.coffee),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama produk tidak boleh kosong.';
                  }
                  if (value.length < 3) {
                    return 'Nama produk minimal 3 karakter.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  prefixIcon: Icon(Icons.money),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong.';
                  }
                  final price = int.tryParse(value);
                  if (price == null) {
                    return 'Masukkan harga dalam bentuk angka.';
                  }
                  if (price <= 0) {
                    return 'Harga harus lebih dari 0.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Singkat',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _imagePathController,
                decoration: const InputDecoration(
                  labelText: 'Path Aset Gambar',
                  prefixIcon: Icon(Icons.image),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Path gambar tidak boleh kosong.';
                  }
                  if (!value.startsWith('assets/')) {
                    return "Path harus dimulai dengan 'assets/'.";
                  }
                  if (!value.endsWith('.png') &&
                      !value.endsWith('.jpg') &&
                      !value.endsWith('.jpeg')) {
                    return 'Path harus berupa file gambar (.png, .jpg).';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF2ECEF),
                    foregroundColor: const Color(0xFF5E548E),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form berhasil divalidasi'),
                        ),
                      );
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}