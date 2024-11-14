import 'package:blocshop/Bloc/shop_bloc.dart';
import 'package:blocshop/Bloc/shop_event.dart';
import 'package:blocshop/Bloc/shop_state.dart';
import 'package:blocshop/Core/Widgets/inventory_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  double min =0.0;
  double max =1000.0;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShopBloc>(context).add(LoadProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: BlocBuilder<ShopBloc, ShopState>(builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              RangeSlider(labels: RangeLabels('\$${min.toStringAsFixed(0)}',
              '\$${max.toStringAsFixed(0)}',),activeColor: Colors.amber,divisions: 10,min: 0,max: 1000 ,values: RangeValues(min, max), onChanged: (value) {
                setState(() {
                  min = value.start;
                  max = value.end;
                });
                BlocProvider.of<ShopBloc>(context).add(FilteredPriceProduct(min, max));
              },),
              Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<ShopBloc>(context).add(AddToInventory(state.products[index]));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text('${state.products[index].name}'),
                            subtitle: Text(
                              '\$${state.products[index].price}'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              InventoryProduct()
              
            ],
          );
        }
      }),
    );
  }
}
