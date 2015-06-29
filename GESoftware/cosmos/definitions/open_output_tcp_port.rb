# Copyright 2013 Telefonica Investigacion y Desarrollo, S.A.U
# PROJECT: FI-WARE, data chapter
# AUTHORS: Francisco Romero Bueno (frb@tid.es)
# This software and / or computer program has been developed by Telefóa Investigacion y
# Desarrollo, SAU (hereinafter Telefonica I + D) and is protected as copyright by the
# applicable legislation on intellectual property .
# It belongs to Telefonica I + D, and / or its licensors, the exclusive rights of
# reproduction, distribution, public communication and transformation, and any economic
# right on it, all without prejudice of the moral rights of the authors mentioned above.
# It is expressly forbidden to decompile, disassemble, reverse engineer, sublicense or
# otherwise transmit by any means, translate or create derivative works of the software and
# / or computer programs, and perform with respect to all or part of such programs, any
# type of exploitation.
# Any use of all or part of the software and / or computer program will require the
# express written consent of Telefonica I + D. In all cases, it will be necessary to make
# an express reference to Telefonica I+D ownership in the software and / or computer
# program.
# Non-fulfillment of the provisions set forth herein and, in general, any violation of
# the peaceful possession and ownership of these rights will be prosecuted by the means
# provided in both Spanish and international law. Telefonica I + D reserves any civil or
# criminal actions it may exercise to protect its rights.

# open OUTPUT tcp port 
define :open_output_tcp_port, :port => 0 do
	execute "iptables -I OUTPUT -p tcp -m tcp --dport #{params[:port]} -j ACCEPT" do
		not_if "iptables -S | grep -q -e 'OUTPUT -p tcp -m tcp --dport #{params[:port]} -j ACCEPT'"
	end
end
