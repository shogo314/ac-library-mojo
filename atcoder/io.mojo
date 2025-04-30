from atcoder.method_traits import HasInitStringRaising


trait HasInitStringRaisingCollectionElement(
    HasInitStringRaising, CollectionElement
):
    pass


struct IO[BUFF_SIZE: Int = -1]:
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
        var res = List[String]()
        while self.idx < len(self.buff) and not self._ok(self.buff[self.idx]):
            self.idx += 1
            if self.idx == len(self.buff):
                self.buff = self.f.read_bytes(Self.BUFF_SIZE)
                self.idx = 0
        while self.idx < len(self.buff) and self._ok(self.buff[self.idx]):
            res.append(chr(Int(self.buff[self.idx])))
            self.idx += 1
            if self.idx == len(self.buff):
                self.buff = self.f.read_bytes(Self.BUFF_SIZE)
                self.idx = 0
        return "".join(res)

    fn readline(mut self) -> String:
        var res = List[String]()
        while self.idx < len(self.buff):
            if self.buff[self.idx] == 0x0A:
                self.idx += 1
                break
            res.append(chr(Int(self.buff[self.idx])))
            self.idx += 1
        return "".join(res)

    fn nextInt(mut self) raises -> Int:
        return Int(self.next())

    fn nextListInt(mut self, n: Int) raises -> List[Int]:
        var res = List[Int](capacity=n)
        for _ in range(n):
            res.append(self.nextInt())
        return res

    fn nextList[
        T: HasInitStringRaisingCollectionElement
    ](mut self, n: Int) raises -> List[T]:
        var res = List[T](capacity=n)
        for _ in range(n):
            res.append(T(self.next()))
        return res

    @staticmethod
    fn print[S: WritableCollectionElement](v: List[S]):
        for i in range(len(v)):
            if i:
                print(" ", end="")
            print(v[i], end="")
        print()
