#!/usr/bin/env python3

### WIP ###

import random

class Card:
    def __init__(self):
        self.value = random.randint(0,9)
        self.color = random.choice(["red","green","blue","yellow"])

    def __str__(self):
        return f"{self.value if self.__class__.__name__ == 'Card' else self.__class__.__name__} {self.color}"

    def matchCard(self, card):
        return self.color == card.color or (self.__class__.__name__ == card.__class__.__name__ and self.value == card.value)

class Player:
    def __init__(self):
        self.deck = [Card() for _ in range(7)]
        self.sortDeck()

    def __str__(self):
        return "\n".join(str(c) for c in self.deck)

    def sortDeck(self): # sorts only by value for now, should sort by color first, then sort colors by value
        self.deck = sorted(self.deck, key=lambda card: card.value)

def main():
    players = [Player(), Player(), Player(), Player()]
    index = 0
    stack = Card()

    print(f"Start: {stack}")

    while True:
        p = players[index]
        played = False
        for c in p.deck:
            if c.matchCard(stack):
                stack = c
                p.deck.remove(c)
                played = True
                print(f"{index+1} --> {c}")
                break

        if not played:
            p.deck.append(Card())

        end = False
        for p in players:
            if not p.deck:
                end = True
        if end:
            break

        index = index+1 if index < len(players)-1 else 0

    for i in range(len(players)):
        if len(players[i].deck) == 0:
            print(f"{i+1} wins")
            break

if __name__ == "__main__":
    main()
