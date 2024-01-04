module DFA (DFA) where

import Automaton

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
        , transition :: State -> Char -> State
        , startState :: State
        , acceptStates :: [State]
}

runDfa :: DFA -> String -> Bool
runDfa dfa word =
        let finalState = foldr (flip $  transition dfa) (startState dfa) word
        in finalState `elem` acceptStates dfa
