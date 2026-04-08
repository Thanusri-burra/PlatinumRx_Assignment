def remove_duplicates(s):
    result = ""

    for char in s:
        if char not in result:
            result += char

    return result


# Taking input from user
user_input = input("Enter a string: ")

output = remove_duplicates(user_input)
print("Output:", output)