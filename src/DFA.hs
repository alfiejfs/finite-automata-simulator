module DFA (DFA(..)) where

import Automaton
import qualified Control.Monad.State as S

-- A deterministic finite automaton (DFA) is a 5-tuple {
--  The states Q
--  The alphabet \Sigmaa
--  The transition function \delta
--  The start state q_0
--  The accept states F
-- }
data DFA = DFA { 
    states :: [State]
  , alphabet :: Alphabet
  , transition :: State -> Character -> Maybe State
  , startState :: State
  , acceptStates :: [State]
}

-- Represents the final result of a DFA computation.
-- Left is an error message for a computation that failed to calculate.
-- Right is whether the computation was an accept or a reject on the DFA 
type ComputationResult = Either String Bool 

-- Represents a step after a computation in a DFA
-- ComputationResult is when the computation is finished
-- State is when the computation has more to do
type ComputationStep = Either ComputationResult State

-- Represents a computation over an input string
type DFAComputation = S.State [Character]

stepDFA :: DFA -> State -> DFAComputation ComputationStep
stepDFA dfa state = do
    inputs <- S.get 
  
    let nextState = transition dfa state $ head inputs
    
    case nextState of 
        Nothing -> return $ Left $ Right $ state `elem` acceptStates dfa
        Just s -> do
            S.put $ tail inputs
            return $ Right s
