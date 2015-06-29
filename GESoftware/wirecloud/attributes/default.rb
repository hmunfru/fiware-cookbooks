default[:python][:configure_options] = %W{--prefix=#{python['prefix_dir']} --enable-shared}

default[:wirecloud][:port] = "80"
default[:wirecloud][:user] = "wirecloud"
default[:wirecloud][:group] = "wirecloud"
default[:wirecloud][:install_dir] = "/opt/"
default[:wirecloud][:root_dir] = "/opt/wirecloud_instance"
default[:wirecloud][:instance_app] = "wirecloud_instance"
default[:wirecloud][:virtualenv] = "/opt/wirecloud_virtualenv"
