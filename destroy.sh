read -p "Are you sure you want to run this? This should never be run in a production site <y/n> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
  sudo dnf remove -y mariadb-server
  sudo dnf remove -y slurm*
  sudo rm -rf /var/lib/mysql/
  sudo rm -rf /etc/slurm
  sudo rm -rf /var/log/slurm
  sudo rm -rf /var/spool/slurm*
  sudo dnf install -y mariadb-server
  sudo systemctl start mariadb
  sudo systemctl enable mariadb
else
  exit 0
fi

read -p "Do you also want to destroy the compute nodes? <y/n> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
  ansible all_nodes -m ansible.builtin.shell -a 'dnf remove -y slurm*'
  ansible all_nodes -m ansible.builtin.shell -a 'sudo rm -rf /etc/slurm'
  ansible all_nodes -m ansible.builtin.shell -a 'sudo rm -rf /var/log/slurm'
  ansible all_nodes -m ansible.builtin.shell -a 'sudo rm -rf /var/spool/slurm*'
else
  exit 0
fi
