From: Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v6 0/2] i2c: npcm: add NPCM i2c controller driver
Date: Wed, 20 Nov 2019 09:36:20 +0200
Message-ID: <20191120073622.37938-1-tali.perry1@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, yuenn@google.com, venture@google.com, benjaminfair@google.com, avifishman70@gmail.com, joel@jms.id.au, tmaimon77@gmail.com, wsa@the-dreams.de, syniurge@gmail.com
Cc: linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>, Rob Herring <robh@kernel.org>
List-Id: linux-i2c@vger.kernel.org

This patch set adds i2c controller support 
for the Nuvoton NPCM Baseboard Management Controller (BMC).

NPCM7xx includes 16 I2C controllers. This driver operates the controller.
This module also includes a slave mode.

---
v6 -> v5:
	- Update documentation

v5 -> v4:
	- support recovery
	- master-slave switch support needed for IPMB

v4 -> v3:
	- typo on cover letter.

v3 -> v2:
	- fix dt binding: compatible name: omit "bus"

v2 -> v1:
	- run check patch in strict mode.
	- use linux crc.
	- define regs in constant offset without base.
	- remove debug prints.
	- no declarations for local functions.
	
v1: initial version

Signed-off-by: Tali Perry <tali.perry1@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Tali Perry (2):
  Added device tree binding documentation for Nuvoton BMC NPCM I2C
    controller.
  Add Nuvoton NPCM BMC I2C controller driver.

 .../devicetree/bindings/i2c/i2c-npcm7xx.txt   |   29 +
 drivers/i2c/busses/Kconfig                    |   11 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/i2c-npcm7xx.c              | 2486 +++++++++++++++++
 4 files changed, 2527 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
 create mode 100644 drivers/i2c/busses/i2c-npcm7xx.c

-- 
2.22.0
