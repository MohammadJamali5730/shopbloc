import 'package:blocshop/Core/Models/modelproduct.dart';

abstract class ShopEvent {}
class LoadProduct extends ShopEvent {} 

class IncrementProduct extends ShopEvent {}

class DecrementProduct extends ShopEvent {}

class AddToInventory extends ShopEvent {
    ShopModel item;
    AddToInventory(this.item);
}

class RemoveFromInventory extends ShopEvent {
  ShopModel indexitem;
  RemoveFromInventory(this.indexitem);
}

class FilteredPriceProduct extends ShopEvent {
  double minprice;
  double maxprice;
  FilteredPriceProduct(this.minprice, this.maxprice);
}


