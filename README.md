# janus-webrtc
If you want local run  without HTTPS -
 comment out in janus.transport.http.jcfg
 
 
#######
 cert_pem = "/opt/janus/share/janus/certs/mycert.pem"
 cert_key = "/opt/janus/share/janus/certs/mycert.key"

 and
 
 #####

 admin_https = true					 
 admin_secure_port = 7889			 
 
 
 docker-compose build
docker-compose up -d
 
--------------------------------------
If you want run with https - you need ssl.
https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl

docker-compose build
docker-compose up -d
 



