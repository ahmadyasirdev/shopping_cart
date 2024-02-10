import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:newmango/cart_model.dart';
import 'package:newmango/cart_provider.dart';
import 'package:newmango/db_helper.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper? dbHelper = DBHelper();
  List<String> productName = [
    'mango',
    'flower',
    'mango',
    'Muniba principle',
    ' Banana',
    'flower',
    'Mixed Flower Basket'
  ];
  List<String> productUnit = ['KG', 'Dozan', 'KG', 'Dozan', ' KG', 'KG', 'KG'];
  List<int> productPrice = [10, 23, 34, 46, 46, 56, 56];
  List<String> productImage = [
    'https://cdn.pixabay.com/photo/2022/10/30/05/26/mango-lassi-7556631_640.jpg',
    'https://cdn.pixabay.com/photo/2016/10/25/22/22/roses-1770165_640.png',
    'https://cdn.pixabay.com/photo/2022/10/30/05/26/mango-lassi-7556631_640.jpg',
    'https://cdn.pixabay.com/photo/2012/04/30/09/56/ape-44564_640.png',
    'https://cdn.pixabay.com/photo/2014/12/21/23/39/bananas-575773_1280.png',
    'https://cdn.pixabay.com/photo/2019/04/23/06/47/flower-4148707_640.png',
    'https://cdn.pixabay.com/photo/2017/01/12/06/26/flowers-1973875_640.png',
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('product List'),
        centerTitle: true,
        actions: [
          badges.Badge(
            badgeContent: Consumer<CartProvider>(
              builder: (context,value,child){
                return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white),);
              },

            ),

            child: Icon(Icons.shopping_bag_outlined),
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: Column(
        children: [
          ListView.builder(
              itemCount: productName.length,
              itemBuilder: (context, indext) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image(
                                height: 100,
                                width: 100,
                                image: NetworkImage(
                                    productImage[indext].toString())),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName[indext].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    productUnit[indext].toString() +
                                        '' +
                                        r'$' +
                                        productPrice[indext].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: (){
                                        dbHelper!.insert(
                                          Cart(
                                              id: indext,
                                              productId: indext.toString(),
                                              productName:productName[indext].toString(),
                                              initialPrice:productPrice[indext] ,
                                              productPrice: productPrice[indext],
                                              quantity: 1,
                                              unitTag: productUnit[indext].toString(),
                                              image: productImage[indext].toString()
                                          )
                                        ).then((value){
                                          print('product is add to cart');
                                          cart.addTotalPrice(double.parse(productPrice[indext].toString()));
                                          cart.addCounter();
                                        }).onError((error, stackTrace){
                                          print(error.toString());
                                        });
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.green),
                                        child: Center(
                                            child: Text(
                                          'add to cart ',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}
