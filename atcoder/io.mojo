from atcoder.method_traits import HasInitStringRaising


struct IO[BUFF_SIZE: Int = 65536]:
    var f: FileHandle
    var buff: List[UInt8]
    var idx: Int

    fn __init__(out self) raises:
        constrained[BUFF_SIZE == -1 or BUFF_SIZE >= 1]()
        self.f = open("/dev/stdin", "r")
        self.idx = 0
        self.buff = self.f.read_bytes(Self.BUFF_SIZE)

    fn _ok(self, c: UInt8) -> Bool:
        if 0x21 <= Int(c) <= 0x7E:
            return True
        else:
            return False

    fn next(mut self) raises -> String:
        var tmp = List[UInt8]()
        while self.idx < len(self.buff) and not self._ok(self.buff[self.idx]):
            self.idx += 1
            if self.idx == len(self.buff):
                self.buff = self.f.read_bytes(Self.BUFF_SIZE)
                self.idx = 0
        while self.idx < len(self.buff) and self._ok(self.buff[self.idx]):
            tmp.append(self.buff[self.idx])
            self.idx += 1
            if self.idx == len(self.buff):
                self.buff = self.f.read_bytes(Self.BUFF_SIZE)
                self.idx = 0
        var res = String()
        res.write_bytes(tmp)
        return res

    fn readline(mut self) -> String:
        var tmp = List[UInt8]()
        while self.idx < len(self.buff):
            if self.buff[self.idx] == 0x0A:
                self.idx += 1
                break
            tmp.append(self.buff[self.idx])
            self.idx += 1
        var res = String()
        res.write_bytes(tmp)
        return res

    fn nextInt(mut self) raises -> Int:
        return Int(self.next())

    fn next[T: HasInitStringRaising & Copyable & Movable](mut self) raises -> T:
        return T(self.next())

    fn nextListInt(mut self, n: Int) raises -> List[Int]:
        var res = List[Int](capacity=n)
        for _ in range(n):
            res.append(self.nextInt())
        return res

    fn nextList(mut self, n: Int) raises -> List[String]:
        var res = List[String](capacity=n)
        for _ in range(n):
            res.append(self.next())
        return res

    fn nextList[
        T: HasInitStringRaising & Copyable & Movable
    ](mut self, n: Int) raises -> List[T]:
        var res = List[T](capacity=n)
        for _ in range(n):
            res.append(self.next[T]())
        return res

    @staticmethod
    fn print[S: Writable & Copyable & Movable](v: List[S]):
        for i in range(len(v)):
            if i:
                print(" ", end="")
            print(v[i], end="")
        print()
