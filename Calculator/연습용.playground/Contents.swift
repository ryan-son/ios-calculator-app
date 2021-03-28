var a: String = "안녕"
var b: String = "하세요"

func subtractAllElements() -> Int {
    let sumResult: Int = list.reduce((list.first ?? 0) * 2) { (result, currentItem) -> Int in
        print(result, currentItem)
        return result - currentItem
    }
    
    return sumResult
}

var list: [Int] = [1, 2, 3, 4, 5]

subtractAllElements()
