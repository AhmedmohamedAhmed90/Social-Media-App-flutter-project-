abstract class States{}
class initialstate extends States{}
class changebottom_state extends States{}
class getbusiness_state extends States{}
class Loading_Register_state extends States{}
class succsess_Register_state extends States{}
class succsess_CrateUser_state extends States{}
class Loading_login_state extends States{}
class succsess_login_state extends States{
  late final String uId;
  succsess_login_state(this.uId);
}