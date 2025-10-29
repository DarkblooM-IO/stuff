#!/usr/bin/env python3

#######
# WIP #
#######

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
        self.sortDeck()

    def __str__(self):
        return "\n".join(self.deck)

    def sortDeck(self):
        self.deck = self.deck.sort(key=lambda card: card.value)

def main():
    print(Player())

if __name__ == "__main__":
    main()
