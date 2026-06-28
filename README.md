# 🎵 usb_meme

> *"Just kidding :) It's just a prank from loveberland"*

A harmless USB prank that with an endless barrage. Plug in, run, and watch the chaos unfold. 😈

## ⚙️ How it works

1. You compile `main.c` → `main.exe`
2. Drop `main.exe` + `setup.bat` onto a USB drive
3. And secretly ran it on a friend's computer while they weren't around.
4. `setup.bat` silently copies the executable to `%TEMP%`, launches it, then **self-destructs** (deletes itself + the cleanup script once the prank exe exits)
5. Victim closes the main window → everything cleans up automatically, no evidence

> **No registry edits. No persistence. No actual harm. Just pure, beautiful chaos.**

---

## 🪟 Windows (Supported ✅)

### Build

You'll need **GCC** (MinGW / MSYS2 works great):

```bash
gcc main.c -o main.exe
```

### Prepare the USB

```
usb_drive/
├── main.exe      ← compiled binary
└── setup.bat     ← the launcher (auto self-destructs after prank ends)
```

### Deploy the Prank

1. Plug the USB into target machine
2. Run `setup.bat`
3. Walk away casually 😎
4. Try not to laugh

---

## 🐧 Linux *(Coming Soon™)*

The Linux version is **in the works**. 

---

## 🛠️ Contributing

Got a prank idea? Open a PR.

- More ASCII art sources?  ← yes please
- macOS support (`.command` script)?  ← let's go
- Linux shell script?  ← coming soon, help welcome
- More chaos?  ← always

---

*Made with 💀 and poor life decisions by [loveberland](https://github.com/Loveberland)*
