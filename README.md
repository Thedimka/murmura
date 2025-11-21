# Murmura - FOSS System Info CLUI App

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS-blue.svg)](https://www.kernel.org/)

A lightweight, zero-dependency bash utility that displays comprehensive server and system information in a beautiful terminal interface. Works seamlessly on both Linux and macOS. Perfect for system administrators, DevOps engineers, and anyone who needs quick system insights.

## Quick Start

```bash
# Install
curl -sSL https://raw.githubusercontent.com/Thedimka/murmura/master/install.sh | sudo bash

# Run
murmura

# Update
sudo murmura update
```

## Features

- **Beautiful Terminal UI**: Box-drawing characters and 256-color ANSI palette for a modern look
- **Cross-Platform**: Native support for Linux and macOS with intelligent OS detection
- **Comprehensive Information**: Hostname, OS, virtualization, network, resources, users, and services
- **Zero Dependencies**: Pure bash with only standard system tools
- **Smart Service Detection**: 25+ services with multi-method detection (systemd, process, port)
- **Configurable**: Customize which services to display via config files
- **Self-Updating**: Built-in update mechanism to stay current
- **Graceful Fallbacks**: Intelligent handling of missing tools and commands
- **Terminal Adaptive**: Dynamically adjusts to terminal width

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

### Basic Usage

Simply run the command to display system information:

```bash
murmura
```

### Available Commands

```bash
murmura                    # Display system information (default)
murmura update             # Update to the latest version
murmura list-services      # List all supported services
murmura --help             # Show help message
murmura --version          # Show version information
```

### Service Configuration

Murmura shows **13 default services** by default. You can customize which services to monitor:

1. **Create a configuration file:**
   - User config: `~/.config/murmura/services.conf`
   - System-wide config: `/etc/murmura/services.conf`

2. **List available services:**
   ```bash
   murmura list-services
   ```

3. **Configure services** - Add one service key per line:

**Example `services.conf`:**

```ini
# Web Servers
nginx
apache2

# Databases
postgresql
mysql
redis
mongodb

# Container & Orchestration
docker

# Monitoring & Security
uptime-kuma
fail2ban
ufw

# Application Servers
nodejs
passenger
nextjs
pnpm

# File Transfer
ftp
sftp
```

**Default Services (if no config exists):**

- Apache2, NGINX, Rsyslog, Fail2ban, Docker
- FTP, SFTP, MySQL, PostgreSQL
- Node.js, Passenger, Next.js, PNPM

**All 25+ Supported Services:**

- **Web Servers:** NGINX, Apache2, HAProxy
- **Databases:** PostgreSQL, MySQL, MariaDB, MongoDB, Redis, Elasticsearch
- **Containers:** Docker
- **Application Servers:** Node.js, Passenger, Next.js, PNPM
- **File Transfer:** FTP, SFTP, SSH
- **Monitoring:** Uptime-Kuma, Rsyslog
- **Security:** Fail2ban, UFW, Firewalld
- **Message Queues:** RabbitMQ
- **DNS:** bind/named/dnsmasq

## Updating

If you already have murmura installed and want to update to the latest version:

### CLI Update (recommended)
```bash
sudo murmura update
```

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
```bash
murmura --version
```

Alternatively, to see the file timestamp directly:
```bash
ls -la /usr/local/bin/murmura
```

## What It Shows

### Header Section

- **System Hostname** - Current machine name
- **Operating System** - Distribution and version (Ubuntu, Debian, CentOS, etc.)
- **Virtualization Type** - Hardware, VM (KVM, VMware, VirtualBox, etc.), or Container (Docker, LXC)
- **Timestamp** - Current date and time with timezone

### Network Information

- **Real Network Interfaces** - Physical and wireless interfaces only
  - Includes: eth*, eno*, enp*, wlan*, wlp*
  - Excludes: loopback, docker*, br-*, veth*, cali*, vxlan*, tun*, virbr*
- **IP Addresses** - IPv4 with CIDR notation (e.g., 192.168.1.100/24)
- **Gateway** - Default route information
- **Interface Type** - Automatically detects wired/wifi connections

### System Resources

- **CPU** - Core count and architecture (x86_64, ARM, etc.)
- **RAM** - Total, used, and free memory in human-readable format
- **Disk Space** - Comprehensive breakdown:
  - Total storage capacity
  - Partition-level information (Boot, Swap, Data)
  - Available free space on each partition

### User Accounts

- **Human Users** - Real user accounts (UID >= 1000)
- **Service Accounts** - Special accounts like git-deploy, www-data
- **System Account Filtering** - Automatically excludes nobody, daemon, etc.

### Service Status

- **25+ Services Supported** - Web servers, databases, containers, monitoring tools
- **Multi-Method Detection:**
  1. Systemd service status (systemctl)
  2. Process detection (pgrep)
  3. Port listening check (ss/netstat)
- **Visual Status Indicators:**
  - ✓ Green checkmark - Service is active/running
  - ✗ Red cross - Service is inactive/stopped
- **Three-Column Layout** - Efficient display of multiple services

## Supported Systems

### Linux

- Ubuntu 18.04+ / Debian 9+
- CentOS 7+ / RHEL 7+
- Fedora 30+
- Arch Linux
- Other systemd and non-systemd Linux distributions

### macOS

- macOS 10.13 (High Sierra) and newer
- Both Intel (x86_64) and Apple Silicon (arm64) architectures
- Tested on macOS Monterey, Ventura, Sonoma, and Sequoia

## Requirements

- Bash 4.0+ (pre-installed on most systems)
- Standard system utilities (all built-in)
- **Linux**: Optional systemd-detect-virt for enhanced virtualization detection
- **macOS**: Uses native system commands (sw_vers, sysctl, dscl, etc.)

## Virtualization Detection

Automatically detects:

- Physical hardware
- Docker containers
- LXC containers
- KVM/QEMU virtual machines
- VMware (Linux and macOS)
- VirtualBox (Linux and macOS)
- Parallels Desktop (macOS)
- Xen
- Microsoft Hyper-V

**Platform-Specific Detection:**

- **Linux**: Uses systemd-detect-virt (preferred) or /proc/cpuinfo analysis
- **macOS**: Uses sysctl CPU features and system_profiler hardware data

## Network Interface Detection

Includes only real network interfaces:

- **Linux**: eth\*, eno\*, enp\* (Ethernet), wlan\*, wlp\* (WiFi)
- **macOS**: en0, en1, en2, etc. (Ethernet and WiFi)

Excludes virtual interfaces:

- lo (loopback)
- docker\*, br-\*, veth\* (Docker)
- cali\*, vxlan\* (Kubernetes/CNI)
- tun\*, virbr\* (VPN/libvirt)

**Network Information Displayed:**

- IP addresses with CIDR notation (e.g., 192.168.1.100/24)
- Default gateway
- Interface type detection (wired/wifi)

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

## Technical Details

### Detection Methods

**Virtualization Detection:**

- **Linux Primary**: `systemd-detect-virt` (if available)
- **Linux Fallback**: `/proc/cpuinfo` hypervisor flag parsing
- **macOS**: `sysctl machdep.cpu.features` and `system_profiler SPHardwareDataType`
- **Supports**: Docker, LXC, KVM, QEMU, VMware, VirtualBox, Parallels, Xen, Hyper-V

**Service Detection Strategy (Priority Order):**

1. **Systemd**: `systemctl is-active <service>` - Most reliable for systemd-managed services
2. **Process**: `pgrep -x <process>` - Catches services running outside systemd
3. **Port**: `ss -tuln` or `netstat -tuln` - Detects services listening on known ports
4. **Special Cases**: Node.js apps check common ports (3000, 3001, 8000, 8080)

**Network Interface Filtering:**

```bash
# Linux patterns
eth*, eno*, enp*    # Wired Ethernet (Linux)
wlan*, wlp*         # Wireless (Linux)

# macOS patterns
en0, en1, en2...    # Ethernet and WiFi (macOS)

# Excluded patterns (all platforms)
lo                  # Loopback
docker*, br-*       # Docker bridges
veth*, cali*        # Container interfaces
vxlan*, tun*        # VPN and overlay networks
virbr*              # libvirt bridges
```

**Color Implementation:**

- Uses 256-color ANSI escape codes for broad terminal compatibility
- Primary colors: Purple (#875FFF), Green, Red, Yellow
- Explicit color resets prevent terminal state corruption

### Performance

- **Startup Time**: <100ms on modern systems (both Linux and macOS)
- **Memory Usage**: ~5MB (pure bash, minimal overhead)
- **Dependencies**: Zero - uses only standard system utilities
- **Compatibility**: Bash 4.0+ (released 2009)

### Platform-Specific Implementations

**macOS Enhancements:**

- `sw_vers` - OS version detection
- `sysctl hw.ncpu` - CPU core count
- `sysctl hw.memsize` + `vm_stat` - Memory information
- `dscl` - User account enumeration
- `netstat -rn` - Gateway detection
- `lsof` - Port listening fallback

**Linux Implementations:**

- `/etc/os-release` - OS version detection
- `lscpu` or `/proc/cpuinfo` - CPU information
- `free` - Memory statistics
- `/etc/passwd` - User accounts
- `ip route` - Gateway detection
- `ss` or `netstat -p` - Port detection with process names

## Roadmap

### Planned Features

- [ ] Package for apt/yum repositories
- [ ] Extended service detection (Kubernetes, Prometheus, Grafana)
- [ ] Docker container health check integration
- [ ] JSON/YAML output format option
- [ ] Custom color theme configuration
- [ ] Plugin system for additional modules
- [ ] IPv6 support
- [ ] Historical metrics tracking
- [ ] Web dashboard export

### Contributions Welcome

We're actively looking for contributions in:

- Testing on different distributions
- New service detection methods
- Performance optimizations
- Documentation improvements
- Localization/internationalization

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