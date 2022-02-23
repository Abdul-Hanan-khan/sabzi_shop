import 'package:cached_map/cached_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sabzishop/modal/cart.dart';
import 'package:sabzishop/modal/deal.dart';
import 'package:sabzishop/modal/product.dart';
import 'package:sabzishop/modal/time_slot.dart';
import 'package:sabzishop/utilities.dart';

class CartController extends GetxController {

  Cart cart = Cart(products: <Product>[].obs,deals: <Deal>[].obs);
  RxInt totalItems = 0.obs;
  RxBool progressing = false.obs;
  @override
  onInit()  {
    loadCart();
    super.onInit();
  }



//  int  calculateTotalItems(){
//    int total=0;
//    cart.products.forEach((item) {
//      total=total+item.quantity.value;
//    });
//    cart.deals.forEach((item) {
//      total=total+item.quantity.value;
//    });
//    totalItems.value = total;
//    return total;
//  }

  Future<Cart> loadCart() async {
    try{
      Map<String, dynamic> cartJson =
      await Mapped.loadFileDirectly(cachedFileName: 'Cart');

      if (cartJson == null)
      {  cart.products.value=<Product>[].obs;
      cart.deals =<Deal>[].obs;
      }
      else
      {
        cart = Cart.fromJson(cartJson);
//        calculateTotalItems();
      }
    }
    catch(e){
      print(e);
    }
  }


  clearCart(){
    Mapped.deleteFileDirectly(cachedFileName: "Cart");
    cart.products.clear();
    cart.deals.clear();
//    calculateTotalItems();
  }



  ///adding/incrementing item or deal to cart///////////////////////////////////////////////////////////////////////

  addItem(Product product,int index) {
      if (index != -1) {
        cart.products[index].quantity++;
      }
     else {
        product.quantity.value = 1;
        cart.products.add(product);
    }

    Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
     if(index ==-1)
       Utils.showToast("Added to cart successfully",);
//      calculateTotalItems();
  }

  addDeal(Deal deal,int index) {
    if (index != -1) {
      cart.deals[index].quantity++;
    }
    else {
      deal.quantity.value = 1;
      cart.deals.add(deal);
    }

    Mapped.saveFileDirectly(file: cart.toJson(), cachedFileName: 'Cart');
    if(index ==-1)
      Utils.showToast( "Added to cart successfully");
  }

  ///removing/decrementing item or deal to cart///////////////////////////////////////////////////////////////////////

  removeItem(Product product,int index) {
    if(cart.products[index].quantity>1) {
      cart.products[index].quantity--;
    }
    else
      {
        cart.products.removeAt(index);
        Utils.showToast("Item removed");
      }
    Mapped.saveFileDirectly(
        file: cart.toJson(), cachedFileName: 'Cart');
//    calculateTotalItems();
  }

  removeDeal(Deal deal,int index) {
    if(cart.deals[index].quantity>1) {
      cart.deals[index].quantity--;
    }
    else
    {
      cart.deals.removeAt(index);
      Utils.showToast("Deal removed");
    }
    Mapped.saveFileDirectly(
        file: cart.toJson(), cachedFileName: 'Cart');
  }


  ///removing item (all quantities)  or deal to cart///////////////////////////////////////////////////////////////////////



  removeFullItem(Product product,int index) {
      cart.products.removeAt(index);
      Utils.showToast("Item removed");

    Mapped.saveFileDirectly(
        file: cart.toJson(), cachedFileName: 'Cart');
  }

  removeFullDeal(Deal deal,int index) {
    cart.deals.removeAt(index);
    Utils.showToast("Deal removed");

    Mapped.saveFileDirectly(
        file: cart.toJson(), cachedFileName: 'Cart');
  }








double calculateTotalAmmout(){
   double dealTotal =  calculateDealsTotalAmount();
   double productTotal = calculateProductsTotalAmount();
   return dealTotal + productTotal;
}

double calculateProductsTotalAmount(){
  double price=0;
  cart.products.forEach((element) {
    if(element.discountedPrice!=null)
      price+= double.parse(element.discountedPrice)*element.quantity.value;
    else
      price+= double.parse(element.salePrice)*element.quantity.value;
  });
  return price;
}

double calculateDealsTotalAmount(){
  double price=0;
    cart.deals.forEach((element) {
      price+= double.parse(element.dealAmount)*element.quantity.value;
    });
    return price;
  }




  checkout({TimeSlotModal slot,}){


    //TODO: code for checkout here

  }

}