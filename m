From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v4 0/3] i2c: at91: slave mode support
Date: Thu, 27 Dec 2018 16:13:08 +0100
Message-ID: <20181227151311.20107-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: me@jue.yt, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, wsa@the-dreams.de, andriy.shevchenko@linux.intel.com, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-i2c@vger.kernel.org

[Ludovic Desroches: see Changes section]

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
        Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions

        If you have some hardware with an at91-i2c interface included at hand, I really
        would appreciate if you can run the test script on your hardware and test this
        driver.

Best regards
  Juergen


[Ludovic Desroches]
Changes in v4:
 - rebased on next-20181224
 - update Kconfig part to state that this feature is experimental.
 - tested quickly on a single board, SAMA5D2 Xplained, i2c-gpio as master, OK.
Changes in v3:
 - rebase (cherry-pick was enough)
 - fix checkpatch errors
 - tests:
   - hangs with a SAMA5D4 (master and slave on different busses) after about
   100 transfers. It's the first time I do this test.
   - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
   I don't know if it's a regression. I don't remember having seen this
   behavior previously.
   I think it's worth taking those patches even if there are some possible
   bugs. It'll allow to get more people using it and so to consolidate the
   slave mode support.

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

 MAINTAINERS                                   |   3 +-
 drivers/i2c/busses/Kconfig                    |  13 +
 drivers/i2c/busses/Makefile                   |   4 +
 drivers/i2c/busses/i2c-at91-core.c            | 380 +++++++++++++++
 .../busses/{i2c-at91.c => i2c-at91-master.c}  | 453 +-----------------
 drivers/i2c/busses/i2c-at91-slave.c           | 147 ++++++
 drivers/i2c/busses/i2c-at91.h                 | 179 +++++++
 7 files changed, 732 insertions(+), 447 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-at91-core.c
 rename drivers/i2c/busses/{i2c-at91.c => i2c-at91-master.c} (67%)
 create mode 100644 drivers/i2c/busses/i2c-at91-slave.c
 create mode 100644 drivers/i2c/busses/i2c-at91.h

-- 
2.20.1
