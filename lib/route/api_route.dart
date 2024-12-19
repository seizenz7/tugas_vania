import 'package:vania/vania.dart';
import 'package:vania_api/app/http/controllers/products_controller.dart';
import 'package:vania_api/app/http/controllers/customers_controller.dart';
import 'package:vania_api/app/http/controllers/vendors_controller.dart';
import 'package:vania_api/app/http/controllers/productnotes_controller.dart';
import 'package:vania_api/app/http/controllers/orders_controller.dart';
import 'package:vania_api/app/http/controllers/orderitems_controller.dart';
import 'package:vania_api/app/http/controllers/auth_controller.dart';


// produk, kostumer, order, order item, vendor, produk notes

class ApiRoute implements Route {
  @override
  void register() {
    Router.post('/login', AuthController().login);

    Router.get('/customers', CustomersController().show);
    Router.post('/customers-store', CustomersController().store);
    Router.put('/customers/edit/{cust_id}', CustomersController().update);
    Router.delete('/customers/delete/{custid}', CustomersController().destroy);

    Router.get('/vendors', VendorsController().show);
    Router.post('/vendors-store', VendorsController().store);
    Router.put('/vendors/edit/{vend_id}', VendorsController().update);
    Router.delete('/vendors/delete/{vendid}', VendorsController().destroy);

    Router.get('/products', ProductsController().show);
    Router.post('/products-store', ProductsController().store);
    Router.put('/products/edit/{prod_id}', ProductsController().update);
    Router.delete('/products/delete/{prodid}', ProductsController().destroy);

    Router.get('/productnotes', ProductnotesController().show);
    Router.post('/productnotes-store', ProductnotesController().store);
    Router.put('/productnotes/edit/{note_id}', ProductnotesController().update);
    Router.delete('/productnotes/delete/{noteid}', ProductnotesController().destroy);
    
    
    Router.get('/orders', OrdersController().show);
    Router.post('/orders-store', OrdersController().store);
    Router.put('/orders/edit/{order_num}', OrdersController().update);
    Router.delete('/orders/delete/{orderid}', OrdersController().destroy);
    
    Router.get('/orderitems', OrderitemsController().show);
    Router.post('/orderitems-store', OrderitemsController().store);
    Router.put('/orderitems/edit/{order_item}', OrderitemsController().update);
    Router.delete('/orderitems/delete/{orderitem}', OrderitemsController().destroy);
  }
}
