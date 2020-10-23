import 'dart:io';
import 'package:baixing/pages/AccountPage/provider/accountPage.p.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart' show Provider, Consumer;
import 'AccountListItem.dart';

/// 头像
class AvatarWidget extends StatefulWidget {
  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  AccountPageStore accountPageStore;

  // 调用相册选择图像功能
  void pickAsset() async {
    // var imgList = await PhotoPicker.pickAsset(
    //   context: context,
    //   themeColor: Theme.of(context).primaryColor, // 标题颜色和底部的颜色
    //   padding: 1.0, // 每个元素内边距
    //   dividerColor: Colors.grey, // 分频器的颜色
    //   disableColor: Colors.grey.shade300, // 复选框禁用的颜色
    //   itemRadio: 0.88, // 内容高度占比0.01-1之间,1为图片正常比例
    //   maxSelected: 1, // 最大选择数量
    //   provider: I18nProvider.chinese, // 默认选择中国，定义显示语言
    //   textColor: Colors.white, // 文本字体颜色
    //   sortDelegate: SortDelegate.common,
    //   pickType: PickType.all, // 文件可选择类型 all/image/video

    //   // 预览勾选图片页面 自定义右下角复选框
    //   checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
    //     activeColor: Colors.white, // 勾选后背景填充色
    //     unselectedColor: Colors.yellow, // 勾选框边框颜色
    //     checkColor: Colors.black, // 勾选后 打勾的颜色
    //   ),
    // );
    // imgList[0].file.then((v) {
    //   accountPageStore.saveAvatarImg(v);
    // });
    File _file = await ImagePicker.pickImage(source: ImageSource.gallery);
    accountPageStore.saveAvatarImg(_file);
  }

  @override
  Widget build(BuildContext context) {
    accountPageStore = Provider.of<AccountPageStore>(context);

    return AccountListItem(
      height: 160,
      title: '头像',
      trailing: _avatar(),
      onTap: pickAsset, // 点击事件
    );
  }

  /// 头像组件
  Widget _avatar() {
    ImageProvider _imgBg;
    if (accountPageStore.avatarImg == null) {
      _imgBg = ImageUtils.getNetWorkImage(
          'https://i.keaitupian.net/up/fe/98/d9/884ada56623a11f6a0f38ab29fd998fe.jpg');
    } else {
      _imgBg = FileImage(accountPageStore.avatarImg);
    }

    return Container(
      width: ScreenUtil().setWidth(130),
      height: ScreenUtil().setHeight(130),
      child: Consumer<AccountPageStore>(
        builder: (_, store, __) {
          return CircleAvatar(
            foregroundColor: Colors.cyan,
            radius: 30, // 圆的直径
            backgroundColor: Colors.transparent, // 背景颜色
            backgroundImage: _imgBg,
          );
        },
      ),
    );
  }
}
