//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var x = 8/3

(7/3)*3

//let numbers = [[1, 2, 3], [4, 5, 6]]
//let flattenNumbers = numbers.reduce([], combine: +)

let numbers = [[[1,4,7],[2,3,8],[2,8,9]],[[1,4,7],[2,3,8],[2,8,9]],[[1,4,7],[2,3,8],[2,8,9]]]
let flattened = numbers.flatMap{$0}.flatMap{$0}
flattened.reduce(0, combine: +)

let w = [[[1.0,4.0,7.0]],[[2.0,8.0,9.0]],[[2.0,3.0,8.0],[2.0,8.0,9.0]]]
let sumw = 100.0
let q = w.map({ $0.map({ $0.map({ $0 / sumw }) }) })
print(q)

Double(arc4random()) / Double(UINT32_MAX)
let r = Double(arc4random()) / Double(UINT32_MAX)


let test = Array.init(0...9*9*9-1)
test.last

let n = 728
let k = n % 9
let j = ((n-k)/9)%9
let i = (((n-k)/9)-j)/9

i * 81 + j * 9 + k