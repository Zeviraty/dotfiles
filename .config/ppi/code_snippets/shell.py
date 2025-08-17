def main():
    while True:
        cmd = input(">")

        match cmd.lower():
            case "exit":
                return

if __name__ == "__main__":
    main()
