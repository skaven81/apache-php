#!/bin/bash

# Ensure PID file is deleted before starting up
rm -f /var/run/apache2/*.pid

# Now start up as usual
exec /bin/bash -x /usr/sbin/apache2ctl "$@"
