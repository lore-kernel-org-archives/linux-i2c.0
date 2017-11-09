From: Juergen Fitschen <me@jue.yt>
Subject: [PATCH v2 0/3] i2c: at91: slave mode support
Date: Thu, 9 Nov 2017 18:21:24 +0100
Message-ID: <cover.1510247114.git.me@jue.yt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Based on the discussion we had on the i2c-linux list [1], I wrote a patch for
AT91 hardware and tried to fulfill the Linux I2C slave interface description
[2] as good as possible. This enables aforementioned hardware to act as an I2C
slave that can be accessed by a remote I2C master.


I have tested this patchset successfully on an ATSAMA5D27.

                                 ^  3.3V   ^  3.3V
    +-----------------------+    |         |         +-----------------------+
    | Slave: ATSAMA5D27     |   +-+       +-+        | Master: ATSAMA5D35    |
    | with i2c-slave-eeprom |   | | 100k  | | 100k   | with i2cset           |
    +-------------------+-+-+   +-+       +-+        +-+-+-------------------+
                        | |      |         |           | |
                        | +------+---------|---(SDA)---+ |
                        +------------------+---(SCL)-----+

    Schematic: Connection of slave and master with 100kOhm pullup resistors.

On the master the following BASH script has been used to stress the slave.

    root@emblinux:~# cat ./stress.sh
    #!/bin/bash
    I=0
    while true
    do
            if i2cset -y -r 1 0x64 0 $I w | grep mismatch
            then
                    echo "$(date): Error in transmission ${I}"
            fi
            ((I++))
            if [ $I -eq 65536 ]
            then
                    I=0
                    echo "$(date): Sent 65536 transmissions"
            fi
    done


After running the script for some time I had the following output. To me this
looks promising :)

    root@emblinux:~# ./stress.sh
    Thu Nov  9 13:58:45 CTE 2017: Sent 65536 transmissions
    Thu Nov  9 14:35:20 CTE 2017: Sent 65536 transmissions
    Thu Nov  9 15:12:11 CTE 2017: Sent 65536 transmissions
    Thu Nov  9 15:49:04 CTE 2017: Sent 65536 transmissions
    Thu Nov  9 16:26:00 CTE 2017: Sent 65536 transmissions
    Thu Nov  9 17:03:07 UTC 2017: Sent 65536 transmissions
    Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions

If you have some hardware with an at91-i2c interface included at hand, I really
would appreciate if you can run the test script on your hardware and test this
driver.


Best regards
  Juergen


Changes in v2:
 - Implemented all suggestions made by Ludovic. (Thank you!)
 - Reworked the IRQ handler completely. Have a look in patch 3 fort further
   details.

[1] https://marc.info/?t=150824004800001&r=1&w=1
[2] https://www.kernel.org/doc/Documentation/i2c/slave-interface

Juergen Fitschen (3):
  i2c: at91: segregate master mode specific code from probe and init
    func
  i2c: at91: split driver into core and master file
  i2c: at91: added slave mode support

 Documentation/devicetree/bindings/i2c/i2c-at91.txt |   14 +
 MAINTAINERS                                        |    3 +-
 drivers/i2c/busses/Kconfig                         |   10 +
 drivers/i2c/busses/Makefile                        |    4 +
 drivers/i2c/busses/i2c-at91-core.c                 |  390 ++++++
 drivers/i2c/busses/i2c-at91-master.c               |  806 +++++++++++++
 drivers/i2c/busses/i2c-at91-slave.c                |  216 ++++
 drivers/i2c/busses/i2c-at91.c                      | 1243 --------------------
 drivers/i2c/busses/i2c-at91.h                      |  191 +++
 9 files changed, 1633 insertions(+), 1244 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-at91-core.c
 create mode 100644 drivers/i2c/busses/i2c-at91-master.c
 create mode 100644 drivers/i2c/busses/i2c-at91-slave.c
 delete mode 100644 drivers/i2c/busses/i2c-at91.c
 create mode 100644 drivers/i2c/busses/i2c-at91.h

-- 
2.7.4
