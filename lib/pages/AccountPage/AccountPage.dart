import 'package:baixing/utils/util.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'components/AccountListItem.dart';
import 'components/AvatarWidget.dart';
import 'components/BirthdayWidget.dart';
import 'provider/accountPage.p.dart';

/// 帐号资料
class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String uuid = '108623512';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('帐号资料'),
      ),
      body: Container(
        color: Colors.red,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AvatarWidget(),
            AccountListItem(
              title: 'UUID',
              trailing: Text(uuid),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: uuid));
                Util.toastTips('UUID号已复制到粘贴板');
              },
            ),
            AccountListItem(
              title: '出生年月日',
              trailing: Consumer<AccountPageStore>(
                builder: (context, store, __) {
                  String _formatMydate = '';
                  if (store.selectDate != null) {
                    _formatMydate =
                        formatDate(store.selectDate, [yyyy, '-', mm, '-', dd]);
                  }
                  return Text(_formatMydate);
                },
              ),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return BirthdayWidget();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
