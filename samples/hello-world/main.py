"""Hello World sample — greets the user by name."""

import sys


def greet(name: str = "World") -> str:
    """Return a greeting message for the given name."""
    return f"Hello, {name}!"


def main() -> None:
    """Entry point: use CLI arguments as the name, or default to 'World'."""
    if len(sys.argv) > 1:
        name = " ".join(sys.argv[1:]).strip()
        if not name:
            name = "World"
    else:
        name = "World"
    print(greet(name))


if __name__ == "__main__":
    main()
