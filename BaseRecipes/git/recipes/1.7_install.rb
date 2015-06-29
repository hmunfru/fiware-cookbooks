include_recipe "git::default"
git_dir="#{node["git"]["default_folder"]}"

directory "#{git_dir}" do
  owner "root"
  group "root"
  mode 00755
  action :create
end
