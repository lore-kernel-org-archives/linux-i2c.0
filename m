From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH 0/4] i2c: i2c-au1550 updates
Date: Thu, 14 Jul 2011 10:56:51 +0200
Message-ID: <1310633815-18817-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The following patches remove some bit-rot from the i2c-au1550 driver.
(Patch #3 supersedes the one I sent on 2011-06-12:
 "i2c-au1550: increase timeout waiting for transactions to finish").

#1 gets rid of all instances of the "volatile" keyword,
#2 removes an unused context member,
#3 fixes i2c on the db1300 board
#4 updates PM methods.

All run- and pm-tested on db1200 and db1300 hardware.

Please consider for 3.1.

Manuel Lauss (4):
  i2c/au1550: remove usage of volatile keyword
  i2c/au1550: remove unused ack_timeout
  i2c/au1550: increase timeout limit
  i2c/au1550: dev_pm_ops conversion

 arch/mips/include/asm/mach-au1x00/au1xxx_psc.h |   13 -
 drivers/i2c/busses/i2c-au1550.c                |  280 ++++++++++--------------
 2 files changed, 114 insertions(+), 179 deletions(-)

-- 
1.7.6
