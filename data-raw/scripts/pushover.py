
import os
import requests
from strenum import StrEnum

class Pushover:

    class Priority(StrEnum):
        LOWEST = "-2"
        LOW = "-1"
        NORMAL = "0"
        HIGH = "1"
        EMERGENCY = "2"

    def __init__(self, token: str, user: str):
        self._token = token
        self._user = user

    # Send a Pushover notification
    def send(self, message: str, attachment_url: str=None, priority=Priority.NORMAL):
        MESSAGES_URL = "https://api.pushover.net/1/messages.json"
        data = {
            "token": self._token,
            "user": self._user,
            "message": message,
            "priority": priority
        }

        files = None
        if attachment_url and os.path.isfile(attachment_url):
            files = {
                "attachment": ("image.jpg", open(attachment_url, "rb"), "image/jpeg")
            }

        requests.post(MESSAGES_URL, data=data, files=files)

if __name__ == "__main__":
    api_key = os.environ["PUSHOVER_API_KEY"]
    user_key = os.environ["PUSHOVER_USER_KEY"]

    pushover = Pushover(token=api_key, user=user_key)
    args = sys.argv

    try:
        message = args[1]
    except IndexError:
        raise SystemExit("Required message parameter not supplied")

    priority = getattr(Pushover.Priority, sys.argv[2]) if len(args) >= 3 else Pushover.Priority.NORMAL)

    Pushover.send(message, attachment_url, priority)
