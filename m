From: Vitor Soares <vitor.soares@synopsys.com>
Subject: [PATCH v4 0/3] Add driver for Synopsys DesignWare I3C master IP
Date: Tue, 13 Nov 2018 14:09:50 +0000
Message-ID: <1542118193-24925-1-git-send-email-vitor.soares@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc: psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vitor.soares@synopsys.com, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org, joao.pinto@synopsys.com
List-Id: linux-i2c@vger.kernel.org

This patch series is a proposal for the I3C master driver for Synopsys IP.
This patch is to be applied on top of I3C subsystem RFC V10 submitted by
Boris Brezillon.

Supported features:
  Regular CCC commands.
  I3C private transfers.
  I2C transfers.

Missing functionalities:
  Support DMA interface.
  Support for I3C_BUS_MODE_MIXED_SLOW.
  Hot-join.
  IBI.

Main change between v3 and v4:
- Minor fixes. They are described in each patch

Main change between v2 and v3:
- Minor fixes. They are described in each patch

Main change between v1 and v2:
- Add controller version on dt-binding
- The driver now calls writesl/readsl() instead readl/writel
- Rename some variables in the driver

Vitor Soares (3):
  i3c: master: Add driver for Synopsys DesignWare IP
  dt-binding: i3c: Document Synopsys DesignWare I3C
  MAINTAINERS: Add myself as the dw-i3c-master module maintainer

 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt |   41 +
 MAINTAINERS                                        |    6 +
 drivers/i3c/master/Kconfig                         |   14 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/dw-i3c-master.c                 | 1216 ++++++++++++++++++++
 5 files changed, 1278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
 create mode 100644 drivers/i3c/master/dw-i3c-master.c

-- 
2.7.4
