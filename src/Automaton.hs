module Automaton (Character, Alphabet, Input, State(..), ComputationStep(..), Automaton(..)) where

-- Represents a character that can be taken as input by an Automaton
type Character = String

type Input = [Character]

-- Represents the alphabet over which an automaton can operate
type Alphabet = [Character]

newtype State = State { 
    getIdentifier :: String
} deriving (Show, Eq)

data ComputationStep = Error String | Termination Bool | ComputationStep State

class Automaton a where
    runAutomaton :: a -> Input -> ComputationStep
