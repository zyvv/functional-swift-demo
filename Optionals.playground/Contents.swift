//: Playground - noun: a place where people can play

import UIKit

let cities = ["Paris": 2241, "Madrid": 3165, "Amsterdam": 827, "Berlin": 3562]
let madridPopulation: Int? = cities["Madrid"]

if madridPopulation != nil {
    print("The population of Madrid is \(madridPopulation! * 1000)")
} else {
    print("Unkown city: Madrid")
}


if let madridPopulation = cities["Madrid"] {
    print("The population of Madrid is \(madridPopulation * 1000)")
} else {
    print("Unkown city: Madrid")
}

/*
infix operator ??
func ??<T>(optional: T?, defaultValue: T) -> T {
    if let x = optional {
        return x
    } else {
        return defaultValue
    }
}
 */


struct Order {
    let orderNumber: Int
    let person: Person?
}

struct Person {
    let name : String
    let address: Address?
}

struct Address {
    let streetName : String
    let city: String
    let state: String?
}

let order : Order = Order(orderNumber: 4, person: Person(name: "Jack", address: Address(streetName: "YueLu Road", city: "ChangSha", state: "HuNan")))
order.person!.address!.state!

if let myState = order.person?.address?.state {
    print("This order will be shipped to \(myState)")
} else {
    print("Unknown person,address,or state.")
}

// 为了在一个switch语句中匹配可选值，我们简单地为case分支中的每个模式添加一个?后缀。如果我们对一个特定值没有兴趣，也可以直接匹配Optional的None值或Some值
switch madridPopulation {
    case 0?: print("Nobody in Madrid")
    case (1..<1000)?: print("Less than a million in Madrid")
    case .Some(let x): print("\(x)people in Madrid")
    case .None: print("We don't know about Madrid")
}

func populationDescriptionForCity(city: String) -> String? {
    guard let population = cities[city] else { return nil }
    return "The population of Madrid is \(population * 1000)"
}

populationDescriptionForCity("Madrid")

func incrementOptional(optional: Int?) -> Int? {
    guard let x = optional else { return nil }
    return x + 1
}

extension Optional {
    func map<U>(transform: Wrapped -> U) -> U? {
        guard let x = self else { return nil }
        return transform(x)
    }
}

func incrementOptional2(optional: Int?) -> Int? {
    return optional.map { $0 + 1 }
}

let capitals = [
    "France": "Paris",
    "Spain": "Madrid",
    "The Netherlands": "Amsterdam",
    "Belgium": "Brussels"
]

func populationOfCapital(country: String) -> Int? {
    guard let capital = capitals[country], population = cities[capital] else { return nil }
    return population * 1000
}

extension Optional {
    func flatMap<U>(f: Wrapped -> U?) -> U? {
        guard let x = self else { return nil }
        return f(x)
    }
}

func addOptional2(optionalX: Int?, optionalY: Int?) -> Int? {
    return optionalX.flatMap { x in
        optionalY.flatMap { y in
            return x + y
        }
    }
}


func populationOfCapital2(country: String) -> Int? {
    return capitals[country].flatMap { capital in
        cities[capital].flatMap { population in
            return population * 1000
        }
    }
}

func populationOfCapital3(country: String) -> Int? {
    return capitals[country].flatMap { capital in
        return cities[capital]
        }.flatMap { population in
            return population * 1000
    }
}




