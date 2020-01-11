import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// 流布局页面
class FlowLayout extends StatefulWidget {
  @override
  _FlowLayoutState createState() => _FlowLayoutState();
}

class _FlowLayoutState extends State<FlowLayout> {
  test() {
    return GridView.builder(
      scrollDirection: Axis.vertical, // 布局排列方向，默认horizontal横向
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100.0, // 每个元素的宽度
        mainAxisSpacing: 10.0, // 每个元素底部间隔
        crossAxisSpacing: 10.0, // 每个元素左右间隔大小
        childAspectRatio: 4.0, // // 按比例设置盒子大小（宽/高）
      ),
      itemCount: 22, // 总数量
      // 渲染布局的组件
      itemBuilder: (context, int index) {
        return Container(
          color: Colors.green,
          child: Center(
            child: CircleAvatar(
                backgroundColor: Colors.white, child: Text('$index')),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // return test();

    return Container(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4, // 几列布局
        itemCount: 7, // 总数量
        // 渲染布局的组件
        itemBuilder: (BuildContext context, int index) => Container(
          color: Colors.green,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('$index'),
            ),
          ),
        ),
        // 合并item方法，自定义合并主轴及次轴几格参数
        staggeredTileBuilder: (int index) {
          // 横向合并几列（主轴），纵向合并几个（第二个参数如果一样，就不是流布局了）
          // return StaggeredTile.count(2, index.isEven ? 2 : 1);
          // 默认不合并，每个item高度自然就是流布局
          return StaggeredTile.fit(2); // 单独定义 主轴方向合并方法，主轴是crossAxisCount参数
        },
        mainAxisSpacing: 14.0, // 每个元素底部间隔
        crossAxisSpacing: 4.0, // 每个元素左右间隔大小
      ),
    );
  }
}
