# FSA
Finite State Automaton written in Swift.

Enter each state of the deterministic FSA into your console by listing the transitions for inputs of 0 and 1 seperated by spaces. Optionally followed by a * to indicate that the state is accepting. The following example is for an FSA that accepts an odd number of 1's.

```swift
Creating new FSA  0 1 *
-----------------------
Creating State #0 0 1 
Creating State #1 1 0 *
```

The FSA will know you have finsihed inputing your states as there is no more accessiable states. From here the equivalent states will be printed to your terminal.

You can continue to input strings of 0's and 1's and the FSA will print whether that string was accepted or rejected.

```swift
Input string to test (n for new machine.)
Input: 0000000001
ACCEPT
Input: 11
REJECT
```

When you want to create a new FSA simply type "n" as in the input.
