module DFA (DFA(..)) where

import Automaton

-- A deterministic finite automaton (DFA) is a 5-tuple {
--  The states Q
--  The alphabet \Sigmaa
--  The transition function \delta
--      Returns Nothing if and only if the character was not in the Alphabet
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

instance Automaton DFA where
    runAutomaton dfa i = case final of
                            ComputationStep s -> Termination $ s `elem` acceptStates dfa
                            x -> x
                       where
                            foldFunc c (ComputationStep s) = stepDFA dfa s c
                            foldFunc _ x = x
                            final = foldr foldFunc (ComputationStep $ startState dfa) i

stepDFA :: DFA -> State -> Character -> ComputationStep
stepDFA dfa s c = let nextState = transition dfa s c
                  in case nextState of
                    Nothing -> Error $ "Character " ++ c ++ " not in alphabet."
                    Just n  -> ComputationStep n
