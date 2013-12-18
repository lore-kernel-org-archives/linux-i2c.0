From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH V2 0/5] arm: shmobile: r7s72100: add native i2c support
Date: Wed, 18 Dec 2013 22:31:56 +0100
Message-ID: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Here is a series to support the I2C core of the r7s72100 natively. It has been
tested with a genmai board where an eeprom is connected. The series can be
found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/riic

It is based on the latest r7s72100 topic branch from Simon and the latest patch
series from Magnus. Note there is one issue with the current PFC driver which
needs to be sorted out. Check patch 1/5 for details.

I've addressed all comments from V1. See patches for details.

Comments welcome. Thanks,

   Wolfram


Wolfram Sang (5):
  pinctrl: r7s72100: add riic groups
  arm: shmobile: r7s72100: add i2c clocks
  arm: shmobile: r7s72100: add nodes for i2c controllers to dtsi
  arm: shmobile: genmai: adapt dts to use native i2c driver
  i2c: riic: add driver

 Documentation/devicetree/bindings/i2c/i2c-riic.txt |  29 ++
 arch/arm/boot/dts/r7s72100-genmai-reference.dts    |  29 +-
 arch/arm/boot/dts/r7s72100.dtsi                    | 102 +++++
 arch/arm/mach-shmobile/clock-r7s72100.c            |  12 +-
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-riic.c                      | 426 +++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r7s72100.c              |  45 +++
 8 files changed, 635 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-riic.txt
 create mode 100644 drivers/i2c/busses/i2c-riic.c

-- 
1.8.4.2
