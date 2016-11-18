From: Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v3 0/5] i2c: designware: Add slave support
Date: Fri, 18 Nov 2016 11:19:29 +0000
Message-ID: <cover.1479410047.git.lolivei@synopsys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33409 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753175AbcKRLUq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Nov 2016 06:20:46 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

The purpose of this patch is to enable Linux to be a I2C slave by enabling the
slave functionality in the designware I2C controller. The patch refactors the
original i2c-designware-core and extracts all master functions to a
i2c-designware-master source file as suggested by Andy Shevchenko. It also 
creates a i2c-designware-slave source file and keeps the common functions in the
i2c-designware-src source file. For that changes also had to be made in the 
Makefile and Kconfig.
The driver instantiates in slave or master mode by checking the compatible string
of the device tree (see devicetree/bindings/i2c/i2c-designware.txt). ACPI is not
supported.
The functionality was tested using the hardware independent software backend 
slave-eeprom driver.

Luis Oliveira (5):
  i2c: designware: Refactoring of the i2c-designware core and platform
    module
  i2c: designware: Master mode as separated driver
  i2c: designware: Add slave definitions
  i2c: designware: Add slave mode as separated driver
  i2c: designware: Cleaning and commentary fixes

 .../devicetree/bindings/i2c/i2c-designware.txt     |   4 +-
 drivers/i2c/busses/Kconfig                         |   1 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-designware-core.h           | 156 +++++++-
 ...c-designware-core.c => i2c-designware-master.c} | 391 ++----------------
 drivers/i2c/busses/i2c-designware-platdrv.c        | 103 ++++-
 drivers/i2c/busses/i2c-designware-slave.c          | 445 +++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-src.c            | 258 ++++++++++++
 8 files changed, 983 insertions(+), 376 deletions(-)
 rename drivers/i2c/busses/{i2c-designware-core.c => i2c-designware-master.c} (64%)
 create mode 100644 drivers/i2c/busses/i2c-designware-slave.c
 create mode 100644 drivers/i2c/busses/i2c-designware-src.c

-- 
2.10.2
