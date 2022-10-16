import UIKit

let itemPrices = [ 10, 2.99, 10.99, 32.99, 8.99, 15.99, 29.99 ]

let totalAmount = itemPrices.reduce(0, +)

let discountPercentage = 0.05

enum DiscountType: Double, CaseIterable, Comparable {
    static func < (lhs: DiscountType, rhs: DiscountType) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    case `default` = 0.05
    case thanksgiving = 0.10
    case christmas = 0.15
    case newYears = 0.20
    
    func printDiscount() {
        print("\(self.rawValue * 100)% discount for \(self)" )
    }
    
}


let discountedAmount = totalAmount * discountPercentage

let totalAmountAfterDiscount = totalAmount - discountedAmount

/*
 
Assignment 1:  Function
- Create a function with 2 parameters: totalAmount and discountPercentage (5%, 10% and so on).
- Calculate the discountedAmount and subtract this from the totalAmount (using formulae above).
- Return the totalAmountAfterDiscount.
 
*/


func getDiscount(totalAmount: Double, discountPercentage: Double) -> Double {
    return totalAmount * discountPercentage
}

getDiscount(totalAmount: 100.00, discountPercentage: 0.05)

/*
 
Assignment 2: Function
- Modify the function above to now take in a default discount percentage that will be applied by default to all.
Hint: Use function overloading.
 
*/

func getDiscount(totalAmount: Double, discountPercentage: DiscountType = .default) -> Double {
    return totalAmount * discountPercentage.rawValue
}

getDiscount(totalAmount: 100.00, discountPercentage: DiscountType.default.rawValue)

/*
 
Assignment 3: typealias
- Create a typealias for a function type that takes in totalAmount and discount type as parameters. It returns the totalAmountAfterDiscount.
Hint: (Double, String) -> Double

Now create a printDiscount function to print the totalAmountAfterDiscount for all discount types. It takes function type (typealias) as a parameter:

 */

typealias CalculateDiscount = (Double, DiscountType) -> Double

let printDiscount: CalculateDiscount = { total, discountType in
    return total - (total * discountType.rawValue)
}

let discountTypes: [DiscountType] = [ .default, .thanksgiving, .christmas, .newYears ]

discountTypes.forEach { type in
    print(printDiscount(totalAmount, type))
}

/*
 
 Assignment 4: Closure
 - Create a closure that calculates the discount. Closures takes parameters as: total amount, discount type and subtracts discounted amount from total amount and prints the total amount after discount.
 1. Hint: Based on the discount type, get a discount percentage. Based on this discount percentage, calculate discountedAmount. Print the totalAmountAfterDiscount.
 2. A single discount type.

 */

let total: CalculateDiscount = { total, discountType in
    return total - (total * discountType.rawValue)
}

total(totalAmount, .newYears)

/*
 
 Assignment 5: Map
 - Take itemPrices. Let’s say the prices of all of these items are to be increased by 50%.
 Multiply each element in an array with 0.5. Print the new item price.
 For example: Price of item 1 is $100. Price of item 1 is to be increased by 50% (that’s $100 * 0.5 = $50).
 The new price of item 1 is now $150.
 Hint: Use Swift’s map

 */

let increasedItemPriceBy50Percent = itemPrices.map { item in
    item + (item * 0.5)
}

print(increasedItemPriceBy50Percent)

/*
 
 Assignment 6: Sorted
 Create a (Discount types) dictionary (with discount type and percentage amount). Sort this dictionary from highest discount to lowest discount.
 Hint: Use Swift’s sorted.

 */

let discountTypeDictionary: [ DiscountType : Double ] = [
    .default :  0.05 ,
    .thanksgiving : 0.10,
    .christmas :  0.15,
    .newYears : 0.20
]

discountTypeDictionary.values.sorted(by: >)

/*
 
Assignment 7: Enums and Switch cases
- Use enums for discount types.
- Create a function printDiscount to print the value for discount types. Use switch cases and enums to do this.

*/

func printDiscount(for discountType: DiscountType) {
    switch discountType {
    case .default:
        print("\(discountType.rawValue * 100)% Discount")
    case .thanksgiving:
        print("\(discountType.rawValue * 100)% Discount")
    case .christmas:
        print("\(discountType.rawValue * 100)% Discount")
    case .newYears:
        print("\(discountType.rawValue * 100)% Discount")
    }
}

printDiscount(for: .newYears)


/*
 
 Assignment 8: Computed property
 - Create a computed property: currentDiscountedAmount that returns the current discounted amount that you apply on the itemPrices.
 For example: you have a subset of itemPrices that the user chooses to buy (of course, at a later point, you can hardcode this chosen itemPrices subset for now). Based on the season - let’s say right now, there is a Christmas sale going on and a discount (of 15%) is applied to the itemPrices in this season. Then the currentDiscountedAmount = totalAmountAfterDiscount.
 Hint:
 Properties belong to a named type like: struct, class, enum.
 Use the same formula for currentDiscountedAmount as in totalAmountAfterDiscount. :]
 You can simplify and create a single value in an array or a single value itself. We are fine as long as it’s a computed property. :]

 
 */

struct Discounter: Discount {
    let total: Double
    let discountType: DiscountType
    
    var totalAmountAfterDiscount: Double {
        total - (total * discountType.rawValue)
    }
    
    /*
     
    Assignment 9: Lazy property
    - Create a lazy property that returns the maximum discount that can be applied.
     
    */
    lazy var maxDiscount = DiscountType.allCases.max()
    
    // Assignment 10
    func calculateDiscount() -> Double {
        return total - (total * discountType.rawValue)
    }
    
}

var myChristmasDiscount = Discounter(total: 99.99, discountType: .christmas)
myChristmasDiscount.totalAmountAfterDiscount

myChristmasDiscount.maxDiscount

/*
 
Assignment 10: Method
- Create a method that calculates and returns totalAmountAfterApplyingDiscount.
Hint: Method belongs to a class/ struct/ enum.
 
*/

myChristmasDiscount.calculateDiscount()

/*
 
Assignment 11: Protocol
- Create a protocol and class conforming to the protocol. For example: Discount that has DiscountType and DiscountPercentage and a method to calculate discount.
Hint:
Create a protocol as a template. Create a class conforming to this protocol.
Please create what is needed for your protocol/ class.

*/

protocol Discount {
    func calculateDiscount() -> Double
}

/*
 
Assignment 12: Extension
- Create an extension that rounds off the totalDiscountedAmount.
For example: Apply a logic if the totalDiscountedAmount = 50.6, it rounds off to 51 (decimal >= 0.5) and if the totalDiscountedAmount < 0.5, it rounds off to 50 (decimal < 0.5)
Hint:
1. Double amount is rounded off to a closest int.
2. You can create a class/ struct (it’s OK if it’s empty as well) and segregate the code related to rounding logic in the extension.
 
*/

extension Discounter {
    func roundOffTotal() -> Double {
        return totalAmountAfterDiscount.rounded()
    }
}


print(myChristmasDiscount.roundOffTotal())
