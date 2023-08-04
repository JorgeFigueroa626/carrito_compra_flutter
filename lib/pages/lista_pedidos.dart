// ignore_for_file: unused_field, prefer_final_fields, sized_box_for_whitespace

import 'package:carrito_compra/models/productos_model.dart';
// import 'package:fancy_dialog/FancyAnimation.dart';
// import 'package:fancy_dialog/FancyGif.dart';
// import 'package:fancy_dialog/FancyTheme.dart';
// import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class Cart extends StatefulWidget {
  const Cart(this._cart, {super.key});

  final List<ProductosModel> _cart;

  @override
  State<Cart> createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);
  final _scrollController = ScrollController();
  var _firsScroll = true;
  bool _enabled = false;

  List<ProductosModel> _cart;

  Container pagoTotal(List<ProductosModel> _cart) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Text(
            "Total: \$ ${valorTotal(_cart)}",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black),
          )
        ],
      ),
    );
  }

  String valorTotal(List<ProductosModel> listaProductos) {
    double total = 0.0;

    for (int i = 0; i < listaProductos.length; i++) {
      total = total + (listaProductos[i].price! * listaProductos[i].quantity);
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.restaurant_menu,
              color: Colors.white,
            ),
          )
        ],
        title: const Text(
          'Detalles',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (_enabled && _firsScroll) {
            _scrollController
                .jumpTo(_scrollController.position.pixels - details.delta.dy);
          }
        },
        onVerticalDragEnd: (_) {
          if (_enabled) _firsScroll = false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cart.length,
                itemBuilder: (context, index) {
                  final String image = _cart[index].image!;
                  var item = _cart[index];
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                    "assets/images/$image",
                                    fit: BoxFit.contain,
                                  ),
                                )),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      item.name!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.red[600],
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 6.0,
                                                color: Colors.blue[400]!,
                                                offset: const Offset(0.0, 1.0),
                                              )
                                            ],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(50.0),
                                            ),
                                          ),
                                          margin:
                                              const EdgeInsets.only(top: 20.0),
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const SizedBox(height: 8.0),
                                              IconButton(
                                                onPressed: () {
                                                  _removeProduct(index);
                                                  valorTotal(_cart);
                                                },
                                                icon: const Icon(Icons.remove),
                                                color: Colors.white,
                                              ),
                                              Text(
                                                '${_cart[index].quantity}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 22.0),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  _addProduct(index);
                                                  valorTotal(_cart);
                                                },
                                                icon: const Icon(Icons.add),
                                                color: Colors.white,
                                              ),
                                              const SizedBox(height: 10.0)
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(width: 38.0),
                                Text(
                                  item.price.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 24.0),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const Divider(color: Colors.black)
                    ],
                  );
                },
              ),
              const SizedBox(width: 10.0),
              pagoTotal(_cart),
              const SizedBox(width: 20.0),
              Container(
                height: 70,
                width: 100,
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Dialogs.materialDialog(
                        msg: 'ACEPTA PAGAR LA COMPRA',
                        title: "ACEPTA PAGAR LA COMPRA",
                        color: Colors.white,
                        context: context,
                        actions: [
                          IconsOutlineButton(
                            onPressed: (){},
                            text: 'Cancel',
                            iconData: Icons.cancel_outlined,
                            textStyle: const TextStyle(color: Colors.grey),
                            iconColor: Colors.grey,
                          ),
                          IconsButton(
                            onPressed: () {
                             print("Compra Exitosa");
                            },
                            text: 'COMPRAR',
                            iconData: Icons.attach_money_outlined,
                            color: Colors.red,
                            textStyle: const TextStyle(color: Colors.white),
                            iconColor: Colors.white,
                          ),
                        ]);
                  },
                  child: const Text("PAGAR"),
                ),
              ),
              const SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }

  _addProduct(int index) {
    setState(() {
      _cart[index].quantity++;
    });
  }

  _removeProduct(int index) {
    setState(() {
      _cart[index].quantity--;
    });
  }
}
