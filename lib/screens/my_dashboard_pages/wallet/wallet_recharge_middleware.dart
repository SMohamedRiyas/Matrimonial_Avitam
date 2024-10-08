import '../../../const/my_theme.dart';
import '../../../helpers/navigator_push.dart';
import '../../../repository/wallet_repository.dart';
import '../../core.dart';
import 'my_wallet.dart';

ThunkAction<AppState> walletRechargeMiddleware({
  postBody,
}) {
  return (Store<AppState> store) async {
    store.state.offlinePaymentState!.isSubmit = true;

    var response =
        await WalletRepository().offlineWalletRecharge(postBody: postBody);

    if (response.result) {
      store.dispatch(
          ShowMessageAction(msg: response.message, color: MyTheme.success));

      NavigatorPush.push_replace(page: MyWallet());
      store.dispatch(Reset.offlinePayment);
      // store.dispatch(Reset.myWallet);
      // store.dispatch(walletHistoryMiddleware());
      // store.dispatch(walletBalanceMiddleware());
    } else {
      store.dispatch(
        ShowMessageAction(msg: response.message, color: MyTheme.failure),
      );
    }
    store.state.offlinePaymentState!.isSubmit = false;
  };
}
