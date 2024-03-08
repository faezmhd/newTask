import 'package:firebase_app/Controller/shopping_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingList extends StatelessWidget {
  ShoppingList({super.key});
  final shoppingController = Get.put(ShoppingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetX<ShoppingController>(
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder:(context, index) {
                    return Card(
                      margin: const EdgeInsets.all(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${shoppingController.products[index].productName}',
                                    style: TextStyle(fontSize: 24),
                                    ),
                                    Text('${shoppingController.products[index].productDescription}')

                                  ],
                                ),
                                Text('${shoppingController.products[index].price}',style: const TextStyle(fontSize: 24)),

                              ],
                            ),
                            ElevatedButton(onPressed: () {

                            },
                                child: Text('Add to Cart') )
                          ],
                        ),
                      ),
                    );
                  },);
                }
              ),
            ),
            Text("Total count:"),
            SizedBox(height: 100,),
          ],
        ),
      ),
    );
  }
}
