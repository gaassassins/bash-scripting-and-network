crontab -l > mycron

#!/bin/bash

echo "0,30 * * * * rm -rf /tmp" >> mydr
crontab mydr
rm mydr
