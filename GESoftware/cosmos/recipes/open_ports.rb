# Open the ports required by the roles this node is playing
# ---------------------------------------------------------

# Configure iptables to accept incoming connections on a set of TCP ports

if node[:node_type] == "master_node"
	for p in node[:open_ports][:master_node]
        	open_input_tcp_port "open_input_tcp_port_#{p}" do
                	port p
	        end
	end
end

if node[:node_type] == "slave_node"
        for p in node[:open_ports][:slave_node]
                open_input_tcp_port "open_input_tcp_port_#{p}" do
                        port p
                end
        end
end

if node[:node_type] == "injection_node"
        for p in node[:open_ports][:injection_node]
                open_input_tcp_port "open_input_tcp_port_#{p}" do
                        port p
                end
        end
end

