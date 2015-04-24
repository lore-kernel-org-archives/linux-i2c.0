From: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH V4 0/4] i2c: busses: xgene: I2C proxy driver for X-Gene
Date: Fri, 24 Apr 2015 10:11:29 -0700
Message-ID: <1429895493-30176-1-git-send-email-fkan@apm.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: patches-qTEPVZfXA3Y@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a proxy I2C driver for APM X-Gene SoC. It uses the mailbox driver
to tunnel i2c transactions via the SLIMpro processor.

V4 Change:
	- Remove PRP0001 and use a real ACPI id
V3 Change:
	- Add ACPI support
	- Fix previous comments.

Feng Kan (4):
  i2c: busses: add SLIMpro I2C device driver on APM X-Gene platform
  i2c: busses: xgene: add acpi support for i2c xgene SLIMpro driver
  Documentation: i2c: Add APM X-Gene platform SLIMpro I2C driver
    documentation
  arm64: dts: add proxy I2C device driver on APM X-Gene platform

 .../devicetree/bindings/i2c/i2c-xgene-slimpro.txt  |  15 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   5 +
 drivers/i2c/busses/Kconfig                         |   9 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-xgene-slimpro.c             | 469 +++++++++++++++++++++
 5 files changed, 499 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-xgene-slimpro.txt
 create mode 100644 drivers/i2c/busses/i2c-xgene-slimpro.c

-- 
1.9.1
