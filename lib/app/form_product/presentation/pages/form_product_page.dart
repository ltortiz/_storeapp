import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_event.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_state.dart';
import 'package:storeapp/app/form_product/presentation/pages/form_product_mixin.dart';

class FormProductPage extends StatelessWidget {
  final String? id;
  const FormProductPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<FormProductBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarTextStyle: TextStyle(color: Colors.white),
          title: Text(
            id == null ? "Agregar Producto" : "Actualizar Producto",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
        ),
        body: Column(children: [BodyFormProductWidget(id: id)]),
      ),
    );
  }
}

class BodyFormProductWidget extends StatefulWidget {
  final String? id;
  const BodyFormProductWidget({super.key, this.id});

  @override
  State<BodyFormProductWidget> createState() => _BodyFormProductWidgetState();
}

class _BodyFormProductWidgetState extends State<BodyFormProductWidget>
    with FormProductMixin {
  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FormProductBloc bloc = context.read<FormProductBloc>();
    if (widget.id != null) {
      bloc.add(GetProductEvent(id: widget.id!));
    }
    TextEditingController nameField = TextEditingController();
    TextEditingController priceField = TextEditingController();
    TextEditingController urlImageField = TextEditingController();

    return BlocListener<FormProductBloc, FormProductState>(
      listener: (context, state) {
        switch (state) {
          case InitialState():
            break;
          case DataUpdateState():
            break;
          case SubmitSuccessState():
            GoRouter.of(context).pop();
            break;
          case SubmitErrorState():
            showDialog<void>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Error!!"),
                  titleTextStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  content: Text(state.message),
                  actions: [
                    FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Cerrar"),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            );
            print("No inicioooo :(");
            break;
        }
      },
      child: BlocBuilder<FormProductBloc, FormProductState>(
        builder: (context, state) {
          nameField.text = state.model.name;
          priceField.text = state.model.price;
          urlImageField.text = state.model.urlImage;
          // final bool isValidForm =
          //     validateEmail(state.model.email) == null &&
          //     validatePassword(state.model.password) == null;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
              child: Form(
                key: keyForm,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameField,
                      onChanged:
                          (value) => bloc.add(NameChangedEvent(name: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validateEmail,
                      decoration: InputDecoration(
                        labelText: "Nombre",
                        icon: Icon(Icons.card_giftcard),
                        hintText: "Escriba el nombre del producto",
                      ),
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: priceField,
                      onChanged:
                          (value) => bloc.add(PriceChangedEvent(price: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validatePassword,
                      decoration: InputDecoration(
                        labelText: "Precio",
                        icon: Icon(Icons.attach_money),
                        hintText: "Escriba el precio del producto",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: urlImageField,
                      onChanged:
                          (value) =>
                              bloc.add(UrlImageChangedEvent(urlImage: value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: validatePassword,
                      decoration: InputDecoration(
                        labelText: "Imagen",
                        icon: Icon(Icons.image),
                        hintText: "Escriba la url de la imange del producto",
                      ),
                      keyboardType: TextInputType.url,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child:
                          state.model.urlImage.isNotEmpty
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  state.model.urlImage,
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
                    SizedBox(height: 16.0),
                    FilledButton(
                      onPressed: () => bloc.add(SubmitEvent()),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          widget.id == null ? "Crear" : "Actualizar",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
