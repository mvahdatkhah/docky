# 🐳 Ansible Playbook: Install & Configure Docker + Exporters

This Ansible playbook automates the installation, removal, and configuration of Docker, Docker Compose, and popular Prometheus exporters on both RedHat and Debian-based systems.

## 📋 Features

- 🧠 Selective fact gathering (minimal overhead)
- 🔥 Uninstall conflicting/legacy Docker packages
- 📦 Install required system packages
- 🐳 Install Docker & Docker Compose
- 📥 Load and run Docker images (Node Exporter, Blackbox Exporter, Fluentd)
- 🔐 Hardened container configurations
- 🧪 Docker version info retrieval
- 👥 User group management (`ansible` → `docker`)
- 🚀 Handlers to restart Docker

---

## 📂 File Structure

```text
.
├── tasks/
│   └── main.yml                   # Main Ansible task file
├── handlers/
│   └── main.yml                   # Ansible handler to restart Docker
├── files/
│   ├── run-node-exporter.sh       # Secure Node Exporter container run script
│   ├── run-blackbox-exporter.sh   # Secure Blackbox Exporter container run script
│   └── ssl-node-exporter.sh       # Secure SSL Exporter container run script
```

---

## 🚀 Usage

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/ansible-docker-exporters.git
cd ansible-docker-exporters
```

### 2. Configure Inventory

Create an inventory file or use your existing one. Example:

```ini
[docker_nodes]
host1 ansible_host=192.168.1.10
host2 ansible_host=192.168.1.11
```

### 3. Run the Playbook

```bash
ansible-playbook -i inventory.ini tasks/main.yml
```

---

## 🐚 Scripts

### ▶️ `run-node-exporter.sh`

Runs a hardened **Node Exporter** container with:

- Host networking
- Memory/CPU limits
- Dropped capabilities
- Read-only FS

### ▶️ `run-blackbox-exporter.sh`

Runs a hardened **Blackbox Exporter** container with:

- Custom probe config
- Memory/CPU limits
- TLS config for HTTP/SSL checks

### ▶️ `ssl-node-exporter.sh`

Runs a hardened **SSL Exporter** container with:

- Host networking & PID namespace
- CPU/Memory constraints

---

## 📎 Tags

Use tags to run specific parts of the playbook:

```bash
ansible-playbook -i inventory.ini tasks/main.yml --tags install_docker
```

| Tag | Description |
|-----|-------------|
| `setup` | Gather minimal facts |
| `uninstall_docker` | Remove existing Docker packages |
| `req_sys_packages` | Install system dependencies |
| `update_packages` | Update packages (Debian) |
| `install_docker_engine` | Install Docker Engine (Debian) |
| `install_docker` | Install Docker Engine (RedHat) |
| `docker_compose` | Install Docker Compose |
| `copy_docker_image` | Copy image tarballs |
| `run_node_exporter` | Run Node Exporter securely |
| `run_blackbox_exporter` | Run Blackbox Exporter securely |
| `docker_version` | Print Docker version info |

---

## 👨‍🔧 Requirements

- Ansible 2.9+
- Python 3.x on control node
- Target hosts:
  - Debian/Ubuntu or RHEL/CentOS

---

## 🛡️ Security Best Practices

- Uses hardened container flags (`read-only`, `no-new-privileges`, `cap-drop`)
- TLS config in Blackbox Exporter
- Least-privilege Docker containers

---

## 📜 License

MIT © YourNameHere

---

## 🙌 Contributing

Pull requests are welcome! Please open an issue first to discuss changes.

---

## ✨ Author

**Milad Vahdatkhah** – DevOps & Automation Enthusiast 💻🛠️
