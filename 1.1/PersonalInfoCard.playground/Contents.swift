import UIKit

struct PersonalInfoCard {
    var name: String
    var age: Int
    var height: Double
    
    var phoneNumber: String?
    var linkedIn: String?
}

func printCard(card: PersonalInfoCard) {
    var isPhoneNumberExist: Bool {
        if let _ = card.phoneNumber {
            return true
        } else {
            return false
        }
    }
    
    var isLinkedInProvided: Bool {
        guard let _ = card.linkedIn else {
            return false
        }
        return true
    }
    
    """
    Name     : \(card.name)
    Age      : \(card.age)
    Height   : \(card.height)
    
    Phone    : \(isPhoneNumberExist ? card.phoneNumber! : "Not Provided")
    LinkedIn : \(isLinkedInProvided ? card.linkedIn! : "Not Provided")
    """
}

let card = PersonalInfoCard(name: "Ali Cihan Saraç", age: 29, height: 1.74, linkedIn: "alicihansarac")
printCard(card: card)

