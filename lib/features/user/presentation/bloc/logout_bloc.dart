import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/datasources/user_local_data_source.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final UserLocalDataSource localDataSource;

  LogoutBloc(this.localDataSource) : super(LogoutInitial()) {
    on<LoggedOut>((event, emit) async {
      emit(LogoutLoading());
      try {
        await localDataSource.deleteAccessToken();
        emit(LoggedOutState());
      } catch (error) {
        emit(LogoutError(error.toString()));
      }
    });
  }
}
