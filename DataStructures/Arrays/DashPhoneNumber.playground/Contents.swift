import UIKit

/*
 We are given a string S representing a phone number, which we would like to reformat. String S consists of N characters: digits, spaces, and/or dashes. It contains at least two digits.
 
 Spaces and dashes in string S can be ignored. We want to reformat the given phone number is such a way that the digits are grouped in blocks of length three, separated by single dashes. If necessary, the final block or the last two blocks can be of length two.
 
 For example:
 
 S = "00-44   48 5555 8361" should become
     "004-448-555-583-61"
 
 Assume:
 - S consists only of digits (0-9), spaces, and/or dashses (-)
 - S containts at least two digits
 
 Translate:
 
 Would like to reformat a phone number string so that:
 - every third char is a "-"
 - spaces and dashes don't matter
 - if the block ends in anything other than -xxx or -xx reformat to a block of two like xx-xx (not obvious)
 
 */
func solution(S : String) -> String {
    validateNumbers(string: S)
    return ""
}

func validateNumbers(string: String) -> String {
    var finalString: String = ""
    var quantity = -2
    for character in string {
        if ("0"..."9").contains(character) {
            finalString += String(character)
            
            if quantity % 3 == 0 {
                finalString += String("-")
            }
            quantity += 1
        }
    }
    print(finalString)
    return "valor"
}

solution(S:"123456789")           // 123-456-789
solution(S:"555372654")           // 555-372-654
solution(S: "0 - 22 1985--324")    // 022-198-53-24

// Edge cases
solution(S:"01")                          // 01
solution(S:"012")                         // 012
solution(S:"0123")                        // 01-23
solution(S:"0123       444")              // 012-34-44
solution(S:"------0123       444")        // 012-34-44
