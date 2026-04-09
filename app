import Main

menu_prompt = """
-- Coffee Bean App --

Please choose one of these options:

1) Add a new bean.
2) See all beans.
3) Find a bean by name.
4) See which preparation method is best for a bean.
5) Delete Bean.
6) Exit.

Your selection: """

del_bean = """
-- Coffee Bean App --

Please choose one of these options:

1) Delete By ID.
2) Delete By Name.
3) Exit.

Your selection: """

def prompt_add_new_bean(connection):
    name = input("Enter bean name: ")
    method = input("Enter how you've prepared it: ")
    while True:
        try:
            rating = int(input("Enter your rating score (0-100): "))
        except ValueError:
            print("Enter a number.. ")
        else:
            break
        finally:
            pass

    Main.add_bean(connection, name, method, rating)

def prompt_see_all_beans(connection):
    beans = Main.get_all_beans(connection)

    for bean in beans:
        print(f"{bean[1]} ({bean[2]}) - {bean[3]}/100")

def prompt_find_bean(connection):
    name = input("Enter bean name to find: ")
    beans = Main.get_beans_by_name(connection, name)

    for bean in beans:
        print(f"{bean[1]} ({bean[2]}) - {bean[3]}/100")

def prompt_find_best_method(connection):
    name = input("Enter bean name to find: ")
    best_method = Main.get_best_preparation_for_bean(connection, name)

    print(print(f"The best preparation method for {name} is {best_method[2]}"))

def prompt_delete_bean_id(connection):
    pass

def prompt_delete_bean_name(connection):
    while True:
        name = input("Enter bean name to delete: ")
        beans = Main.get_beans_by_name(connection, name)

        if not beans:
            print("No bean found. Try again\n")
            continue

        continue1 = input("Are you sure you want to delete " + str(name) + "? (Y/N): ")
        if continue1 == "Y" or continue1 == "y":
            print(str(name) + " Was Deleted.")
            break
        elif continue1 == "N" or continue1 == "n":
            pass
        else:
            print("Invalid input, try again!")
        delete_bean = Main.delete_bean_by_name(connection, name)

def which_bean(connection):
    while(user_input := input(del_bean)) != "3":
        if user_input == "1":
            prompt_delete_bean_id(connection)
        elif user_input == "2":
            prompt_delete_bean_name(connection)
        else:
            print("Invalid input, please try again!")

def menu():
    connection = Main.connect()
    Main.create_tables(connection)

    while(user_input := input(menu_prompt)) != "6":
        if user_input == "1":
            prompt_add_new_bean(connection)
        elif user_input == "2":
            prompt_see_all_beans(connection)
        elif user_input == "3":
            prompt_find_bean(connection)
        elif user_input == "4":
            prompt_find_best_method(connection)
        elif user_input == "5":
            which_bean(connection)
        else:
            print("Invalid input, please try again!")

menu()
