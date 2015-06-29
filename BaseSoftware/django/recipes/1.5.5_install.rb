include_recipe "python::default"
case node['platform_family']
    when 'fedora'
        yum_repository "testbed-fi-ware" do
                description "Fiware Repository"
                url "http://130.206.80.64/repo/rpm/x86_64/"
                action :add
        end

        yum_repository "epel" do
                description "Fiware Repository"
                url "http://dl.fedoraproject.org/pub/epel/6/x86_64/"
                action :add
        end
end

if platform?(%w(debian ubuntu))
   execute "apt-get update" do
      command "apt-get -y update"
   end
end

python_pip "django" do
        version "1.5.5"
        action :install
end

package "gcc" do
        action :install
end

include_recipe "python::default"
case node['platform_family']
    when 'fedora'
        yum_package "python-devel" do
            action :install
        end

        yum_package "mysql-devel.x86_64" do
            action :install
        end
    when 'debian'
        package "python-django" do
            action :install
    end
end
