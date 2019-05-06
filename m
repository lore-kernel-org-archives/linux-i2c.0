From: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v1 v1 0/3] Add dt bindings to support I2C on sifive devices and a fix for polling mode i2c transfers.
Date: Mon,  6 May 2019 18:23:57 +0530
Message-ID: <1557147240-29551-1-git-send-email-sagar.kadam@sifive.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, palmer@sifive.com, paul.walmsley@sifive.com, sagar.kadam@sifive.com, peter@korsgaard.com, andrew@lunn.ch, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The patch is based on mainline v5.1 and is intended to add DT-bindings for Opencore based I2C device 
support in FU540 SoC, available on HiFive unleashed board (Rev A00), and also provide a workaround to 
make I2C polling mode interface work with FU540 chipsets.

The polling mode workaround patch fixes the CPU stall issue, when-ever i2c transfer are initiated 

This workaround checks if it's a FU540 chipset based on device tree information, and check's for open
core's IF(interrupt flag) and TIP flags to break from the polling loop upon completion of transfer.

To test the patch, a PMOD-AD2 sensor is connected to HiFive Unleashed board over J1 connector, and 
appropriate device node is added into board specific device tree as per the information provided in 
dt-bindings in Documentation/devicetree/bindings/i2c/i2c-sifive.txt.
Without this workaround, the CPU stall's infinitely.

Busybox i2c utilities used to verify workaround : i2cdetect, i2cdump, i2cset, i2cget


Sagar Shrikant Kadam (3):
  dt-bindings: i2c: add documentation for adding SiFive I2C driver
  i2c-ocore: sifive: add support for i2c device on FU540-c000 SoC.
  i2c-ocores: sifive: add polling mode workaround for FU540-C000 SoC.

 .../devicetree/bindings/i2c/i2c-sifive.txt         | 29 +++++++++++++++++++
 drivers/i2c/busses/i2c-ocores.c                    | 33 +++++++++++++++++++---
 2 files changed, 58 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sifive.txt

-- 
1.9.1
