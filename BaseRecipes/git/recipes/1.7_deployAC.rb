git_folder="#{node["git"]["default_folder"]}"
git_app="#{node["git"]["application"]}"
git_url_repo="#{node["git"]["url_repository"]}"


directory "#{git_folder}#{git_app}" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

script "install_something" do
  interpreter "bash"
  user "root"
  cwd "#{git_folder}#{git_app}"
  code <<-EOH
  wget www.elmundo.es 
  git clone #{git_url_repo} 
  EOH
end



