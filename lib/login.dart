import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;

      // Aqui você pode adicionar a lógica de autenticação
      print('Email: $email, Password: $password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size.infinite, // Ocupa todo o espaço disponível
            painter: SemiCirclePainter(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                      'ESCREVA SEUS DADOS PARA ENTRAR',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                    const SizedBox(height: 32.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 2.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Por favor, insira um email válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 2.0,
                          ),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                 style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 19, 20, 20),
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 18), // Tamanho do botão
              textStyle: const TextStyle(
                fontSize: 24.0, // Tamanho do texto
                fontWeight: FontWeight.bold, // Peso do texto
              ),
            ),
                child: const Text('ENTRAR'),
              ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30, // Ajusta a posição vertical da imagem
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                '/home/lloures/login/lib/assets/logo.png', // Substitua pelo caminho da sua imagem
                height: 70.0, // Ajuste o tamanho da imagem conforme necessário
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SemiCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    double semiCircleHeight = size.height * 0.2; // Ajusta a altura do semicírculo

    // Semicírculo superior
    final topRect = Rect.fromLTWH(0, -semiCircleHeight, size.width, semiCircleHeight * 2);
    canvas.drawArc(
      topRect,
      0,
      3.14,
      true,
      paint,
    );

    // Semicírculo inferior
    final bottomRect = Rect.fromLTWH(0, size.height - semiCircleHeight, size.width, semiCircleHeight * 2);
    canvas.drawArc(
      bottomRect,
      3.14,
      3.14,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
