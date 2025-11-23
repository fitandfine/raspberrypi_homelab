# RaspberryPi Home Lab

This project documents the setup and configuration of a personal Raspberry Pi used as a foundational home lab server. The primary objective is to gain practical, hands-on experience with fundamental DevOps principles, including secure remote access, network configuration, web server deployment, and service automation in a Linux environment.

### This documentation serves as a practical blueprint, demonstrating comfort with Linux command-line tools, networking fundamentals (Nmap), system services (systemctl), and scripting for basic automation.

## Project Goals:
**Infrastructure Management:** Successfully discover, connect to, and manage a headless Raspberry Pi over a local network.

**Security & Access:** Implement robust, non-password-based SSH authentication using key pairs for secure administrative access.

**Web Services:** Deploy and manage the high-performance Nginx web server to serve content.



**Automation:** Utilize Bash scripting and Linux utilities (inotifywait, systemctl, curl) to automate service health checks and configuration management, ensuring high availability and operational efficiency.



### Project Folders & git initialization
```
Command:
$ mkdir raspberrypi_home_lab && cd raspberrypi_home_lab && mkdir screenshots && mkdir scripts && code README.md && git init
```
## Connect Local git to github repository

```
Command:
$ git add . && git commit -m " Initial Commit" && git remote add origin https://github.com/fitandfine/raspberrypi_homelab.git && git push -u origin main
```

![Project Setup and Git initialization](screenshots/1.png)

## Problem unknown raspberry Pi IP address:
When running a Raspberry Pi in headless mode (no keyboard, mouse, or monitor), the only way to access it is over the network via SSH.
But when your Raspberry Pi is connected through an iPhone hotspot, the hotspot UI does not show connected device IP addresses.
This makes it impossible to know the Pi’s IP directly.

**Solution:**
**nmap ( Network Scanner)**

**nmap** is a network exploration tool that scans an IP range and reports devices, open ports, and system fingerprints.

In this case, we need it to:

Detect all devices connected to the iPhone hotspot.

Identify the Raspberry Pi based on open ports. (SSH → port 22)

Obtain the Pi’s IPv4 address so we can SSH into it.
