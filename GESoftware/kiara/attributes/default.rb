case node["platform_family"]
when "debian"
#  default['pkg_name'] = "libssl-dev"
#  default['pkg_name'] = "libcurl4-openssl-dev"
  default['pkg_name'] = nil
when "rhel"
  default['pkg_name'] = "openssl-devel"
end

case node['platform']
when "centos"
  default['file_name'] = "kiara-sdk-0.13.0-centos-6.2-x86_64-Release-2014-07-15.tar.bz2"
  default['kiara_skd_path'] = "http://forge.fi-ware.org/frs/download.php/1467/#{node['file_name']}"
when "ubuntu"
  default['file_name'] = "kiara-sdk-0.13.0-Ubuntu-13.10-x86_64-Release-2014-08-08.tar.bz2"
  default['kiara_skd_path'] = "http://forge.fi-ware.org/frs/download.php/1469/#{node['file_name']}"
when "fedora"
  default['file_name'] = "kiara-sdk-0.13.0-fedora-19-x86_64-Release-2014-08-08.tar.bz2"
  default['kiara_skd_path'] = "http://forge.fi-ware.org/frs/download.php/1468/#{file_name}"
end

#platform_version = node['platform_version']   # e.g '6.5', '14.04'
#architecture = node['kernel']['machine']      # e.g 'x86_64'