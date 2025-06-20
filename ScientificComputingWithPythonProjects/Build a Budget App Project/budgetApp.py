class Category:
    def __init__(self, name):
        self.name = name
        self.ledger = []

    def deposit(self, amount, description=""):
        self.ledger.append({"amount": amount, "description": description})

    def withdraw(self, amount, description=""):
        if self.check_funds(amount):
            self.ledger.append({"amount": -amount, "description": description})
            return True
        return False

    def get_balance(self):
        return sum(item["amount"] for item in self.ledger)

    def transfer(self, amount, category):
        if self.check_funds(amount):
            self.withdraw(amount, f"Transfer to {category.name}")
            category.deposit(amount, f"Transfer from {self.name}")
            return True
        return False

    def check_funds(self, amount):
        return amount <= self.get_balance()

    def __str__(self):
        title = f"{self.name:*^30}\n"
        items = ""
        for entry in self.ledger:
            desc = entry["description"][:23]
            amt = f"{entry['amount']:.2f}"
            items += f"{desc:<23}{amt:>7}\n"
        total = f"Total: {self.get_balance():.2f}"
        return title + items + total


def create_spend_chart(categories):
    # Calculate total spent per category
    spent = []
    for cat in categories:
        total = 0
        for item in cat.ledger:
            if item["amount"] < 0:
                total += -item["amount"]
        spent.append(total)
    total_spent = sum(spent)
    # Calculate percentage spent per category
    percents = [int((s / total_spent) * 10) * 10 for s in spent]
    # Chart header
    res = "Percentage spent by category\n"
    for i in range(100, -1, -10):
        res += f"{i:>3}|"
        for p in percents:
            res += " o " if p >= i else "   "
        res += " "
        res += "\n"
    res += "    " + "-" * (len(categories) * 3 + 1) + "\n"
    # Category names vertically
    maxlen = max(len(cat.name) for cat in categories)
    names = [cat.name.ljust(maxlen) for cat in categories]
    for i in range(maxlen):
        res += "     "
        for name in names:
            res += f"{name[i]}  "
        res += "\n"
    return res.rstrip("\n")


if __name__ == "__main__":
    Category()
    create_spend_chart()