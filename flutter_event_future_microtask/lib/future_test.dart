

import 'dart:async';

/// 用 async和 await 组合，即可向event queue 中插入 event 实现异步操作。那为什么还会有Future呢？
/// 其实，Future最主要的功能就是提供了链式调用。

/// 多个Furure的执行顺序
/// 1.规则一： Future的执行顺序为Future的EventQueue的排列顺序。类似于JAVA中的队列，先进先出。
/// 2.规则二： 当任务需要延迟执行时，可以使用 new Future.delay() 来将任务延迟执行
/// 3.规则三： Future如果执行完才添加then，该任务会被放入microTask，当前Future执行完会执行microTask，
///  microTask 为空后才会执行下一个Future。
/// 4.规则四： Future是链式调用，意味着Future的then未执行完，下一个then不会执行。

class FutureTest {
  void FutureThentest() {
    new Future (()=> print('拆分任务_1'))
        .then((value) => print('拆分任务_2'))
        .then((value) => print('拆分任务_3'))
        .whenComplete(() => print('任务完成'));
  }


  /// 多个future 事件执行
  void multiFutureExeTest() {
    Future f1 = Future(() => print('f1'));
    Future f2 = Future(() => null);
    Future f3 = Future.delayed(Duration(seconds: 1), () {
      print('f3');
    });

    Future f4 = Future(() => null);
    Future f5 = Future(() => null);

    f5.then((_) => print('f5'));
    f4.then((value) {
      print('f4 - then1');
      new Future(() => print("f4 - new Future event"));
      f2.then((value) {
        print('f2 - then2');
      });
    });

    f2.then((value) => print('f2 - then1'));

    print('f8');

    /// 上面的代码执行完输出结果为：
    // flutter: f8
    // flutter: f1
    // flutter: f2 - then1
    // flutter: f4 - then1
    // flutter: f2 - then2
    // flutter: f5
    // flutter: f4 - new Future event
    // flutter: f3

    /// 分析：
    /// 1.首先执行main的代码，所以首先输出f8
    /// 2.然后参考上面的规则1，Future1到5是按初始化顺序放入到EventQueue 中，所以依次执行Future1 到5， 所以输出结果：8，1，f2 - then1
    /// 3.参考规则2，f3 延迟执行，一定是在最后一个：8，1，f2 - then1   。。。 f3
    /// 4.在f4 中，首先输出f4 - then1:  8，1，f2 - then, f4 - then1 ... f3
    /// 5.在f4的then方法块中，新建了Future，所以新建的Future将在EventQueue尾部，最后被执行：
    ///   8，1，f2 - then, f4 - then1， ... f4 - new Future event，f3
    /// 6.在f4 的then方法块中，给f2添加了then，但此时f2已经执行完了，参考规则3，所以then中的代码会被放到microTask 中，在当前Future执行
    /// 完成后执行。因为此时Future4 已经执行完毕了，所以会处理microTask(microTask的优先级高)。结果：
    ///   8，1，f2 - then, f4 - then1，f2 - then2 ... f4 - new Future event,f3
    /// 7.最终，我们的结果就是： 8，1，f2 - then, f4 - then1，f2 - then2 ... f4 - new Future event,f3
  }

  /// 多Future和microTask的执行顺序
  /// 优先级顺序： main > MicroTask > EventQueue
  void testMultiMicrotask() {
    scheduleMicrotask(() => print('Mission_1'));

    /// 注释1
    Future.delayed(Duration(seconds: 1), (){
      print('Mission_2');
    });

    /// 注释2.
    ///
    Future(() => print('Mission_3')).then((_){
      print('Mission_4');
      scheduleMicrotask(() => print('Mission_5'));
    }).then((_) => print('Mission_6'));

    /// 注释3
    /// 这里在第一个then中创建了一个Future, 这个Future 将会被添加到EventQueue的最后，
    /// 所以第二个then 将不再执行，因为这个链路被阻塞了。
    ///
    Future(() => print('Mission_7'))
    .then((_) => Future(() => print('Mission_8')))
    .then((_) => print('Mission_9'));

    /// 注释4
    Future(() => print('Mission_10'));

    scheduleMicrotask(() => print('Mission_11'));

    print('Mission_12');


    /// 输出结果为：
    // flutter: Mission_12
    // flutter: Mission_1
    // flutter: Mission_11
    // flutter: Mission_3
    // flutter: Mission_4
    // flutter: Mission_6
    // flutter: Mission_5
    // flutter: Mission_7
    // flutter: Mission_10
    // flutter: Mission_8
    // flutter: Mission_9
    // flutter: Mission_2
  }

}