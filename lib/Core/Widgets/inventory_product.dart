import 'package:blocshop/Bloc/shop_bloc.dart';
import 'package:blocshop/Bloc/shop_event.dart';
import 'package:blocshop/Bloc/shop_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryProduct extends StatelessWidget {
  InventoryProduct({super.key});

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<ShopBloc, ShopState>(builder: (context, state) {
      return Container(
        width: double.infinity,
        height: 125,
        color: Colors.blue,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.inventory.length,
                itemBuilder: (context, index) {
                   double total(){
                    double totalitem=0;
                    totalitem +=state.inventory[index].price!  * state.inventory[index].count;
                    return totalitem;
                    }
                  return Card(
                    shape: Border.all(
                      color: Colors.black38,
                      width: 1,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('${state.inventory[index].name}'),
                        Text(
                            '\$${state.inventory[index].price! * state.inventory[index].count}'),
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<ShopBloc>(context).add(
                                  RemoveFromInventory(state.inventory[index]));
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  );
                },
              ),
            ),
            Text('total: \$${state.totalproduct}' ,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red , fontSize: 18),),
          ],
        ),
      );
    });
  }
 
}
