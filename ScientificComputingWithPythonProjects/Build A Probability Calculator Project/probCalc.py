import copy
import random

class Hat:
    def __init__(self, **kwargs):
        self.kwargs = kwargs 
        self.contents = [color for color, count in kwargs.items() for _ in range(count)]
    def draw(self, num_balls):
        if num_balls > len(self.contents):
            num_balls = len(self.contents)
        removed = []
        for _ in range(num_balls):
            if not self.contents:
                break
            idx = random.randrange(len(self.contents))
            removed.append(self.contents.pop(idx))
        return removed
    def get_total_balls(self):
        return len(self.contents)

def experiment(hat, expected_balls, num_balls_drawn, num_experiments):
    success_count = 0
    for _ in range(num_experiments):
        hat_copy = copy.deepcopy(hat)
        
        drawn = hat_copy.draw(num_balls_drawn)
        
        drawn_counts = {}
        for color in drawn:
            drawn_counts[color] = drawn_counts.get(color, 0) + 1
        
        success = True
        for color, count in expected_balls.items():
            if drawn_counts.get(color, 0) < count:
                success = False
                break
        if success:
            success_count += 1
    return success_count / num_experiments

hat1 = Hat( red=2, blue=3, green=1)

# print(type(hat1.kwargs))  # Should print <class '__main__.Hat'>
# print(hat1.kwargs)  # Should print <class '__main__.Hat'>
# print(hat1.contents)
# print(hat1.draw(3))  # Should print a list of 3 balls drawn from the hat
# print(hat1.get_total_balls())  # Should print the total number of balls in the hat
# print(hat1.contents) # Should print the remaining balls in the hat after drawing

if __name__ == "__main__":
    # import doctest
    # doctest.testmod()
    # print("Doctests passed.")
    Hat
    experiment