import 'package:vania_api/app/models/productnotes.dart';
import 'package:vania/vania.dart';

class ProductnotesController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> store(Request request) async {
    try {
      final productnotesData = request.input();

      if (productnotesData == null) {
        throw Exception("Data tidak ada");
      }

      await Productnotes().query().insert(productnotesData);

      return Response.json({
        'message': 'notes berhasil disimpan',
        'data': productnotesData,
      }, 201);
    } catch (e) {
      return Response.json({
        'messsage': 'Terjadi kesalahan',
      }, 500);
    }
  }

  Future<Response> show() async {
    try {
      final listProductnotes = await Productnotes().query().get();
      return Response.json({
        'message': 'Daftar notes',
        'data': listProductnotes,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> update(Request request, String note_id) async {
    try {
      final productnoteData = request.input();

      final produknote =
          await Productnotes().query().where('note_id', '=', note_id).first();

      if (produknote == null) {
        return Response.json({
          'message': 'note dengan id $note_id tidak ditemukan',
        }, 404);
      }

      final updatedRows = await Productnotes()
          .query()
          .where('note_id', '=', note_id)
          .update(productnoteData);

      if (updatedRows == 0) {
        return Response.json({
          'message': 'gagal diperbarui karena tidak ada perubahan',
        }, 400);
      }

      return Response.json({
        'message': 'note berhasil diperbarui',
        'data': productnoteData,
      }, 200);
    } catch (e) {
      print("Error occurred: $e");
      return Response.json({
        'message': 'eror ketika proses update',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> destroy(String noteid) async {
    try {
      final note =
          await Productnotes().query().where('note_id', '=', noteid).first();

      if (note == null) {
        return Response.json({
          'message': 'note dengan id $noteid tidak ditemukan',
        }, 404);
      }

      await Productnotes().query().where('note_id', '=', noteid).delete();

      return Response.json({
        'message': 'note dengan id $noteid berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Terjadi kesalahan',
        'error': e.toString(),
      }, 500);
    }
  }
}

final ProductnotesController productnotesController = ProductnotesController();
