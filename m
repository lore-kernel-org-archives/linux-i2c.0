From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 0/3] i2c: slave support framework for Linux devices
Date: Tue, 18 Nov 2014 17:04:52 +0100
Message-ID: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Finally, here is my take on the often desired feature that Linux can not only
be an I2C master, but also an I2C slave. Since RFC, most open issues have been
dealt with. Find details in the patch descriptions. Documentation is still
missing and will come later this or next week, but surely early enough for
the 3.19 release which this series wants to go in. Yet, I'd like to encourage
code-review and build-testing already.

Basically, an I2C slave is a standard I2C client providing a callback function.
When registering as a slave, the connection to the I2C adapter is made which
uses the callback when a slave event happens. That splits the HW support
(enabling slave mode on the adapter) and SW support (here a generic eeprom
simulator) nicely IMO.

The patches have been tested with a Renesas R8A7790 based Lager board. They are
based on top of 3.18-rc5, but will easily apply to renesas/devel. A git tree
can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/slave-support

Comments welcome! Thanks,

   Wolfram


Wolfram Sang (3):
  i2c: core changes for slave support
  i2c: slave-eeprom: add eeprom simulator driver
  i2c: rcar: add slave support

 drivers/i2c/Kconfig            |  10 +++
 drivers/i2c/Makefile           |   1 +
 drivers/i2c/busses/i2c-rcar.c  | 125 +++++++++++++++++++++++++++---
 drivers/i2c/i2c-core.c         |  49 ++++++++++++
 drivers/i2c/i2c-slave-eeprom.c | 170 +++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h            |  29 +++++++
 6 files changed, 375 insertions(+), 9 deletions(-)
 create mode 100644 drivers/i2c/i2c-slave-eeprom.c

-- 
2.1.1
