import UIKit

struct Calculator {
    static func add<T: Numeric>(_ a: T, _ b: T) -> T {
        return a + b
    }
    
    static func subtract<T: Numeric>(_ a: T, _ b: T) -> T {
        return a - b
    }
    
    static func divide<T: BinaryFloatingPoint>(_ a: T, _ b: T) -> T? {
           guard b != 0 else { return nil }
           return a / b
       }
    
    static func multiply<T: Numeric>(_ a: T, _ b: T) -> T {
        return a * b
    }
}

var results: [Int] = []

// Integers
results.append(Calculator.add(10, 20))        // 30
results.append(Calculator.subtract(50, 120))   // -70
results.append(Calculator.multiply(6, 7))     // 42


//MARK: - Filter and sort
print(results)
var filteredResults = results.filter { $0 > 0 } // Filters out values less than or equal to 0
filteredResults.sort { $0 > $1 } // Sorts the array in descending order
print(filteredResults)

// Doubles
print(Calculator.add(2.5, 3.1))      // 5.6
print(Calculator.divide(10.0, 2.0)!) // 5.0
print(Calculator.divide(7.0, 0))     // nil (safe division)
