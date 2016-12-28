From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v5 0/7] i2c: designware: add I2C SLAVE support
Date: Wed, 28 Dec 2016 14:43:19 +0000
Message-ID: <cover.1482934380.git.lolivei@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

The purpose of this patch is to enable Linux to be a I2C slave by enabling the
slave functionality in the designware I2C controller. The patch refactors the
original i2c-designware-core and extracts all master functions to a
i2c-designware-master source file as suggested by Andy Shevchenko. It also 
creates a i2c-designware-slave source file and keeps the common functions in the
i2c-designware-src source file. For that changes also had to be made in the 
Makefile and Kconfig.
The driver instantiates in slave or master mode by checking the reg address that
must be defined in the DT and evaluating if is a I2C_OWN_SLAVE_ADDRESS". 
ACPI is not supported in this driver.
The functionality was tested using the hardware independent software backend 
slave-eeprom driver.

Luis Oliveira (7):
  i2c: designware: Cleaning and comment style fixes.
  i2c: designware: refactoring of the i2c-designware
  i2c: designware: MASTER mode as separated driver
  i2c: designware: introducing I2C_SLAVE definitions
  i2c: designware: add SLAVE mode functions
  i2c: designware: enable SLAVE in platform module
  i2c: designware: style changes in existing code

 drivers/i2c/busses/Kconfig                         |   3 +-
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-designware-common.c         | 261 ++++++++++++
 drivers/i2c/busses/i2c-designware-core.h           | 164 ++++++++
 ...c-designware-core.c => i2c-designware-master.c} | 444 +++------------------
 drivers/i2c/busses/i2c-designware-platdrv.c        | 144 +++++--
 drivers/i2c/busses/i2c-designware-slave.c          | 434 ++++++++++++++++++++
 7 files changed, 1029 insertions(+), 422 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-designware-common.c
 rename drivers/i2c/busses/{i2c-designware-core.c => i2c-designware-master.c} (62%)
 create mode 100644 drivers/i2c/busses/i2c-designware-slave.c

-- 
2.11.0
