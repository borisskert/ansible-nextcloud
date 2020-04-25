# ansible-nextcloud

Installs nextcloud as docker container.

## System requirements

* Docker
* docker-compose
* Systemd

## Role requirements

* python-docker package

## Tasks

* Template docker environment and pull docker images
* Create volume paths for docker container
* Setup systemd unit file
* Start/Restart systemd service

## Role parameters

| Variable      | Type | Mandatory? | Default | Description           |
|---------------|------|------------|---------|-----------------------|
| image_name    | text | no         | nextcloud | Docker image name (recommended to use the default image)  |
| image_version | text | no         | latest    | Docker image version (recommended to use a fixed version like `18.0`) |
| db_image_name    | text | no         | postgres | Docker image name (recommended to use the `postgres` docker image |
| db_image_version | text | no         | latest    | Docker image version (recommended to use a fixed version like `12.2`) |
| interface        | ip address | no   | 0.0.0.0          | Mapped network for web-interface ports |
| http_port        | port       | no   | 80               | Mapped HTTP port                       |
| www_volume       | path       | yes  | <empty>          | Path to nextcloud's www volume         |
| database_volume  | path       | yes  | <empty>          | Path to database volume                |
| secret_size      | number     | no   | 16               | Size of the generated database secret  |

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
        www_volume: /srv/nextcloud/www
        database_volume: /srv/nextcloud/database
```

Typical playbook:

```yaml
    - hosts: servers
    - role: install-nextcloud
      image_version: 18.0
      db_image_version: 12.2
      http_port: 80
      interface: 0.0.0.0
      secret_size: 32
      www_volume: /srv/nextcloud/www
      database_volume: /srv/nextcloud/database
```
