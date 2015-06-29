service node["apache"]["service_name"] do
  action [:start, :enable]
end
