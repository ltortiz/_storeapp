import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(child: Text('Hello World!')),
      body: Column(
        children: [HeaderLoginWidget(), BodyLoginWidget(), FooterLoginWidget()],
      ),
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Aún no tiene cuenta?"),
              SizedBox(width: 32.0),
              GestureDetector(
                onTap: () => GoRouter.of(context).pushNamed("sign-up"),
                child: Text(
                  "Registrate acá",
                  style: TextStyle(
                    color: Colors.purple,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                // label: Text("Usuario"),
                labelText: "Email",
                // prefixIcon: Icon(Icons.person),
                icon: Icon(Icons.person),
                hintText: "Escriba su email",
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                // label: Text("Usuario"),
                labelText: "Contraseña",
                // prefixIcon: Icon(Icons.person),
                icon: Icon(Icons.lock),
                hintText: "Escriba su contraseña",
                suffixIcon: GestureDetector(
                  onTap:
                      () => setState(() {
                        showPassword = !showPassword;
                      }),
                  child: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: !showPassword,
            ),
            SizedBox(height: 16.0),
            FilledButton(
              onPressed: () => {},
              child: SizedBox(
                width: double.infinity,
                child: Text("Iniciar Sesión", textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            width: double.infinity,
            height: 100.0,
            fit: BoxFit.fitHeight,
            "https://www.infobae.com/resizer/v2/https%3A%2F%2Fs3.amazonaws.com%2Farc-wordpress-client-uploads%2Finfobae-wp%2Fwp-content%2Fuploads%2F2017%2F04%2F06155038%2Fperro-beso.jpg?auth=7db092219938909c16f466d602dcf2715cb44547bae1b45714fbfc66be4b16e9&smart=true&width=1200&height=900&quality=85",
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Inicio de Sesión",
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
