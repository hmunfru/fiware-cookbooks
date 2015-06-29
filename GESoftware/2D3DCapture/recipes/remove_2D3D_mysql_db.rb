bash "remove_2d3d_mysql" do
    code <<-EOH
      mysql -h localhost -u $USER -e 'DROP DATABASE IF EXISTS 2d3dcapture'
      EOH
end
