import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
// 1. Import file ApiService kamu (sesuaikan nama folder/filenya)
import 'package:kaciru_desu/baka/api_hmm.dart';

class LoginPage extends StatefulWidget {
  // Benerin penulisan constructor (sebelumnya: const new({super.key}))
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscurePassword = true;

  // 2. Tambahkan Controller untuk membaca teks dari TextField
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 3. Status loading saat proses HTTP Request
  bool isLoading = false;

  // 4. Fungsi untuk memproses Login
  void handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Validasi sederhana di sisi Flutter
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password wajib diisi!')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Panggil fungsi login dari ApiService
      final result = await ApiService.login(email, password);

      setState(() => isLoading = false);

      if (result['success'] == true) {
        // Jika sukses dari Laravel
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Login Berhasil!'),
            backgroundColor: Colors.green,
          ),
        );

        // TODO: Simpan token jika diperlukan (misal: result['data']['access_token'])
        // Pindah ke halaman Home
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Jika gagal (Password salah, email tidak terdaftar, dll)
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Login Gagal!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal terhubung ke server: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget dihancurkan
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          "K A C I R U - D E S U ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 128),
                const Text(
                  "L O G I N",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                Column(
                  spacing: 10,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Email", style: TextStyle(fontSize: 18)),
                    ),
                    // Pasangkan controller email
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Masukkan Email',
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Password", style: TextStyle(fontSize: 18)),
                    ),
                    // Pasangkan controller password
                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Masukkan Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text("Forgot password ?"),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // Jika sedang loading, tombol di-disable, kalau tidak panggil handleLogin
                        onPressed: isLoading ? null : handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          foregroundColor: Colors.white,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "L O G I N",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                    const Text("or continue with"),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Icon(Icons.favorite),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Icon(Icons.favorite),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: const Icon(Icons.favorite),
                        ),
                      ],
                    ),
                    const SizedBox(height: 64),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Register', // Ubah teks jadi Register
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/register',
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}