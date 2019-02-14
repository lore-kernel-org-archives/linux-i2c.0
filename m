From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
Date: Thu, 14 Feb 2019 09:57:17 -0800
Message-ID: <20190214175725.60462-1-ray.jui@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

This patch series adds the following support to the iProc I2C driver:
- Increase maximum read transfer size to 255 bytes
- I2C slave mode
- Polling mode
- NIC I2C mode

This patch series is based on kernel v5.0-rc3 and available at:
https://github.com/Broadcom/arm64-linux.git
branch: i2c-slave-v5

Changes from v4:
 - Add more detailed explanations in the device tree binding document
   changes, to address Rob's review comments

Changes from v3:
 - Various minor fixes on commit messages and commits
 - Rebased to v5.0-rc3

Changes from v2:
 - Address Ray's review comments.

Changes from v1:
 - Rebased to Linux v5.0.0-rc2

Ray Jui (1):
  dt-bindings: i2c: iproc: make 'interrupts' optional

Rayagonda Kokatanur (5):
  i2c: iproc: add polling support
  i2c: iproc: use wrapper for read/write access
  dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
  i2c: iproc: add NIC I2C support
  arm64: dts: Stingray: Add NIC i2c device node

Shreesha Rajashekar (2):
  i2c: iproc: Extend I2C read up to 255 bytes
  i2c: iproc: Add slave mode support

 .../bindings/i2c/brcm,iproc-i2c.txt           |  17 +-
 .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
 drivers/i2c/busses/Kconfig                    |   1 +
 drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
 4 files changed, 663 insertions(+), 131 deletions(-)

-- 
2.17.1
