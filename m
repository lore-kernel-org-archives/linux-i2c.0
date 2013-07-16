From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: [PATCH v2 0/2] New driver: i2c_imc (Intel LGA2011 iMC SMBUS)
Date: Tue, 16 Jul 2013 15:23:25 -0700
Message-ID: <cover.1374012684.git.luto@amacapital.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Intel's LGA2011 chips (Core i7 Extreme and Xeon E5) have two SMBUS
controllers per package, addressing up to 16 DIMM slots per package.
This is a driver for those SMBUS channels.

The first patch is a minor change to the i2c core to make it work
better with extremely limited hardware like this.  The second patch is
the driver.

Changes from the RFC / v1: Work around an erratum that gave random
incorrect reads on multi-socket systems.

Andy Lutomirski (2):
  i2c: Allow SPD probing with READ_BYTE_DATA and improve logging
  i2c_imc: New driver for Intel's iMC, found on LGA2011 chips

 drivers/i2c/busses/Kconfig   |  14 ++
 drivers/i2c/busses/Makefile  |   1 +
 drivers/i2c/busses/i2c-imc.c | 546 +++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c       |   7 +-
 4 files changed, 567 insertions(+), 1 deletion(-)
 create mode 100644 drivers/i2c/busses/i2c-imc.c

-- 
1.8.1.4
