From: Luis.Oliveira@synopsys.com
Subject: [PATCH v2 0/4] Add slave mode to Synopsys I2C driver
Date: Fri, 14 Oct 2016 17:52:47 +0100
Message-ID: <cover.1476462204.git.lolivei@synopsys.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:59084 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbcJNQxe (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 14 Oct 2016 12:53:34 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: Luis.Oliveira@synopsys.com, CARLOS.PALMINHA@synopsys.com, Ramiro.Oliveira@synopsys.com

From: Luis Oliveira <lolivei@synopsys.com>

Add support in existing I2C Designware Core driver for I2C slave mode. 
Refactored *_master() functions out of existing ones in the first patch
Added *_slave() functions to enable Slave mode. 
Updated the description of the i2c-designware.txt and changed Kconfig to 
auto enable I2C Slave support.

V2: Splitted the patch in *_master() and *_slave() and updated Kconfig. 

Luis Oliveira (4):
  Factor out _master() parts of code and identify as much as possible
    all related with MASTER mode
  Added I2C_SLAVE as a dependency to I2C_DESIGNWARE_CORE Enable _slave()
    mode Review of the pm_runtime...() methods and cleaning
  Device bindings documentation updated ACPI-enabled platforms not
    currently supported
  Cleaning

 .../devicetree/bindings/i2c/i2c-designware.txt     |   5 +-
 drivers/i2c/busses/Kconfig                         |   3 +-
 drivers/i2c/busses/i2c-designware-core.c           | 238 ++++++++++++++++++---
 drivers/i2c/busses/i2c-designware-core.h           |   6 +
 drivers/i2c/busses/i2c-designware-platdrv.c        |  68 ++++--
 5 files changed, 280 insertions(+), 40 deletions(-)

-- 
2.10.1
