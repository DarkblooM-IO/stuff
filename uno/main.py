#!/usr/bin/env python3
import random

class Card:
    def __init__(self):
        self.value = random.randint(0,9)
        self.color = random.choice(["red","green","blue","yellow"])

class P2(Card):
    def __init__(self):
        pass

def main():
    card1 = Card()
    print(card1.value, card1.color)

if __name__ == "__main__":
    main()
