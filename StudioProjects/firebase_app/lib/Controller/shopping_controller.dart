import 'package:firebase_app/Model/product.dart';
import 'package:get/get.dart';

class ShoppingController extends GetxController{
  var products = <Product>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async{
    await Future.delayed(Duration(seconds: 2));
    var productResult = [
      Product(
        id: 1,
        price: 30,
        productDescription: 'some description about product',
        productImage: 'abd',
        productName: 'FirstPeriod'
      ),
      Product(
          id: 2,
          price: 50,
          productDescription: 'some description about product',
          productImage: 'agd',
          productName: 'SecPeriod'
      ),
      Product(
          id: 3,
          price: 45.3,
          productDescription: 'some description about product',
          productImage: 'asd',
          productName: 'ThirdPeriod'
      ),

    ];

    products.value = productResult;
  }
}