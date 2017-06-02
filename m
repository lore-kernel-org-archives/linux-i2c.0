From: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Subject: [PATCHv3 0/4] Add Altera I2C Controller Driver
Date: Fri,  2 Jun 2017 18:52:35 -0500
Message-ID: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, dinguyen-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

This patch seris add the Altera I2C Controller driver for use in FPGAs.

Thor Thayer (4):
  ARM: dts: socfpga: Add Altera I2C Controller to CycloneV
  MAINTAINERS: Add Altera I2C Controller Driver
  dt-bindings: i2c: Add Altera I2C Controller
  i2c: altera: Add Altera I2C Controller driver

 .../devicetree/bindings/i2c/i2c-altera.txt         |  39 ++
 MAINTAINERS                                        |   5 +
 arch/arm/boot/dts/socfpga.dtsi                     |  13 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |  28 +-
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-altera.c                    | 509 +++++++++++++++++++++
 7 files changed, 601 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt
 create mode 100644 drivers/i2c/busses/i2c-altera.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
