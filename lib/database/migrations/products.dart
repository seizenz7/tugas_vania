import 'package:vania/vania.dart';

class Products extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('products', () {
      string('prod_id', length: 10);
      primary('prod_id');
      char('vend_id', length: 5);
      foreign('vend_id', 'vendors', 'vend_id', onDelete: 'CASCADE');
      string('prod_name', length: 25);
      integer('prod_price', length: 11);
      text('prod_desc');
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('products');
  }
}
