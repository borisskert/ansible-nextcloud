# ansible-nextcloud

Installs nextcloud as docker container.

## System requirements

* Docker
* Systemd

## Role requirements

* python-docker package

## Tasks

* Create volume paths for docker container
* Setup systemd unit file
* Start/Restart systemd service

## Role parameters

| Variable      | Type | Mandatory? | Default | Description           |
|---------------|------|------------|---------|-----------------------|
| image_name    | text | no         | nextcloud | Docker image name    |
| image_version | text | no         | 13.0.0    | Docker image version |
| interface     | ip address | no   | 0.0.0.0          | Mapped network for web-interface ports |
| http_port     | port       | no   | 80               | Mapped HTTP port                       |
| data_volume   | path       | yes  | <empty>          | Path to data volume                    |

## Usage

### Add to `requirement.yml`:

```yaml
- name: install-nextcloud
  src: https://github.com/borisskert/ansible-nextcloud.git
  scm: git
```

Minimal playbook:

```yaml
    - hosts: servers
      roles:
      - role: install-nextcloud
        data_volume: /srv/nextcloud
```

Typical playbook:

```yaml
    - hosts: servers
    - role: install-nextcloud
      image_version: 18.0
      http_port: 80
      interface: 0.0.0.0
      data_volume: /srv/nextcloud
```
