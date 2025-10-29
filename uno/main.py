#!/usr/bin/env python3

### WIP ###

import random

class Card:
    def __init__(self):
        self.value = random.randint(0,9)
        self.color = random.choice(["red","green","blue","yellow"])

    def __str__(self):
        return f"{self.color} {self.value if self.__class__.__name__ == 'Card' else self.__class__.__name__}"

class Player:
    def __init__(self):
        self.deck = [Card() for _ in range(7)]

    def __str__(self):
        return "\n".join(str(c) for c in self.deck)

def main():
    print(Player())

if __name__ == "__main__":
    main()
