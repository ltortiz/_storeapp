import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [HeaderSignUpWidget(), BodySignUpWidget()]),
    );
  }
}

class BodySignUpWidget extends StatefulWidget {
  const BodySignUpWidget({super.key});

  @override
  State<BodySignUpWidget> createState() => _BodySignUpWidgetState();
}

class _BodySignUpWidgetState extends State<BodySignUpWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();

  String _photoUrl = "";

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Aquí puedes manejar el registro, como enviar los datos al backend
      print("Nombre: ${_nameController.text}");
      print("Correo: ${_emailController.text}");
      print("Imagen URL: ${_photoUrlController.text}");
    }
  }

  @override
  void initState() {
    super.initState();
    _photoUrlController.addListener(() {
      setState(() {
        _photoUrl = _photoUrlController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 48.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  icon: Icon(Icons.person),
                  hintText: "Escriba su nombre",
                ),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El nombre es obligatorio";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Correo electrónico",
                  icon: Icon(Icons.email),
                  hintText: "Escriba su correo",
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "El correo es obligatorio";
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Ingrese un correo válido";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  icon: Icon(Icons.lock),
                  hintText: "Escriba su contraseña",
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "La contraseña debe tener al menos 6 caracteres";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirmar Contraseña",
                  icon: Icon(Icons.password),
                  hintText: "Repita su contraseña",
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return "Las contraseñas no coinciden";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _photoUrlController,
                decoration: InputDecoration(
                  labelText: "Foto",
                  icon: Icon(Icons.photo),
                  hintText: "Escriba la url de su foto",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese la URL de la foto";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Center(
                child:
                    _photoUrl.isNotEmpty
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            _photoUrl,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.image_not_supported,
                                size: 80,
                                color: Colors.grey,
                              );
                            },
                          ),
                        )
                        : Icon(Icons.image, size: 80, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Volver"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: FilledButton(
                      onPressed: _register,
                      child: Text("Registrar"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSignUpWidget extends StatelessWidget {
  const HeaderSignUpWidget({super.key});

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
              "Registrar",
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
