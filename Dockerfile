FROM centos:8

# Disable any mariadb stuff that CentOS provides
RUN for repo_file in /etc/yum.repos.d/*.repo; do echo 'exclude=mariadb mariadb-*' >> "${repo_file}"; done

# Add mariadb-10.5 repo
COPY mariadb.repo /etc/yum.repos.d/mariadb.repo

# Install the packages
RUN dnf install -y MariaDB-client MariaDB-server MariaDB-backup nmap-ncat openssl galera-4 lsof \
    && dnf clean all \
    && rm -rf /var/cache/yum

ENTRYPOINT /bin/galera-start
