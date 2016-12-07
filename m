From: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 0/5] i2c: designware: Add slave support
Date: Wed,  7 Dec 2016 17:55:47 +0000
Message-ID: <cover.1481131072.git.lolivei@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The purpose of this patch is to enable Linux to be a I2C slave by enabling the
slave functionality in the designware I2C controller. The patch refactors the
original i2c-designware-core and extracts all master functions to a
i2c-designware-master source file as suggested by Andy Shevchenko. It also 
creates a i2c-designware-slave source file and keeps the common functions in the
i2c-designware-src source file. For that changes also had to be made in the 
Makefile and Kconfig.
The driver instantiates in slave or master mode by checking the compatible string
of the device tree (see devicetree/bindings/i2c/i2c-designware.txt). ACPI is not
supported.
The functionality was tested using the hardware independent software backend 
slave-eeprom driver.

Luis Oliveira (5):
  i2c: designware: Refactoring of the i2c-designware
  i2c: designware: Master mode as separated driver
  i2c: designware: Add slave definitions
  i2c: designware: Add slave mode as separated driver
  i2c: designware: Cleaning comments and formatation

 .../devicetree/bindings/i2c/i2c-designware.txt     |   4 +
 drivers/i2c/busses/Kconfig                         |   1 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-designware-common.c         | 258 ++++++++++++
 drivers/i2c/busses/i2c-designware-core.h           | 158 ++++++++
 ...c-designware-core.c => i2c-designware-master.c} | 380 ++----------------
 drivers/i2c/busses/i2c-designware-platdrv.c        | 106 ++++-
 drivers/i2c/busses/i2c-designware-slave.c          | 435 +++++++++++++++++++++
 8 files changed, 973 insertions(+), 370 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-common.c
 rename drivers/i2c/busses/{i2c-designware-core.c => i2c-designware-master.c} (66%)
 create mode 100644 drivers/i2c/busses/i2c-designware-slave.c

-- 
2.11.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
