 package "git" do
     action :remove
  end

git_folder="#{node["git"]["default_folder"]}"

directory "#{git_folder}" do
  recursive true
  action :delete
end
