module Zipcode exposing (isValid)

import String
import Char exposing (isDigit)


isValid : String -> Bool
isValid zipcode =
    if String.length zipcode /= 5 then
        False
    else if String.all isDigit zipcode && zipcode /= "66666" then
        True
    else
        False
