# CustomLibrary.py

from robot.api.deco import keyword

class CustomLibrary:
    @keyword
    def print_custom_message(self, message):
        print(f"Custom Message: {message}")
