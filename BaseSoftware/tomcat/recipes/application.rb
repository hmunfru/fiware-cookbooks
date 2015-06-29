log "Empezando"
search(:java_app) do |app|
  log "Un app #{app}"
  log " server roles: #{app["server_roles"]} "
  log " roles : #{node.run_list.roles} " 
  (app["server_roles"] & node.run_list.roles).each do |app_role|     
        log "Un app_role #{app_role} for"
        log " for  #{app["type"][app_role]}"
    app["type"][app_role].each do |thing|
        log "Un thing #{thing}"
        node.run_state[:current_app] = app
      include_recipe "tomcat::#{thing}"
    end
  end
end

node.run_state.delete(:current_app)
