/*
  Muhamad Ridwan Pratama
  162024015
  Tugas Akhir 4
*/

import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'register_page.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6D05FA), Color(0xFF298089)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/login.png',
                    height: 350,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),

                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "Masukkan email dan password Anda untuk melanjutkan",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Contoh: Namakamu@gmail.com',
                                prefixIcon: Icon(Icons.email_outlined), 
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email tidak boleh kosong';
                                }
                                final emailPattern = RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+$',
                                );
                                if (!emailPattern.hasMatch(value)) {
                                  return 'Format email tidak valid';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock_outlined), 
                                border: OutlineInputBorder(), 
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password tidak boleh kosong';
                                }
                                if (value.length < 6) {
                                  return 'Password minimal 6 karakter';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),

                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF298089),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                      // Cek apakah semua inputan (email & password) valid
                                      if (_formKey.currentState!.validate()) {
                                        
                                        // Opsional: Tampilkan SnackBar sukses sebentar
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Login Berhasil!'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const MainScreen(),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Masuk',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                            const SizedBox(height: 16),

                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Belum punya akun? :) Daftar di sini',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}