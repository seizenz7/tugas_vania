import 'package:vania_api/app/models/customers.dart';
import 'package:vania/vania.dart';

class CustomersController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  // Future<Response> create(Request request) async {
  //   try {
  //     final requestData = request.input();

  //     return Response.json({
  //       "message": "Costumers berhasil ditambahkan",
  //       "data": requestData,
  //     }, 201);
  //   } catch (e) {
  //     return Response.json(
  //       {
  //         "message": "Error dek",
  //       },
  //       500,
  //     );
  //   }
  // }

  Future<Response> store(Request request) async {
    try {
      final customersData = request.input();

      if (customersData == null) {
        throw Exception("Data tidak ada");
      }

      // await Customers().query().insert(customersData);
      await Customers().query().insert(customersData);

      return Response.json({
        'message': 'customer berhasil disimpan',
        'data': customersData,
      }, 201);
    } catch (e) {
      return Response.json({
        'messsage': 'Upss, error bang!',
      }, 500);
    }
  }

  Future<Response> show() async {
    try {
      final listCustomers = await Customers().query().get();
      return Response.json({
        'message': 'Data customer',
        'data': listCustomers,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Upss, error bang!',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> update(Request request, String cust_id) async {
    try {
      final customersData = request.input();

      final customer =
          await Customers().query().where('cust_id', '=', cust_id).first();

      if (customer == null) {
        return Response.json({
          'message': 'Data customer dengan id $cust_id tidak ditemukan',
        }, 404);
      }

      final updatedRows = await Customers()
          .query()
          .where('cust_id', '=', cust_id)
          .update(customersData);

      if (updatedRows == 0) {
        return Response.json({
          'message': 'Data tidak diperbarui',
        }, 400);
      }

      return Response.json({
        'message': 'Data customer berhasil diperbarui',
        'data': customersData,
      }, 200);
    } catch (e) {
      print("Error occurred: $e");
      return Response.json({
        'message': 'eror ketika proses update',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> destroy(String custid) async {
    try {
      final customer =
          await Customers().query().where('cust_id', '=', custid).first();
      
      if (customer == null) {
        return Response.json({
          'message': 'costumer dengan id $custid tidak ditemukan',
        }, 404);
      }

      await Customers().query().where('cust_id', '=', custid).delete();

      return Response.json({
        'message': 'Data customer berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Upss, error bang!',
        'error': e.toString(),
      }, 500);
    }
  }
}

final CustomersController customersController = CustomersController();
