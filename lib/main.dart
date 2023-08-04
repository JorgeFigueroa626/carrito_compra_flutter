// ignore_for_file: unused_field, sized_box_for_whitespace, import_of_legacy_library_into_null_safe

import 'package:carrito_compra/models/productos_model.dart';
import 'package:carrito_compra/pages/lista_pedidos.dart';
import 'package:carrito_compra/pages/otra_pagina.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'E-Commerce'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductosModel> _productosModel = <ProductosModel>[];

  List<ProductosModel> _listaCarro = <ProductosModel>[];

  @override
  void initState() {
    super.initState();
    _productosBD();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  const Icon(
                    Icons.shopping_cart,
                    size: 38,
                  ),
                  if (_listaCarro.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _listaCarro.length.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      ),
                    )
                ],
              ),
              onTap: () {
                if (_listaCarro.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(_listaCarro),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
      drawer: Container(
        width: 170.0,
        child: Drawer(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.black,
            child: ListView(
              padding: const EdgeInsets.only(top: 50.0),
              children: <Widget>[
                Container(
                  height: 120,
                  child: const UserAccountsDrawerHeader(
                    accountName: Text(''),
                    accountEmail: Text(''),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/drawer.jpg'),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.home,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OtraPagina(),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Cupones',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.card_giftcard,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OtraPagina(),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Tiendas',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.place,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OtraPagina(),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Productos',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const Icon(
                    Icons.fastfood,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OtraPagina(),
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'QR Code',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: const FaIcon(
                    FontAwesomeIcons.qrcode,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OtraPagina(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _cuadroProductos(),
    );
  }

  GridView _cuadroProductos() {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _productosModel.length,
      itemBuilder: (context, index) {
        final String image = _productosModel[index].image!;
        var item = _productosModel[index];
        return Card(
          elevation: 4.0,
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Image.asset("assets/images/$image",
                        fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    item.name!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      Text(
                        item.price.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23.0,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              child: (!_listaCarro.contains(item))
                                  ? const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.green,
                                      size: 38,
                                    )
                                  : const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.red,
                                      size: 38,
                                    ),
                              onTap: () {
                                setState(() {
                                  if (!_listaCarro.contains(item)) {
                                    _listaCarro.add(item);
                                  } else {
                                    _listaCarro.remove(item);
                                  }
                                });
                              },
                            )),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _productosBD() {
    var list = <ProductosModel>[
      ProductosModel(
        name: 'Burger King',
        image: 'burger.jpg',
        price: 15,
      ),
      ProductosModel(
        name: 'Empanada',
        image: 'empanada.jpg',
        price: 10,
      ),
      ProductosModel(
        name: 'Postre',
        image: 'postre.jpg',
        price: 13,
      ),
      ProductosModel(
        name: 'Pizza',
        image: 'pizza.jpg',
        price: 20,
      ),
      ProductosModel(
        name: 'Salteña',
        image: 'salteña.jpg',
        price: 14,
      ),
      ProductosModel(
        name: 'Asado',
        image: 'asado.jpg',
        price: 25,
      ),
      ProductosModel(
        name: 'Carnet',
        image: 'carnet.jpg',
        price: 28,
      ),
    ];

    setState(() {
      _productosModel = list;
    });
  }
}
