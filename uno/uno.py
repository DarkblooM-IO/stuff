#!/usr/bin/env -S python -OO
import random as rd

class Card:
    def __init__(self, value: int, color: str) -> None:
        self.value = value
        self.color = color
        self.name = f"{color} {value}"

    def __str__(self) -> str:
        return self.name

class DrawTwo(Card):
    def __init__(self) -> None:
        super().__init__(20, chooseColor())
        self.name = f"{self.color} +2"

class Skip(Card):
    def __init__(self) -> None:
        super().__init__(20, chooseColor())
        self.name = f"{self.color} Skip"

class Reverse(Card):
    def __init__(self) -> None:
        super().__init__(20, chooseColor())
        self.name = f"{self.color} Reverse"

class Wild(Card):
    def __init__(self) -> None:
        super().__init__(20, chooseColor())
        self.name = f"{self.color} Reverse"

def chooseColor() -> str:
    return rd.choice(["Red","Green","Blue","Yellow"])

def main() -> None:
    pass

if __name__ == "__main__":
    main()
