case node["platform"]
when "centos", "redhat", "fedora"
	default['redis']['port']		= '6379'
	default['redis']['bind']		= '127.0.0.1'

        default['redis']['slav']        = 'slaveof'
        default['redis']['slaveof']     = "#{node['redis']['slav']} #{node['redis']['masterip']} #{node['redis']['masterport']}"

        default['redis']['ifmastauth']  = 'masterauth'
	default['redis']['masterauth']	= "#{node['redis']['ifmastauth']} #{node['redis']['passwordmaster']}"

        default['redis']['require']     = "requirepass"
        default['redis']['requirepaas']     = "#{node['redis']['require']} #{node['redis']['requirepassword']}"
end


