From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH_V3 0/2] i2c: jz4780: Add Ingenic JZ4780 i2c driver
Date: Tue, 31 Mar 2015 14:03:54 +0100
Message-ID: <1427807036-45366-1-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Zubair.Kakakhel@imgtec.com
List-Id: linux-i2c@vger.kernel.org

Hi,

Here we have two patches that add support for the i2c
controller present in the Ingenic JZ4780.

Driver tested on the MIPS Creator CI20.

V2 - > V3
Fixes based on feedback from Wolfram Sang. Thank-you.
Details in individual patch commit message
Rebased to v4.0-rc6

V1 - > V2
Rebased to v4.0-rc3
Minor tweaks/fixes. Details in individual patch commits.

Feedback welcome.

Thank-you
ZubairLK


Zubair Lutfullah Kakakhel (2):
  dt-bindings: i2c: Add dt binding documentation for ingenic jz4780 SoC
  i2c: jz4780: Add i2c bus controller driver for Ingenic JZ4780

 .../devicetree/bindings/i2c/i2c-jz4780.txt         |  35 +
 drivers/i2c/busses/Kconfig                         |   9 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-jz4780.c                    | 832 +++++++++++++++++++++
 4 files changed, 877 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
 create mode 100644 drivers/i2c/busses/i2c-jz4780.c

-- 
1.9.1
