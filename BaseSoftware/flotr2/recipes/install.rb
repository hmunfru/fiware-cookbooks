include_recipe "git"

directory "#{node['flotr2']['path']}/js/libs" do
  owner "root"
  group "root"
  mode 00644
  not_if {File.exists?("#{node['flotr2']['path']}/js/libs")}
  action :create
  recursive true
end

git "flotr2" do
	repository "https://github.com/HumbleSoftware/Flotr2"
	destination "#{node['flotr2']['path']}/js/libs"
	action :sync
end
