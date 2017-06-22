From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v12 0/2] i2c: designware: add I2C SLAVE support
Date: Thu, 22 Jun 2017 11:17:31 +0100
Message-ID: <cover.1498126241.git.lolivei@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patches follows the merged patchset that refactors I2C Designware and
enables it to have I2C support.

The patch 1 adds the necessary functions to give the ability to be a SLAVE
to the controller and for that changes also had to be made in the 
Makefile and Kconfig.
The patch 2 enables the SLAVE mode to be detected by the platform module.

The functionality was tested using the hardware independent slave-eeprom
driver based on top of i2c/for-next. The tree I used can be found here:

https://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/log/?h=i2c/for-next

Luis Oliveira (2):
  i2c: designware: add SLAVE mode functions
  i2c: designware: enable SLAVE in platform module

 drivers/i2c/busses/Kconfig                  |  14 +-
 drivers/i2c/busses/Makefile                 |   3 +
 drivers/i2c/busses/i2c-designware-common.c  |   6 +
 drivers/i2c/busses/i2c-designware-core.h    |   4 +
 drivers/i2c/busses/i2c-designware-platdrv.c |  41 ++-
 drivers/i2c/busses/i2c-designware-slave.c   | 395 ++++++++++++++++++++++++++++
 6 files changed, 457 insertions(+), 6 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-slave.c

-- 
2.13.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
