remote_file "/tmp/MiWi-2D3DCapture-Demo.zip" do
  source "https://forge.fi-ware.org/frs/download.php/1109/MiWi-2D3DCapture-Demo.zip"
end

bash "configure_2D3D_capture_mysql_db" do
  cwd "/tmp"
  code <<-EOT
    unzip MiWi-2D3DCapture-Demo.zip
    mysql < /tmp/MiWi-2D3DCapture-Demo/script_file.sql
    
  EOT
end

