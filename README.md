# Murmura - FOSS System Info CLUI App

A bash-based system information utility that displays server/system information in a clean CLI-based GUI format.

## Features

- **Clean Interface**: Uses box-drawing characters for a GUI-like terminal interface
- **Comprehensive Info**: Shows hostname, OS, virtualization, network, resources, users, and services
- **Cross-Platform**: Works on Ubuntu, Debian, CentOS, RHEL, Fedora, Arch Linux
- **Pure Bash**: No external dependencies beyond standard Linux tools
- **Graceful Fallbacks**: Handles missing commands and tools elegantly

## Example Output

```
░░░░░░░░░░░░ Murmura - FOSS System Info CLUI App ░░░░░░░░░░░░
╔═══════════════════════════════════════════════════════════╗
║  myserver                                Ubuntu 22.04 LTS ║
║  [Hardware]                     2024-11-14 15:30:45 EST   ║
╠═══════════════════════════════════════════════════════════╣
║  Network                                                  ║
║    eno1: 192.168.225.135/24 → 192.168.225.1 [wired]       ║
║                                                           ║
║  Resources                                                ║
║    CPU: 8 cores (x86_64)                                  ║
║    RAM: 32GB (18GB used, 14GB free)                       ║
║    Disk: 512GB SSD (16GB Boot + 8GB Swap + 488GB Data)    ║
║          Data: 234GB free                                 ║
║                                                           ║
║  Users: dmitriz, git-deploy                               ║
║                                                           ║
║  Services                                                 ║
║    ✓ Docker        ✓ PostgreSQL    ✓ NGINX                ║
║    ✗ MySQL         ✓ Node.js       ✗ Apache               ║
║    ✗ Passenger     ✗ Next.js                              ║
╚═══════════════════════════════════════════════════════════╝
```

## Installation

### One-liner Installation

```bash
curl -sSL https://raw.githubusercontent.com/Thedimka/murmura/master/install.sh | sudo bash
```

### Manual Installation

1. Download the script:
   ```bash
   wget https://raw.githubusercontent.com/Thedimka/murmura/master/murmura
   ```

2. Make it executable:
   ```bash
   chmod +x murmura
   ```

3. Move to system path:
   ```bash
   sudo mv murmura /usr/local/bin/
   ```

### From Source

```bash
git clone https://github.com/Thedimka/murmura.git
cd murmura
sudo cp murmura /usr/local/bin/
sudo chmod +x /usr/local/bin/murmura
```

## Usage

Simply run the command:

```bash
murmura
```

## Updating

If you already have murmura installed and want to update to the latest version:

### Automatic Update
```bash
curl -sSL https://raw.githubusercontent.com/Thedimka/murmura/master/install.sh | sudo bash
```

### Manual Update
```bash
# Download the latest version
wget https://raw.githubusercontent.com/Thedimka/murmura/master/murmura -O /tmp/murmura

# Replace the existing installation
sudo cp /tmp/murmura /usr/local/bin/murmura
sudo chmod +x /usr/local/bin/murmura

# Clean up
rm /tmp/murmura
```

### Check Version
To see when your installation was last updated:
```bash
ls -la /usr/local/bin/murmura
```

## What It Shows

### Header
- System hostname
- Operating system version
- Virtualization type (Hardware/VM/Container)
- Current timestamp

### Network
- Real network interfaces (excludes loopback, docker, virtual interfaces)
- IP addresses with subnet masks
- Gateway information
- Interface type detection (wired/wifi)

### Resources
- CPU cores and architecture
- RAM usage (total, used, free)
- Disk space with partition breakdown
- Free space on data partition

### Users
- Human user accounts (UID >= 1000)
- Service accounts like git-deploy
- Excludes system accounts

### Services
- Docker, MySQL, PostgreSQL, NGINX, Apache
- Node.js, Passenger, Next.js
- Multiple detection methods (systemd, process check, port listening)
- Color-coded status (✓ green for active, ✗ red for inactive)

## Supported Systems

- Ubuntu 18.04+ / Debian 9+
- CentOS 7+ / RHEL 7+
- Fedora 30+
- Arch Linux
- Other systemd and non-systemd Linux distributions

## Requirements

- Bash 4.0+
- Standard Linux utilities (most are built-in)
- Optional: systemd-detect-virt for better virtualization detection

## Virtualization Detection

Automatically detects:
- Physical hardware
- Docker containers
- LXC containers  
- KVM/QEMU virtual machines
- VMware
- VirtualBox
- Xen
- Microsoft Hyper-V

## Network Interface Detection

Includes only real network interfaces:
- Ethernet: eth*, eno*, enp*
- WiFi: wlan*, wlp*

Excludes virtual interfaces:
- lo (loopback)
- docker*, br-*, veth* (Docker)
- cali*, vxlan* (Kubernetes/CNI)
- tun*, virbr* (VPN/libvirt)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on multiple Linux distributions
5. Submit a pull request

### Development Guidelines

- Maintain compatibility with older bash versions
- Add graceful fallbacks for missing tools
- Follow existing code style and commenting
- Test virtualization detection thoroughly

## Roadmap

- [ ] Package for apt/yum repositories
- [ ] Add more service detections
- [ ] Docker health check integration
- [ ] JSON output format option
- [ ] Custom color themes
- [ ] Plugin system for additional modules

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Troubleshooting

### Command not found
Ensure `/usr/local/bin` is in your PATH:
```bash
echo $PATH
export PATH="/usr/local/bin:$PATH"
```

### Permission denied
The script needs to be executable:
```bash
chmod +x /usr/local/bin/murmura
```

### Missing information
Some information requires specific tools:
- Network info: `ip` or `ifconfig`
- Memory info: `free`
- CPU info: `lscpu` or `/proc/cpuinfo`
- Disk info: `df` and `lsblk`

Most Linux distributions include these by default.