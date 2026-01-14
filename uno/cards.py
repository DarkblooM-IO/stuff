class Card:
    def __init__(self, value: int, color: str) -> None:
        self.value = value
        self.color = color
        self.name = f"{color} {value}"

    def __str__(self) -> str:
        return self.name

class Draw2(Card):
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
        super().__init__(50, chooseColor())
        self.name = f"{self.color} Wild"

class Wild4(Card):
    def __init__(self) -> None:
        super().__init__(50, chooseColor())
        self.name = f"{self.color} +4"
