//: Playground - noun: a place where people can play

import UIKit

func incrementArray(xs:[Int]) -> [Int] {
    var result:[Int] = []
    for x in xs {
        result.append(x + 1)
    }
    return result
}

func doubleArray1(xs:[Int]) -> [Int] {
    var result:[Int] = []
    for x in xs {
        result.append(x * 2)
    }
    return result
}

func computeIntArray(xs: [Int], transform:Int -> Int) -> [Int] {
    var result:[Int] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}

func doubleArray2(xs: [Int]) -> [Int] {
    return computeIntArray(xs){ x in x * 2 }
}

/*
func isEvenArray(xs: [Int]) -> [Bool] {
    computeIntArray(xs){ x in x % 2 == 0 }
}
 */

func computeBoolArray(xs: [Int], transform: Int -> Bool) -> [Bool] {
    var result: [Bool] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}

func genericComputeArray1<T>(xs: [Int], transform: Int -> T) -> [T] {
    var result: [T] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}

func map<Element, T>(xs: [Element], transform: Element -> T) -> [T] {
    var result: [T] = []
    for x in xs {
        result.append(transform(x))
    }
    return result
}


func genericComputerArray2<T>(xs: [Int], transform: Int -> T) -> [T] {
    return map(xs, transform: transform)
}

// 在transform参数中所使用的Element类型源自于Swift的Array中对Element所进行的泛型定义
extension Array {
    func map<T>(transform: Element -> T) -> [T] {
        var result: [T] = []
        for x in self {
            result.append(transform(x))
        }
        return result
        
    }
}

func genericComputeArray<T>(xs: [Int], transform: Int -> T) -> [T] {
    return xs.map(transform)
}

let exampleFiles = ["README.md", "HelloWorld.swift", "FlappyBird.swift"]
func getSwiftFiles(files: [String]) -> [String] {
    var result: [String] = []
    for file in files {
        if file.hasSuffix(".swift") {
            result.append(file)
        }
    }
    return result
}

getSwiftFiles(exampleFiles)

extension Array {
    func filter(includeElement: Element -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where includeElement(x) {
            result.append(x)
        }
        return result
    }
}

func getSwiftFile2(files:[String]) -> [String] {
    return files.filter { file in file.hasSuffix(".swift") }
}

getSwiftFile2(exampleFiles)

func sum(xs: [Int]) -> Int {
    var result: Int = 0
    for x in xs {
        result += x
    }
    return result
}

sum([1, 2, 3, 4])

func product(xs: [Int]) -> Int {
    var result: Int  = 1
    for x in xs {
        result = x * result
    }
    return result
}

func concatenate(xs: [String]) -> String {
    var result: String = ""
    for x in xs {
        result += x
    }
    return result
}

func prettyPrintArray(xs: [String]) -> String {
    var result: String = "Entries in the array xs:\n"
    for x in xs {
        result = " " + result + x + "\n"
    }
    return result
}

prettyPrintArray(["a", "b", "c"])

extension Array {
    func reduce<T>(initial: T, combine:(T, Element) -> T) -> T {
        var result = initial
        for x in self {
            result = combine(result, x)
        }
        return result
    }
}

func sumUsingReduce(xs: [Int]) -> Int {
    return xs.reduce(0) { result, x in result + x }
}

func productUsingReduce(xs: [Int]) -> Int {
    return xs.reduce(1, combine: *)
}

func concatUsingReduce(xs: [String]) -> String {
    return xs.reduce("", combine: +)
}

func flatten<T>(xss: [[T]]) -> [T] {
    var result: [T] = []
    for xs in xss {
        result += xs
    }
    return result
}

func flattenUsingReduce<T>(xss: [[T]]) -> [T] {
    return xss.reduce([]) { result, xs in result + xs }
}

extension Array {
    func mapUsingReduce<T>(transform: Element -> T) -> [T] {
        return reduce([]) { result, x in
            return result + [transform(x)]
        }
    }
    
    func filterUsingReduce(includeElement: Element -> Bool) -> [Element] {
        return reduce([]) { result, x in
            return includeElement(x) ? result + [x] : result
        }
    }
}

struct City {
    let name: String
    let population: Int
}

let paris = City(name: "Paris", population: 2241)
let madrid = City(name: "Madrid", population: 3165)
let amsterdam = City(name: "Amsterdam", population: 827)
let berlin = City(name: "Berliin", population: 3562)
let cities = [paris, madrid, amsterdam, berlin]

extension City {
    func cityByScalingPopulation() -> City {
        return City(name: name, population: population * 1000)
    }
}

cities.filter { $0.population > 1000 }
    .map { $0.cityByScalingPopulation() }
    .reduce("City: Population") { result, c in
        return result + "\n" + "\(c.name):\(c.population)"
    }

infix operator >>> { associativity left }
func >>> <A, B, C>(f: A -> B,g: B -> C) -> A -> C {
    return { x in g(f(x)) }
}
