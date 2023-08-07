#!/bin/bash
/usr/sbin/sshd -D &
jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root --no-browser --NotebookApp.password='sha1:fb6df7c13e87:06137efb48ae21142033fca385f177a061bcc542'
