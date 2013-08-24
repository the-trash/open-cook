upstream open_cook_server {
  server unix:<%= current_path %>/tmp/sockets/unicorn.sock fail_timeout=0;
}

server{
  server_name <%= site_name %> www.<%= site_name %>
  listen 185.4.75.90;

  location / {
    proxy_pass http://open_cook_server;
  }
}