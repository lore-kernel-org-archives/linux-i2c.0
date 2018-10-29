From: Vitor soares <vitor.soares@synopsys.com>
Subject: [PATCH 0/3] Add driver for Synopsys DesignWare I3C master IP
Date: Mon, 29 Oct 2018 10:06:55 +0000
Message-ID: <1540807618-13246-1-git-send-email-soares@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc: psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vitor.soares@synopsys.com, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, mshettel@codeaurora.org, swboyd@chromium.org, joao.pinto@synopsys.com, luis.oliveira@synopsys.com, manuel.abreu@synopsys.com, gustavo.pimentel@synopsys.com
List-Id: linux-i2c@vger.kernel.org

This patch series is a proposal for the I3C master driver for Synopsys IP.
This patch is to be applied on top of I3C subsystem RFC V10 submitted bu Boris Brezillon.

The change made on bufs passed to i3c_master_send_ccc_cmd_locked() be dynamically allocated allow the use of writesl/readsl() function on I3C transfers.
For I2C transfers still have memory misalignment on bufs and if the client try to read more than 4bytes the system stops. This will fixed next version.

Supported features:
  Regular CCC commands.
  I3C private transfers.
  I2C transfers.

Missing functionalities:
  Support for I3C_BUS_MODE_MIXED_SLOW.
  Hot-join.
  IBI.

Main change between v1 and v2:
  Add controller version on dt-binding
  The driver now calls writesl/readsl() instead readl/writel
  Rename some variables in the driver
   

Vitor soares (3):
  i3c: master: Add driver for Synopsys DesignWare IP
  dt-bindings: i3c: Document Synopsys DesignWare I3C master bindings
  MAINTAINERS: Add myself as the dw-i3c-master module maintainer

 .../devicetree/bindings/i3c/snps,dw-i3c-master.txt |   42 +
 MAINTAINERS                                        |    6 +
 drivers/i3c/master/Kconfig                         |   13 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/dw-i3c-master.c                 | 1217 ++++++++++++++++++++
 5 files changed, 1279 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
 create mode 100755 drivers/i3c/master/dw-i3c-master.c

-- 
2.7.4
