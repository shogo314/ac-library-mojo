from atcoder.method_traits import HasInitStringRaising


trait HasInitStringRaisingCollectionElement(
    HasInitStringRaising, CollectionElement
):
    pass


struct IO:
    var buff: String
    var idx: Int

    fn __init__(out self) raises:
        self.idx = 0
        with open("/dev/stdin", "r") as f:
            self.buff = f.read()

    fn ok(self, c: String) -> Bool:
        return c in String(
            "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!\22#$%&'()*+,-./:;<=>?@[\\]^_{|}~"
        )

    fn next(mut self) raises -> String:
        var res = List[String]()
        while self.idx < len(self.buff) and not self.ok(self.buff[self.idx]):
            self.idx += 1
        while self.idx < len(self.buff) and self.ok(self.buff[self.idx]):
            res.append(self.buff[self.idx])
            self.idx += 1
        return "".join(res)

    fn readline(mut self) raises -> String:
        var res = List[String]()
        while self.idx < len(self.buff):
            if self.buff[self.idx] == "\n":
                self.idx += 1
                break
            res.append(self.buff[self.idx])
            self.idx += 1
        return "".join(res)

    fn nextInt(mut self) raises -> Int:
        return Int(self.next())

    fn nextListInt(mut self, n: Int) raises -> List[Int]:
        var res = List[Int](capacity=n)
        for i in range(n):
            res.append(self.nextInt())
        return res

    fn nextList[
        T: HasInitStringRaisingCollectionElement
    ](mut self, n: Int) raises -> List[T]:
        var res = List[T](capacity=n)
        for i in range(n):
            res.append(T(self.next()))
        return res

    @staticmethod
    fn print[S: WritableCollectionElement](v: List[S]):
        for i in range(len(v)):
            if i:
                print(" ", end="")
            print(v[i], end="")
        print()
