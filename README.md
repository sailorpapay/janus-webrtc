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
 
 
 
 
--------------------------------------
If you want run with https - you need ssl.
https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl

docker run -d -p 80:80 -p 443:443 -p 7088:7088 -p 8088:8088 -p 8188:8188 -p 8089:8089 -p 10000-10200:10000-10200/udp -v /etc/letsencrypt:/etc/letsencrypt -v /opt/janus-ssl:/opt/janus/share/janus/certs/ sailorpapay/janus-webrtcac
 



