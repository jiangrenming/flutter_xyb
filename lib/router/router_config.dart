import 'package:flutter_xyb/router/page_routes.dart';
import 'package:fluro/fluro.dart';

class RouterConfig {

  static final  Router router = Router();

  static  setupRouter(){
    pageRoutes.forEach((pageName,pageBuilder) {
      router.define(pageName.toString(), handler: pageBuilder.getHandler(),transitionType: TransitionType.inFromRight);
    });
  }
 }