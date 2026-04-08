def convert_minutes(minutes):
    hours = minutes // 60
    mins = minutes % 60

    if hours > 0 and mins > 0:
        return f"{hours} hr {mins} minutes"
    elif hours > 0:
        return f"{hours} hr"
    else:
        return f"{mins} minutes"


# Taking input from user
minutes = int(input("Enter number of minutes: "))

result = convert_minutes(minutes)
print("Output:", result)