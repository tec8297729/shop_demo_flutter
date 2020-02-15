import 'package:baixing/pages/AccountPage/provider/accountPage.p.dart';
import 'package:baixing/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

/// 生日选择弹层组件
class BirthdayWidget extends StatefulWidget {
  @override
  _BirthdayWidgetState createState() => _BirthdayWidgetState();
}

class _BirthdayWidgetState extends State<BirthdayWidget>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  int _indexedStack = 0; // 选中的日历叠加层
  // 定义某些天的含义假期,在自定义builder函数中能读取到
  final Map<DateTime, List> _holidays = {
    DateTime(2019, 11, 1): ['New Year\'s Day', '光棍节'],
    DateTime(2019, 11, 6): ['Epiphany'],
    DateTime(2019, 12, 14): ['Valentine\'s Day'],
    DateTime(2019, 4, 21): ['Easter Sunday'],
    DateTime(2020, 2, 11): ['Easter Monday'],
  };
  Map<DateTime, List> _events;
  DateTime _selectDate = DateTime.now(); // 选中的时间
  List<String> weekData = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
  AccountPageStore accountPageStore;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    // 自定义事件内容,key:value形式,key哪天的时间戳
    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['A0', 'B0', 'C0'],
      _selectedDay.subtract(Duration(days: 20)): ['A2', 'B2', 'C2', 'D2'],
      _selectedDay.subtract(Duration(days: 16)): ['A3', 'B3'],
      _selectedDay.subtract(Duration(days: 10)): ['A4', 'B4', 'C4'],
      _selectedDay.subtract(Duration(days: 2)): ['A6', 'B6'],
    };

    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    accountPageStore = Provider.of<AccountPageStore>(context);
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(80),
            color: Colors.white,
            child: Text(
              '生日选择',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Colors.black,
                letterSpacing: 5,
              ),
            ),
          ),
          _tableCalendarHeader(),
          _calendarStack(),
          _bottomWidget(),
        ],
      ),
    );
  }

  /// 日历扩展头部组件
  Widget _tableCalendarHeader() {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.fromLTRB(30, 14, 30, 0),
      color: Colors.pink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _indexedStack = 1; // 显示年份叠加层
              });
            },
            child: Text(
              '1845年',
              style: TextStyle(fontSize: ScreenUtil().setSp(34)),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _indexedStack = 0;
              });
            },
            child: Text(
              '${_selectDate.month}月${_selectDate.day}日 ${weekData[_selectDate.weekday - 1]}',
              style: TextStyle(fontSize: ScreenUtil().setSp(60)),
            ),
          ),
        ],
      ),
    );
  }

  /// 日历内容区，切换显示不同内容
  Widget _calendarStack() {
    return Container(
      child: IndexedStack(
        index: _indexedStack,
        children: <Widget>[
          _tableCalendar(), // 日历
          // 年历
          Container(
            height: ScreenUtil().setHeight(600),
            child: YearPicker(
              selectedDate: _selectDate, // 当前选择的年份
              firstDate: DateTime(1970), // 最底年份
              lastDate: DateTime(2100), // 最高年份
              // 年份改变时触发事件
              onChanged: (DateTime dateTime) {
                setState(() {
                  _selectDate = dateTime;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 日历底部组件
  Widget _bottomWidget() {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: ScreenUtil().setHeight(80),
        decoration: BoxDecoration(
          color: Colors.white10,
          border: Border(
            top: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        child: Text('确定'),
      ),
      onTap: () {
        Util.toastTips('修改成功');
        accountPageStore.saveSelectDate(_selectDate);
        Navigator.pop(context);
      },
    );
  }

  /// 日历组件
  Widget _tableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      locale: 'zh_CN', // 日历语言
      holidays: _holidays, // 定义日历中某天的假期
      events: _events, // 指定某些天的事件,用于自定义构建获取内容

      weekendDays: [DateTime.saturday, DateTime.sunday], // 定义周末的二天
      initialCalendarFormat: CalendarFormat.month, // week显示一行, month显示当前月数所有行
      formatAnimation: FormatAnimation.scale, // 当available改变时动画
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all, // 指定可用手势
      // available显示的文字
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      // 点击头部事件,如果当前月份未选中天,默认显示1号
      onHeaderTapped: (DateTime day) {
        print(day);
      },

      /// 点击天数时触发事件
      onDaySelected: (DateTime day, List events) {
        setState(() {
          _selectDate = day;
        });
      },

      /// 日历内容样式
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400], // 选中时的北京颜色
        todayColor: Colors.blue,
        markersColor: Colors.cyanAccent,
        outsideDaysVisible: false, // 显示其它月份在当前日历中
      ),
      // 日历头部样式
      headerStyle: HeaderStyle(
        // 按钮的样式
        formatButtonTextStyle: TextStyle(color: Colors.white, fontSize: 15.0),
        // 按钮的修饰器
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
        centerHeaderTitle: true, // 是否居中标题
        formatButtonVisible: false, // 隐藏available按钮
      ),

      // 自定义显示日历
      builders: CalendarBuilders(
        // 用户选中的天组件
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        // 系统当天,显示的组件
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        // 自定义某些天标记
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          // 处理用户自定义的日历事件
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                // 把events数据单独处理,这是你自己定义的数据
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          // 判断有自定义的假期时,添加指定标记组件
          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children; // 返回一个数组,里面可以用定位组件
        },
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events[0]}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }
}
