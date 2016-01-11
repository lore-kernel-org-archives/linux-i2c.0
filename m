From: Andreas Werner <andreas.werner@men.de>
Subject: [PATCH v2 0/4] remove auto exit of production and added sysfs
 interface
Date: Mon, 11 Jan 2016 13:20:59 +0100
Message-ID: <cover.1452514293.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, sameo@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This patch set introduces new sysfs entries for BMC status information
as well as the ABI documention.

The mfd core driver now does not exit the production mode automatically.
The new sysfs entry allows the userland to exit the production mode
if required.

Changes in v2:
	- added I2C maintainer in CC because this patches
	  are also I2C related.
	- fixed irrelevant changes (alignments) in the mfd driver
	- update subject lines 
	  that they match the format of the subsystem

Andreas Werner (4):
  mfd: menf21bmc: Remove auto exiting of production mode and add sysfs
    interface
  doc: ABI: Added sysfs description for the menf21bmc MFD driver
  mfd: menf21bmc: Add additional sysfs entries for BMC status
    information
  doc: ABI: Add documentation for the additional sysfs status
    information

 .../ABI/testing/sysfs-bus-i2c-devices-menf21bmc    |  40 ++++++
 drivers/mfd/menf21bmc.c                            | 158 ++++++++++++++++++---
 2 files changed, 177 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-menf21bmc

-- 
2.6.2
