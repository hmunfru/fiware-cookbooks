case node['platform_family']
when "debian"
  # Adds the repo: http://www.mongodb.org/display/DOCS/Ubuntu+and+Debian+packages
  execute "apt-get update" do
    action :nothing
  end


when "rhel","fedora"
  yum_repository "testbed-fi-ware" do
    description "Fiware Repository"
    url "http://130.206.80.64/repo/rpm/x86_64/"
    action :add
  end

else
    Chef::Log.warn("Adding the #{node['platform']} 10gen repository is not yet not supported by this cookbook")
end
