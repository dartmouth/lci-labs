sudo dnf remove -y mariadb-server
sudo dnf remove -y slurm*
sudo rm -rf /var/lib/mysql/
sudo rm -rf /etc/slurm
sudo rm -rf /var/log/slurm
sudo rm -rf /var/spool/slurm*
