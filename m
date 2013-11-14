From: "Tim Kryger" <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 0/5] Add-Broadcom-Kona-I2C-Support
Date: Thu, 14 Nov 2013 13:02:11 -0800
Message-ID: <1384462936-7906-1-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Doc List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linaro Patches List <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This series adds support for the Kona I2C bus found on Broadcom mobile
SoCs like the bcm11351 (aka bcm281xx) and enables it on the bcm28155-ap
board.

It depends upon the following commit:
  http://lkml.indiana.edu/hypermail/linux/kernel/1311.1/03583.html

Tim Kryger (5):
  Documentation: dt: Add i2c-bcm-kona binding
  i2c: i2c-bcm-kona: Introduce Broadcom I2C Driver
  i2c: i2c-bcm-kona: Add support for high-speed mode
  ARM: dts: bcm281xx: Add i2c busses
  ARM: dts: bcm28155-ap: Enable all the i2c busses

 .../devicetree/bindings/i2c/i2c-bcm-kona.txt       |  35 +
 arch/arm/boot/dts/bcm11351.dtsi                    |  40 +
 arch/arm/boot/dts/bcm28155-ap.dts                  |  20 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-bcm-kona.c                  | 908 +++++++++++++++++++++
 6 files changed, 1014 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-bcm-kona.txt
 create mode 100644 drivers/i2c/busses/i2c-bcm-kona.c

-- 
1.8.0.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
