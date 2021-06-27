import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static Map<String,String> env;
  static Future<void> loadEnvs() async {
    try{
      const bool isProduction = const bool.fromEnvironment('dart.vm.product');
      await DotEnv().load(isProduction? '.env_release' : '.env_debug');
      env = DotEnv().env;
    }catch(e){
      print(e.toString());
    }
  }
}