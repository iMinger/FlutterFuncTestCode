

/// case1

class A {
  String getMessage() => 'A';
}

class B {
  String getMessage() => 'B';
}

class P {
  String getMessage() => 'P';
}

class AB extends P with A, B {}

class BA extends P with B, A {}

class WithClassTest {

  void test() {
    String result = '';
    AB ab = AB();
    result += ab.getMessage();

    BA ba = BA();
    result += ba.getMessage();

    /// 输出BA
    /// 从这里可以看到，with A B
    /// mixin 具有线性化特性。
    /// with 后面的类会覆盖前面的类的同名方法。类似于iOS 中的分类，多个分类中含有相同的方法，那么处在编译文件顺序后面的分类中的方法会被执行。
    ///
    print("result = $result");
  }
}