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
| nextcloud_image_name    | text | no         | nextcloud | Docker image name (recommended to use the default image)  |
| nextcloud_image_version | text | no         | latest    | Docker image version (recommended to use a fixed version like `18.0`) |
| nextcloud_db_image_name    | text | no         | postgres | Docker image name (recommended to use the `postgres` docker image |
| nextcloud_db_image_version | text | no         | latest    | Docker image version (recommended to use a fixed version like `12.2`) |
| nextcloud_interface        | ip address | no   | 0.0.0.0          | Mapped network for web-interface ports |
| nextcloud_http_port        | port       | no   | 80               | Mapped HTTP port                       |
| nextcloud_www_volume       | path       | yes  | <empty>          | Path to nextcloud's www volume         |
| nextcloud_database_volume  | path       | yes  | <empty>          | Path to database volume                |
| nextcloud_data_volume      | path       | no   |                  | Path where the file data will be stored   |
| nextcloud_custom_apps_volume | path     | no   |                  | Path where the custom apps will be stored |
| nextcloud_db_secret_size     | number     | no   | 16               | Size of the generated database secret   |

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
        nextcloud_www_volume: /srv/nextcloud/www
        nextcloud_database_volume: /srv/nextcloud/database
```

Typical playbook:

```yaml
    - hosts: servers
    - role: install-nextcloud
      nextcloud_image_version: 18.0
      nextcloud_db_image_version: 12.2
      nextcloud_http_port: 80
      nextcloud_interface: 0.0.0.0
      nextcloud_db_secret_size: 32
      nextcloud_www_volume: /srv/nextcloud/www
      nextcloud_database_volume: /srv/nextcloud/database
      nextcloud_data_volume: /srv/nextcloud/data
      nextcloud_custom_apps_volume: /srv/nextcloud/custom_apps
```

## Testing

Requirements:

* [Vagrant](https://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)
* [Ansible](https://docs.ansible.com/)
* [Molecule](https://molecule.readthedocs.io/en/latest/index.html)
* [yamllint](https://yamllint.readthedocs.io/en/stable/#)
* [ansible-lint](https://docs.ansible.com/ansible-lint/)
* [Docker](https://docs.docker.com/)

### Run within docker

```shell script
molecule test
```

### Run within Vagrant

```shell script
 molecule test --scenario-name vagrant --parallel
```

I recommend to use [pyenv](https://github.com/pyenv/pyenv) for local testing.
Within the Github Actions pipeline I use [my own molecule Docker image](https://github.com/borisskert/docker-molecule).

## Links

* [teamspeak @ Docker Hub](https://hub.docker.com/_/teamspeak/)
