import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_app/src/presentation/notifiers/user_notifier.dart';
import 'package:rick_and_morty_app/src/presentation/providers/user_provider.dart';
import 'package:rick_and_morty_app/src/presentation/screen/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.watch(userProvider.notifier);

    if (userState.loginSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        userNotifier.setLoginSuccess(false);
      });
    }

    if (userState.loginError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(userState.loginError!)),
      );
    }

    return Scaffold(
      body: _LoginBody(userNotifier: userNotifier),
    );
  }
}

class _LoginBody extends StatefulWidget {
  final UserNotifier userNotifier;
  const _LoginBody({required this.userNotifier});

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _textFieldAnimationController;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _logoAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _textFieldAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _textFieldAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blueAccent, Colors.greenAccent],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeScaleTransition(
                animation: CurvedAnimation(
                  parent: _logoAnimationController,
                  curve: Curves.easeInOut,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset(
                    'assets/images/rick_logo.png',
                    scale: 2,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Bienvenido',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: FadeScaleTransition(
                  animation: CurvedAnimation(
                    parent: _textFieldAnimationController,
                    curve: Curves.easeInOut,
                  ),
                  child: TextFormField(
                    controller: controller,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Nombre de usuario',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    widget.userNotifier.setUser(controller.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Por favor ingrese un nombre')),
                    );
                  }
                },
                child: const Text('Ingresar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
