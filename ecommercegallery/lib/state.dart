import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCarState {
  List<int> itemIds;
  ShoppingCarState(this.itemIds);
} //lista para guardar los ids de los objetos

abstract class ShoppingCarEvent {
  const ShoppingCarEvent();
}

class AddItemToCar extends ShoppingCarEvent {
  final int itemId;
  const AddItemToCar(this.itemId);
}

class RemoveItemFromCar extends ShoppingCarEvent {
  final int itemId;
  const RemoveItemFromCar(this.itemId);
}

//estara escuchando por los eventos
class ShoppingCarBloc extends Bloc<ShoppingCarEvent, ShoppingCarState> {
  ShoppingCarBloc(super.initialState) {
    //cuando agregue se llame a este evento agrega a la lista el id del item
    on<AddItemToCar>((event, emit) {
      state.itemIds.add(event.itemId);
      emit(ShoppingCarState(state
          .itemIds)); //emite que se ah cambiado el estado para quien este escuchando
    });
    on<RemoveItemFromCar>((event, emit) {
      state.itemIds.remove(event.itemId);
      emit(ShoppingCarState(state.itemIds));
    });
  }
}
