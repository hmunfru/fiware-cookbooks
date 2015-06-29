#Makes a backup of the data base


script "Restore the DB" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    sudo -u postgres psql -f /tmp/postgresql-dump.sql postgres
    rm /tmp/postgresql-dump.sql
  EOH
end