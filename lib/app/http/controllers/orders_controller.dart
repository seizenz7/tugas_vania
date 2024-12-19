import 'package:vania_api/app/models/orders.dart';
import 'package:vania/vania.dart';

class OrdersController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> store(Request request) async {
    try {
      final ordersData = request.input();

      if (ordersData == null) {
        throw Exception("Data tidak ada");
      }

      await Orders().query().insert(ordersData);

      return Response.json({
        'message': 'orders berhasil disimpan',
        'data': ordersData,
      }, 201);
    } catch (e) {
      return Response.json({
        'messsage': 'Terjadi kesalahan',
      }, 500);
    }
  }

  Future<Response> show() async {
    try {
      final listorders = await Orders().query().get();
      return Response.json({
        'message': 'Daftar orders',
        'data': listorders,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> update(Request request, int order_num) async {
    try {
      final ordersData = request.input();

      final order =
          await Orders().query().where('order_num', '=', order_num).first();

      if (order == null) {
        return Response.json({
          'message': 'order dengan id $order_num tidak ditemukan',
        }, 404);
      }

      final updatedRows = await Orders()
          .query()
          .where('order_num', '=', order_num)
          .update(ordersData);

      if (updatedRows == 0) {
        return Response.json({
          'message': 'gagal diperbarui karena tidak ada perubahan',
        }, 400);
      }

      return Response.json({
        'message': 'order berhasil diperbarui',
        'data': ordersData,
      }, 200);
    } catch (e) {
      print("Error occurred: $e");
      return Response.json({
        'message': 'eror ketika proses update',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> destroy(int ordernum) async {
    try {
      final order =
          await Orders().query().where('order_num', '=', ordernum).first();

      if (order == null) {
        return Response.json({
          'message': 'order dengan id $ordernum tidak ditemukan',
        }, 404);
      }

      await Orders().query().where('order_num', '=', ordernum).delete();

      return Response.json({
        'message': 'order dengan id $ordernum berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan',
        'error': e.toString(),
      }, 500);
    }
  }
}

final OrdersController ordersController = OrdersController();
