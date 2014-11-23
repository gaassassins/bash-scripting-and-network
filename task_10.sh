#!/bin/bash

mkdir -p html/files
touch html/files/index.html

echo "<html>
        <head>
          <title>Dummy page</title>
        </head>
        <body>
          $(cat worktext.txt)
        </body>
      </html>" > html/files/index.html

ln html/files/index.html html/index.html
ln -s html/files/index.html index.lnk
chmod 661 html/files/index.html
