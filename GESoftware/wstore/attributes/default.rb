default[:python][:configure_options] = %W{--prefix=#{python['prefix_dir']} --enable-shared}

default[:wstore][:port] = "80"

default[:wstore][:ins_dir] = "/opt/wstore/"
default[:wstore][:root_dir] = node[:wstore][:ins_dir] + 'wstore/src/'
default[:wstore][:user] = "wstore"
default[:wstore][:group] = "wstore"

default[:wstore][:database] = "wstore_db"
default[:wstore][:name] = "WStore-alone"
default[:wstore][:auth] = 'False'
default[:wstore][:auth_endpoint] = "https://account.lab.fi-ware.org/"
default[:wstore][:usdl_editor] = "http://store.lab.fi-ware.eu/usdl-editor"

default[:wstore][:client_id] = 0
default[:wstore][:client_secret] = ''

default[:wstore][:site_name] = 'Local'
default[:wstore][:site_domain] = 'http://localhost'

default[:wstore][:site_id] = ''

default[:wstore][:virtualenv] = "/opt/wstore_virtualenv"
