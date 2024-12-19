import 'package:vania_api/app/models/orderitems.dart';
import 'package:vania/vania.dart';

class OrderitemsController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> store(Request request) async {
    try {
      final orderitemsData = request.input();

      if (orderitemsData == null) {
        throw Exception("Data tidak ada");
      }

      await Orderitems().query().insert(orderitemsData);

      return Response.json({
        'message': 'order item berhasil disimpan',
        'data': orderitemsData,
      }, 201);
    } catch (e) {
      return Response.json({
        'messsage': 'Terjadi kesalahan',
      }, 500);
    }
  }

  Future<Response> show() async {
    try {
      final listorderitems = await Orderitems().query().get();
      return Response.json({
        'message': 'Daftar orderitems',
        'data': listorderitems,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> update(Request request, int order_item) async {
    try {
      final orderitemsData = request.input();

      final orderitem = await Orderitems()
          .query()
          .where('order_item', '=', order_item)
          .first();

      if (orderitem == null) {
        return Response.json({
          'message': 'order item dengan id $order_item tidak ditemukan',
        }, 404);
      }

      final updatedRows = await Orderitems()
          .query()
          .where('order_item', '=', order_item)
          .update(orderitemsData);

      if (updatedRows == 0) {
        return Response.json({
          'message': 'gagal diperbarui karena tidak ada perubahan',
        }, 400);
      }

      return Response.json({
        'message': 'order item berhasil diperbarui',
        'data': orderitemsData,
      }, 200);
    } catch (e) {
      print("Error occurred: $e");
      return Response.json({
        'message': 'eror ketika proses update',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> destroy(int orderitem) async {
    try {
      final orderitems = await Orderitems()
          .query()
          .where('order_item', '=', orderitem)
          .first();

      if (orderitems == null) {
        return Response.json({
          'message': 'order item dengan id $orderitem tidak ditemukan',
        }, 404);
      }

      await Orderitems().query().where('order_item', '=', orderitem).delete();

      return Response.json({
        'message': 'order item dengan id $orderitem berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan',
        'error': e.toString(),
      }, 500);
    }
  }
}

final OrderitemsController orderitemsController = OrderitemsController();
