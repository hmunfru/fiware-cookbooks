git_folder="#{node["git"]["default_folder"]}"
git_app="#{node["git"]["application"]}"
git_url_repo="#{node["git"]["url_repository"]}"



script "install_something" do
  interpreter "bash"
  user "root"
  cwd "#{git_folder}#{git_app}#{git_app}"
  code <<-EOH
  git pull
  EOH
end
