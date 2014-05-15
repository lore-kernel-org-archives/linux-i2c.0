From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/4] i2c: designware: Fixes for Asus T100 and Haswell PCI IDs
Date: Thu, 15 May 2014 17:37:20 +0300
Message-ID: <1400164644-3222-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Yao Jin <yao.jin@intel.com>, Aubrey Li <aubrey.li@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Patches 1-3 are needed in order to get runtime PM working properly on Intel
Baytrail based tablets, like on Asus T100. We need to re-initialize the
controller on resume.

Patch 4 adds Haswell PCI IDs to the driver. It is independent of the
preceding patches but I decided to include it here as well. Haswell based
chromebooks need this.

Mika Westerberg (4):
  i2c: designware: No need to disable already disabled controller
  i2c: designware: Disable device on system suspend
  i2c: designware: Add runtime PM hooks
  i2c: designware-pci: Add Haswell PCI IDs

 drivers/i2c/busses/i2c-designware-core.c    |  4 ++++
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 22 ++++++++++++++++++++++
 drivers/i2c/busses/i2c-designware-platdrv.c | 13 ++++++-------
 3 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.0.0.rc2
