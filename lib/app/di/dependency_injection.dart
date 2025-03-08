import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:storeapp/app/core/data/remote/service/product_service.dart';
import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/data/repository/session_repository_impl.dart';
import 'package:storeapp/app/core/domain/repository/session_repository.dart';
import 'package:storeapp/app/core/domain/use_case/logout_use_case.dart';
import 'package:storeapp/app/core/domain/use_case/profile_use_case.dart';
import 'package:storeapp/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:storeapp/app/features/signup/data/repository/signup_repository_impl.dart';
import 'package:storeapp/app/features/signup/domain/repository/signup_repository.dart';
import 'package:storeapp/app/features/signup/domain/use_case/signup_use_case.dart';
import 'package:storeapp/app/features/signup/presentation/bloc/signup_bloc.dart';
import 'package:storeapp/app/features/form_product/data/repository/form_product_repository_impl.dart';
import 'package:storeapp/app/features/form_product/domain/repository/form_product_repository.dart';
import 'package:storeapp/app/features/form_product/domain/use_case/add_product_use_case.dart';
import 'package:storeapp/app/features/form_product/domain/use_case/find_product_use_case.dart';
import 'package:storeapp/app/features/form_product/domain/use_case/update_product_use_case.dart';
import 'package:storeapp/app/features/form_product/presentation/bloc/form_product_bloc.dart';
import 'package:storeapp/app/features/products/data/repository/products_repository_impl.dart';
import 'package:storeapp/app/features/products/domain/repository/products_repository.dart';
import 'package:storeapp/app/features/products/domain/use_case/delete_product_use_case.dart';
import 'package:storeapp/app/features/products/domain/use_case/get_products_use_case.dart';
import 'package:storeapp/app/features/products/presentation/bloc/products_bloc.dart';
import 'package:storeapp/app/features/login/data/repository/login_repository_impl.dart';
import 'package:storeapp/app/features/login/domain/repository/login_repository.dart';
import 'package:storeapp/app/features/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/features/login/presentation/bloc/login_bloc.dart';
import 'package:storeapp/app/features/users/data/repository/users_repository_impl.dart';
import 'package:storeapp/app/features/users/domain/repository/users_repository.dart';
import 'package:storeapp/app/features/users/domain/use_case/get_users_use_case.dart';
import 'package:storeapp/app/features/users/presentation/bloc/users_bloc.dart';

final class DependencyInjection {
  DependencyInjection._();

  static final serviceLocator = GetIt.instance;

  static setup() {
    /**
     * DIO
     */
    serviceLocator.registerSingleton<Dio>(Dio());
    serviceLocator.registerFactory<ProductService>(
      () => ProductService(dio: serviceLocator.get()),
    );
    serviceLocator.registerFactory<UserService>(
      () => UserService(dio: serviceLocator.get()),
    );
    /**
     * Logout
     */
    serviceLocator.registerFactory<SessionRepository>(
      () => SessionRepositoryImpl(userService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<LogoutUseCase>(
      () => LogoutUseCase(sessionRepository: serviceLocator.get()),
    );
    /**
     * Login
     */
    serviceLocator.registerFactory<LoginRepository>(
      () => LoginRepositoryImpl(),
    );
    serviceLocator.registerFactory<LoginUseCase>(
      () => LoginUseCase(loginRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<LoginBloc>(
      () => LoginBloc(loginUseCase: serviceLocator.get()),
    );
    /**
     * Profile
     */
    serviceLocator.registerFactory<ProfileUseCase>(
      () => ProfileUseCase(sessionRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<ProfileBloc>(
      () => ProfileBloc(
        logoutUseCase: serviceLocator.get(),
        profileUseCase: serviceLocator.get(),
      ),
    );
    /**
     * Signup
     */
    serviceLocator.registerFactory<SignupRepository>(
      () => SignupRepositoryImpl(userService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<SignupUseCase>(
      () => SignupUseCase(signupRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<SignupBloc>(
      () => SignupBloc(signupUseCase: serviceLocator.get()),
    );
    /**
     * Products
     */
    serviceLocator.registerFactory<ProductsRepository>(
      () => ProductsRepositoryImpl(productService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<GetProductsUseCase>(
      () => GetProductsUseCase(productsRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<DeleteProductUseCase>(
      () => DeleteProductUseCase(productsRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<ProductsBloc>(
      () => ProductsBloc(
        findProductsUseCase: serviceLocator.get(),
        deleteProductUseCase: serviceLocator.get(),
      ),
    );
    /**
     * Product
     */
    serviceLocator.registerFactory<FormProductRepository>(
      () => FormProductRepositoryImpl(productService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<AddProductUseCase>(
      () => AddProductUseCase(formProductRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<FindProductUseCase>(
      () => FindProductUseCase(formProductRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<UpdateProductUseCase>(
      () => UpdateProductUseCase(formProductRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<FormProductBloc>(
      () => FormProductBloc(
        addProductUseCase: serviceLocator.get(),
        findProductUseCase: serviceLocator.get(),
        updateProductUseCase: serviceLocator.get(),
      ),
    );
    /**
     * Users
     */
    serviceLocator.registerFactory<UsersRepository>(
      () => UsersRepositoryImpl(userService: serviceLocator.get()),
    );
    serviceLocator.registerFactory<GetUsersUseCase>(
      () => GetUsersUseCase(usersRepository: serviceLocator.get()),
    );
    serviceLocator.registerFactory<UsersBloc>(
      () => UsersBloc(getUsersUseCase: serviceLocator.get()),
    );
  }
}
