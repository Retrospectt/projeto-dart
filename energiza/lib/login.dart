import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:energiza/main.dart' as main;
import 'package:energiza/config_menu.dart' as config;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Stack(
        children: [
          Positioned(
            top: -15,
            right: -40,
            child: Transform.rotate(
              angle: -70 * 3.1415927 / 180,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/pngwing_1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'AbhayaLibre',
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Seja bem-vindo!',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 32.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'E-mail',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu e-mail';
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Por favor, insira um e-mail válido';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Senha',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira sua senha';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacementNamed(context, '/');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 16.0),
                        textStyle: const TextStyle(fontSize: 18.0),
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                            const Text('Lembre de mim'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Esqueceu a senha?',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    const Divider(thickness: 1.0),
                    const SizedBox(height: 16.0),
                    const Text('Não tenho uma conta'),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/google_logo.png'),
                        ),
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/facebook.png'),
                        ),
                        CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.white,
                          child: Image.asset('assets/apple_logo.png'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Não tem uma conta? ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: 'Cadastre-se',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                               
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
