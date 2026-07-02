import platform
import shutil
import subprocess
import time

CMD_ARGV = ["curl", "-L", "ascii.live/can-you-hear-me"]
CMD = " ".join(CMD_ARGV)
HOLD_SHELL = f"{CMD}; exec bash"

LINUX_TERMINALS = [
    ("gnome-terminatl", ["gnome-terminal", "--", "bash", "-c", HOLD_SHELL]),
    ("konsole", ["konsole", "-e", "bash", "-c", HOLD_SHELL]),
    ("xfce4-terminal", ["xfce4-terminal", "--command", CMD, "--hold"]),
    ("mate-terminal", ["mate-terminal", "-x", "bash", "-c", HOLD_SHELL]),
    ("lxterminal", ["lxterminal", "-e", "bash", "-c", HOLD_SHELL]),
    ("terminator", ["terminator", "-x", "bash", "-c", HOLD_SHELL]),
    ("tilix", ["tilix", "-e", "bash", "-c", HOLD_SHELL]),
    ("alacritty", ["alacritty", "-e", "bash", "-c", HOLD_SHELL]),
    ("kitty", ["kitty", "bash", "-c", HOLD_SHELL]),
    ("wezterm", ["wezterm", "start", "--", "bash", "-c", HOLD_SHELL]),
    ("foot", ["foot", "--hold", *CMD_ARGV]),
    ("urxvt", ["urxvt", "-hold", "-e", *CMD_ARGV]),
    ("rxvt", ["rxvt", "-hold", "-e", *CMD_ARGV]),
    ("st", ["st", "-e", "bash", "-c", HOLD_SHELL]),
    ("x-terminal-emulator", ["x-terminal-emulator", "-e", "bash", "-c", HOLD_SHELL]),
    ("xterm", ["xterm", "-hold", "-e", *CMD_ARGV]),

]

def call_rick() -> None:
    system = platform.system()

    # Windows
    if system == "Windows":
        subprocess.Popen("start cmd /k curl -L ascii.live/can-you-hear-me", shell=True)
        return

    # macOS
    if system == "Darwin":
        applescript = f'tell application "Terminal" to do script "{CMD}"'
        subprocess.Popen(["osascript", "-e", applescript])
        return

    # Linux
    for name, argv in LINUX_TERMINALS:
        if shutil.which(name):
            try:
                subprocess.Popen(argv)
                return
            except OSError:
                continue

    print("Error: No terminal emulator found.")

def main() -> None:
    print("Just kidding :) It's just prank from \"Loveberland\".")
    print("To stop this program just close me.")
    while True:
            call_rick()
            time.sleep(3)

if __name__ == "__main__":
    main()
