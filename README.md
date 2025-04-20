# MyOS

MyOS is a simple monolithic operating system written in C for the Intel x86 architecture. It boots via BIOS using GRUB (Multiboot1) and focuses on low-level system fundamentals with a text-only shell and no filesystem.

---

## 🧠 Project Goals

- Target **Intel x86 (i386)** architecture
- Boot with **BIOS** and custom bootloader
- Kernel in **C**, with minimal **Assembly**
- **Monolithic** kernel design
- **No filesystem**
- Simple **text-only shell**
- Debug with **GDB**
- Build with **native GCC**
- Run via **QEMU**

---

## 🛠 Toolchain Setup

```bash
# Debian/Ubuntu
sudo apt install build-essential grub-pc-bin xorriso qemu nasm git
