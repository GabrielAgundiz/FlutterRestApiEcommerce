import 'package:flutter_bloc/flutter_bloc.dart';

class shoppingCarState {
  List<int> itemIds;
  shoppingCarState(this.itemIds);
} //lista para guardar los ids de los objetos

abstract class ShoppingCarEvent {
  const ShoppingCarEvent();
}

class AddItemToCar extends shoppingCarState {
  final int itemId;
  const AddItemToCar(this.itemId);
}

class RemoveItemFromCar extends shoppingCarState {
  final int itemId;
  const RemoveItemFromCar(this.itemId);
}

//estara escuchando por los eventos
class ShoppingCarBloc extends Bloc<ShoppingCarEvent, shoppingCarState> {
  ShoppingCarBloc(super.initialState) {
    //cuando agregue se llame a este evento agrega a la lista el id del item
    on<AddItemToCar>((event, emit) {
      state.itemIds.add(event.itemId);
      emit(shoppingCarState(state
          .itemIds)); //emite que se ah cambiado el estado para quien este escuchando
    });
    on<RemoveItemFromCar>((event, emit) {
      state.itemIds.remove(event.itemId);
      emit(shoppingCarState(state.itemIds));
    });
  }
}
