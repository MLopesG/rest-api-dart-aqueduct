import 'backend.dart';
import 'controllers/HeroController.dart';

class HeroConfig extends Configuration {
  HeroConfig(String path): super.fromFile(File(path));
  DatabaseConfiguration database;
}

class BackendChannel extends ApplicationChannel {

  ManagedContext context; 

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = HeroConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore =  PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName
    );

    context = ManagedContext(dataModel,persistentStore);
  }
  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route("/dart")
      .linkFunction((request) async {
        return Response.ok({"info": "RestAPI construida com Dart e aqueduct."});
      });

    router
      .route("/heroes/[:id]")
      .link(()=> HeroController(context));

    return router;
  }
}