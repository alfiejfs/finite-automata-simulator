module Automaton (Character, Alphabet, State(..), Automaton(..)) where


type Character = String

-- Represents the alphabet over which an automaton can operate
type Alphabet = [Character]



newtype State = State { 
    getIdentifier :: String
} deriving (Show, Eq)

class Automaton a where
    runAutomaton :: a -> String -> Bool
