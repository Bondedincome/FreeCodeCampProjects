def add_time(start, duration, day=None):
    # Parse start time
    start_time, period = start.split()
    start_hour, start_minute = map(int, start_time.split(':'))
    duration_hour, duration_minute = map(int, duration.split(':'))

    # Convert start to 24-hour format
    if period == 'PM' and start_hour != 12:
        start_hour += 12
    if period == 'AM' and start_hour == 12:
        start_hour = 0

    # Add duration
    end_minute = start_minute + duration_minute
    end_hour = start_hour + duration_hour + end_minute // 60
    end_minute = end_minute % 60

    # Calculate days later
    days_later = end_hour // 24
    end_hour = end_hour % 24

    # Convert back to 12-hour format
    if end_hour == 0:
        display_hour = 12
        display_period = 'AM'
    elif end_hour < 12:
        display_hour = end_hour
        display_period = 'AM'
    elif end_hour == 12:
        display_hour = 12
        display_period = 'PM'
    else:
        display_hour = end_hour - 12
        display_period = 'PM'

    # Handle day of week
    days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    if day:
        day_index = days.index(day.capitalize())
        new_day = days[(day_index + days_later) % 7]
        day_str = f', {new_day}'
    else:
        day_str = ''

    # Handle days later string
    if days_later == 1:
        later_str = ' (next day)'
    elif days_later > 1:
        later_str = f' ({days_later} days later)'
    else:
        later_str = ''

    res = f"{display_hour}:{end_minute:02d} {display_period}{day_str}{later_str}"
    return res

if __name__ == "__main__":
    add_time

# print(add_time('3:00 PM', '3:10'))
# print(add_time('6:30 PM', '205:12'))
#### Returns: 6:10 PM