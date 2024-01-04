module Automaton (Alphabet, State(..)) where

-- Represents the alphabet over which an automaton can operate
type Alphabet = [String]

newtype State = State { 
        getIdentifier :: String
} deriving (Show, Eq)
