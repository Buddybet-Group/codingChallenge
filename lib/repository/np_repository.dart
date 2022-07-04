
import 'package:coding_chal/model/nationality_model.dart';

abstract class NPRepository {
  Future<NationalityMOdel> getNationality(String name);

}