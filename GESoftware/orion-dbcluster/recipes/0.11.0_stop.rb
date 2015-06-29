bash "start_context_broker" do
  user "root"
  code <<-EOH
    /etc/init.d/contextBroker stop
  EOH
end
