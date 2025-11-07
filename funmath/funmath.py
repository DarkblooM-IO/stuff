def isPrime(x: int) -> bool:
    if x <= 1:
        return False
    for i in range(2, int(x**0.5)+1):
        if x % i == 0:
            return False
    return True

def gcd(x: int, y: int) -> int:
    cd = []
    for i in range(min(x,y)):
        if i == 0 or x % i != 0 or y % i != 0:
            continue
        cd.append(i)
    return sorted(cd, reverse=True)[0]

def collatz(x: int) -> list[int]:
    if x < 1:
        raise ValueError("x must be positive")
    out = []
    while x > 1:
        out.append(x)
        x = int(x / 2 if x % 2 == 0 else x * 3 + 1)
    return out
