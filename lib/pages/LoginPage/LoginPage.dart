import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<Map<String, String>> message = [];
  @override
  void initState() {
    super.initState();
    message.addAll([
      for (var i = 0; i < 10; i++)
        {
          'title': '标题${i + 1}',
        }
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          itemCount: message.length,
          separatorBuilder: (context, int index) => Divider(), // 间隔组件
          itemBuilder: (context, int index) {
            return Dismissible(
              key: Key(message[index].toString()), // 确保唯一性key
              // 监听滑动完成后触发
              onDismissed: (DismissDirection direction) {
                // 返回用户滑动的事件，处理不同的业务逻辑
                // DismissDirection.startToEnd 从左向右滑动
                // endToStart 从右向左滑动
                // vertical 上下滑动
                // horizontal 左右滑动
                // endToStart 从右到左
                // startToEnd从左到右
                // up 向上滑动
                // down向下滑动
                setState(() {
                  message.removeAt(index);
                });
              },
              // 背景组件，滑动后显示的组件
              background: Container(
                color: Colors.green,
                // 这里使用 ListTile 因为可以快速设置左右两端的Icon
                child: ListTile(leading: Icon(Icons.bookmark)),
              ),
              // 向左边滑动时显示的背景组件，右侧显示的组件
              secondaryBackground: Container(
                color: Colors.red,
                child: ListTile(trailing: Icon(Icons.delete)),
              ),
              // 内容组件
              child: Container(
                height: 60,
                child: Text('${message[index]['title']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
