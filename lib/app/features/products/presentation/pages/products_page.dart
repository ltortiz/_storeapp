import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/core/presentation/theme/app_theme.dart';
import 'package:storeapp/app/core/presentation/widgets/custom_app_bar.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/features/products/presentation/bloc/products_bloc.dart';
import 'package:storeapp/app/features/products/presentation/bloc/products_event.dart';
import 'package:storeapp/app/features/products/presentation/bloc/products_state.dart';
import 'package:storeapp/app/features/products/presentation/model/product_model.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<ProductsBloc>(),
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(60.0),
        //   child: AppBarWidget(),
        // ),
        appBar: const CustomAppBar("Listado de Productos"),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.pushNamed("form-product"),
          backgroundColor: AppTheme.primaryColor,
          child: Icon(Icons.add),
        ),
        body: ProductListWidget(),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductsBloc>();
    return AppBar(
      backgroundColor: AppTheme.primaryColor,
      title: Text(
        "Listado de Productos",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        InkWell(
          onTap:
              () => showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Cerrar Sesión"),
                    titleTextStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    content: Text("Está seguro de cerrar sesión?"),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          bloc.add(LogoutEvent());
                          Navigator.pop(context, "Ok");
                        },
                        child: Text("Ok"),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context, "Cancelar");
                        },
                        child: Text("Cancelar"),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  );
                },
              ),
          child: Icon(Icons.logout, color: Colors.white),
        ),
        SizedBox(width: 16.0),
      ],
    );
  }
}

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductsBloc>();
    bloc.add(GetProductsEvent());
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        switch (state) {
          case EmptyState() || LoadingState() || LoadDataState():
            break;
          case HomeErrorState():
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
                      onPressed: () {
                        Navigator.pop(context, "Cerrar");
                        bloc.add(GetProductsEvent());
                      },
                      child: Text("Cerrar"),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            );
            print("Error....");
            break;
          case LogoutState():
            print("Logout");
            GoRouter.of(context).go("/login");
            break;
        }
      },
      builder: (context, state) {
        switch (state) {
          case LoadingState():
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20.0),
                  Text(state.message),
                ],
              ),
            );
          case EmptyState():
            return Center(child: Text("No hay productos"));
          case LoadDataState():
            return ListView.builder(
              itemCount: state.model.products.length,
              itemBuilder:
                  (context, index) =>
                      ProductItemWidget(state.model.products[index]),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final ProductModel product;

  const ProductItemWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductsBloc>();
    return InkWell(
      onTap:
          () => GoRouter.of(
            context,
          ).pushNamed("form-product-u", pathParameters: {"id": product.id}),
      onLongPress:
          () => showDialog<void>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Eliminación de Producto"),
                titleTextStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                content: Text(
                  "Está seguro de eliminar este producto?: ${product.name}",
                ),
                actions: [
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context, "Ok");
                      bloc.add(DeleteProductEvent(id: product.id));
                    },
                    child: Text("Ok"),
                    style: FilledButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context, "Cancelar");
                    },
                    child: Text("Cancelar"),
                    style: FilledButton.styleFrom(backgroundColor: Colors.grey),
                  ),
                ],
              );
            },
          ),
      child: Card(
        child: Row(
          children: [
            Image.network(
              //"https://cdn-icons-png.freepik.com/256/10266/10266140.png",
              product.urlImage,
              width: 150.0,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: SizedBox(
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Nombre:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(product.name),
                    Text(
                      "Precio:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(product.price.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
