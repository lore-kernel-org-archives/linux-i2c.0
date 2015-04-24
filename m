From: Feng Kan <fkan@apm.com>
Subject: [PATCH RESEND V4 0/4] i2c: busses: xgene: I2C proxy driver for X-Gene
Date: Fri, 24 Apr 2015 15:17:49 -0700
Message-ID: <1429913873-13627-1-git-send-email-fkan@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: patches@apm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Feng Kan <fkan@apm.com>
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

