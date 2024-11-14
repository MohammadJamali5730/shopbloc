import 'package:blocshop/Bloc/shop_event.dart';
import 'package:blocshop/Bloc/shop_state.dart';
import 'package:blocshop/Core/Models/modelproduct.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  List<ShopModel> shopList = [
    ShopModel(name: 'pizza', price: 100, count: 1),
    ShopModel(name: 'burger', price: 200, count: 1),
    ShopModel(name: 'noodles', price: 300, count: 1),
    ShopModel(name: 'sushi', price: 400, count: 1),
    ShopModel(name: 'chicken', price: 500, count: 1),
  ];
  List<ShopModel> add2cart = [];
  double total=0 ;
  ShopBloc() : super(ShopState(isLoading: true, products: [], inventory: [])) {
    on<LoadProduct>(
      (event, emit) async {
        await Future.delayed(const Duration(seconds: 2));
        emit(ShopState(
            isLoading: false, products: shopList, inventory: add2cart));
      },
    );
    on<AddToInventory>(
      (event, emit) {
        final result = add2cart.indexWhere(
          (element) {
            return element.name == event.item.name;
          },
        );
        if (result >= 0) {
          add2cart[result].count += 1;
        } else {
          add2cart.add(event.item);
        }
        _calculateTotal();
        emit(ShopState(
            isLoading: false, products: shopList, inventory: add2cart,totalproduct: total));
      },
    );
    on<RemoveFromInventory>(
      (event, emit) {
    final result = add2cart.indexWhere((element) {
      return element.name == event.indexitem.name;
    });

    if (result >= 0) {
      if (add2cart[result].count > 1) {
        add2cart[result].count -= 1; 
      } else {
        add2cart.removeAt(result); 
      }
    }
_calculateTotal();
    emit(ShopState(
      isLoading: false,
      products: shopList,
      inventory: List.from(add2cart),
      totalproduct: total
    ));
  },
    );
    on<FilteredPriceProduct>((event, emit) {
      final filterlist=shopList.where((element) {
        return   element.price! >= event.minprice && element.price! <= event.maxprice;
      } ,).toList();
      emit(ShopState(
        isLoading: false,
        products: filterlist,
        inventory: List.from(add2cart),
        totalproduct: total
      ));
    },);
  }
  void _calculateTotal() {
    total=0;
    for (var item in add2cart) {
       
      total += item.price! * item.count;
    }

  }
}
