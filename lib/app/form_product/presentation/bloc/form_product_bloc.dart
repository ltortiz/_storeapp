import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/form_product/domain/use_case/add_product_use_case.dart';
import 'package:storeapp/app/form_product/domain/use_case/get_product_use_case.dart';
import 'package:storeapp/app/form_product/domain/use_case/update_product_use_case.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_event.dart';
import 'package:storeapp/app/form_product/presentation/bloc/form_product_state.dart';
import 'package:storeapp/app/form_product/presentation/model/product_form_model.dart';

class FormProductBloc extends Bloc<FormProductEvent, FormProductState> {
  final AddProductUseCase addProductUseCase;
  final GetProductUseCase getProductUseCase;
  final UpdateProductUseCase updateProductUseCase;

  FormProductBloc({
    required this.addProductUseCase,
    required this.getProductUseCase,
    required this.updateProductUseCase,
  }) : super(InitialState()) {
    on<NameChangedEvent>(_nameChangedEvent);
    on<PriceChangedEvent>(_priceChangedEvent);
    on<UrlImageChangedEvent>(_urlImageChangedEvent);
    on<SubmitEvent>(_submitEvent);
    on<GetProductEvent>(_getProductEvent);
  }

  void _nameChangedEvent(
    NameChangedEvent event,
    Emitter<FormProductState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(name: event.name),
    );
    emit(newState);
  }

  void _priceChangedEvent(
    PriceChangedEvent event,
    Emitter<FormProductState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(price: event.price),
    );
    emit(newState);
  }

  void _urlImageChangedEvent(
    UrlImageChangedEvent event,
    Emitter<FormProductState> emit,
  ) {
    final newState = DataUpdateState(
      model: state.model.copyWith(urlImage: event.urlImage),
    );
    emit(newState);
  }

  Future<void> _submitEvent(
    SubmitEvent event,
    Emitter<FormProductState> emit,
  ) async {
    late final FormProductState newState;
    try {
      late final bool result;
      if (state.model.id == "") {
        result = await addProductUseCase.invoke(state.model);
      } else {
        result = await updateProductUseCase.invoke(state.model);
      }
      if (result) {
        newState = SubmitSuccessState(model: state.model);
      } else {
        throw (Exception());
      }
    } catch (e) {
      newState = SubmitErrorState(
        model: state.model,
        message: "Error al registrar",
      );
    }
    emit(newState);
  }

  Future<void> _getProductEvent(
    GetProductEvent event,
    Emitter<FormProductState> emit,
  ) async {
    final ProductFormModel result = await getProductUseCase.invoke(event.id);
    final newState = DataUpdateState(model: result);
    emit(newState);
  }
}
