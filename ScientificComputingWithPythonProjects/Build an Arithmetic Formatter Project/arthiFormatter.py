def arithmetic_arranger(problems, show_answers=False):
    if len(problems) > 5:
        return 'Error: Too many problems.'

    first_line = []
    second_line = []
    dashes = []
    answers = []

    for problem in problems:
        parts = problem.split()
        if len(parts) != 3:
            return "Error: Each problem must have two operands and one operator."

        left, operator, right = parts

        # Validate operator
        if operator not in ['+', '-']:
            return "Error: Operator must be '+' or '-'."

        # Validate digits
        if not (left.isdigit() and right.isdigit()):
            return "Error: Numbers must only contain digits."

        # Validate length
        if len(left) > 4 or len(right) > 4:
            return "Error: Numbers cannot be more than four digits."

        width = max(len(left), len(right)) + 2  # one for operator, one for space

        first_line.append(left.rjust(width))
        second_line.append(operator + right.rjust(width - 1))
        dashes.append('-' * width)

        if show_answers:
            result = str(eval(problem))
            answers.append(result.rjust(width))

    # Join with 4 spaces in between
    arranged = '    '.join(first_line) + '\n' + '    '.join(second_line) + '\n' + '    '.join(dashes)
    if show_answers:
        arranged += '\n' + '    '.join(answers)

    return arranged

# print(f'\n{arithmetic_arranger(["32 + 698", "3801 - 2", "45 + 43", "123 + 49"])}')

if __name__ == "__main__":
    arithmetic_arranger