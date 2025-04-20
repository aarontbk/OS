# os-name??

This os is a simple monolithic operating system written in C for the Intel x86 architecture. It is designed to boot via BIOS using GRUB and Multiboot. This project focuses on low-level OS fundamentals with a text-only shell and no filesystem.

---

## 🧠 Project Goals

- Target **Intel x86 (i386)** architecture
- Use **BIOS booting** with **GRUB** and **Multiboot1**
- Write kernel in **C**, with minimal **Assembly**
- Use a **monolithic** kernel architecture
- Provide a simple **text-based shell**
- No filesystem (yet)
- Develop using **VSCode**, **GCC cross-compiler**, **Make**, and **QEMU**

---

## 🛠 Toolchain Setup

```bash
# Debian/Ubuntu
sudo apt install build-essential grub-pc-bin xorriso qemu nasm git

# Cross-compiler (if needed)
sudo apt install gcc-i686-linux-gnu binutils-i686-linux-gnu
