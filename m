From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [RESEND PATCH v6 0/6] i2c: designware: add I2C SLAVE support
Date: Wed,  1 Mar 2017 15:59:40 +0000
Message-ID: <cover.1488383202.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

The purpose of this patchset is to enable Linux to be a I2C slave by 
enabling the slave functionality in the designware I2C controller and at
the same time it does some cleaning of the existing code.

The patch 1 is for cleaning and commentary fix.
The patch 2 refactors the original i2c-designware-core and extracts all
master functions to a i2c-designware-master source file as suggested by
Andy Shevchenko when I first submited the update. The patch 3 then
separates the MASTER flow from the common flow.
The patch 4 introduces the SLAVE necessary definitions to the 
i2c-designware library and adds a how-to-use example to the designware.txt
in device tree bindings.
The patch 5 adds the necessary functions to give the ability to be a SLAVE
to the controller and for that changes also had to be made in the 
Makefile and Kconfig.
The patch 6 enables the SLAVE mode to be detected by the platform module.

The functionality was tested using the hardware independent slave-eeprom
driver based on top of i2c/for-next. The tree I used can be found here:

https://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/log/?h=i2c/for-next

Luis Oliveira (6):
  i2c: designware: Cleaning and comment style fixes.
  i2c: designware: refactoring of the i2c-designware
  i2c: designware: MASTER mode as separated driver
  i2c: designware: introducing I2C_SLAVE definitions
  i2c: designware: add SLAVE mode functions
  i2c: designware: enable SLAVE in platform module

 .../devicetree/bindings/i2c/i2c-designware.txt     |  16 +-
 drivers/i2c/busses/Kconfig                         |  15 +-
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-designware-common.c         | 281 ++++++++++++
 drivers/i2c/busses/i2c-designware-core.h           | 180 +++++++-
 ...c-designware-core.c => i2c-designware-master.c} | 469 +++------------------
 drivers/i2c/busses/i2c-designware-platdrv.c        | 116 +++--
 drivers/i2c/busses/i2c-designware-slave.c          | 403 ++++++++++++++++++
 8 files changed, 1031 insertions(+), 451 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-common.c
 rename drivers/i2c/busses/{i2c-designware-core.c => i2c-designware-master.c} (59%)
 create mode 100644 drivers/i2c/busses/i2c-designware-slave.c

-- 
2.11.0
