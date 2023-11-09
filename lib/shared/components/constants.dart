import 'package:firebase/modules/login_social/login_social.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:firebase/shared/network/local/Cache_hilper.dart';

dynamic uId;
void signout(context){
CachHelper.savedata(key: 'uId',value: null);
NavigateAndRemove(context, LoginSocial());
}