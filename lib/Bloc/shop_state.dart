import 'package:blocshop/Core/Models/modelproduct.dart';

class ShopState {
   bool isLoading;
  List<ShopModel> products = [];
  List<ShopModel> inventory = [];
  double totalproduct=0;
  ShopState({required this.isLoading, required this.products,required this.inventory , this.totalproduct=0}); 
}