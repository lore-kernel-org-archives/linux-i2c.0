From: Shah Nehal-Bakulchandra <Nehal-Bakulchandra.Shah@amd.com>
Subject: [PATCH] i2c: designware: Fix regression when dynamic TAR update is disabled
Date: Fri, 10 Feb 2017 01:20:51 +0530
Message-ID: <1486669851-25632-1-git-send-email-Nehal-Bakulchandra.Shah@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com
Cc: lucas.demarchi@intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com, Shah Nehal-Bakulchandra <Nehal-Bakulchandra.Shah@amd.com>, Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
List-Id: linux-i2c@vger.kernel.org

The following commit causes a regression when dynamic TAR update is
disabled:

     commit 63d0f0a6952a1a02bc4f116b7da7c7887e46efa3 ("i2c: designware:
     detect when dynamic tar update is possible")

In such case, the DW_IC_CON_10BITADDR_MASTER is R/W, and is changed
by the logic that's trying to detect  dynamic TAR update.The original
value of DW_IC_CON_10BITADDR_MASTER bit should be restored.

Signed-off-by: Shah Nehal-Bakulchandra <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/i2c/busses/i2c-designware-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 6d81c56..0c57166 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -987,6 +987,11 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	    (reg & DW_IC_CON_10BITADDR_MASTER)) {
 		dev->dynamic_tar_update_enabled = true;
 		dev_dbg(dev->dev, "Dynamic TAR update enabled");
+	} else {
+		/* If test is failed then restore the original value */
+		dev->dynamic_tar_update_enabled = false;
+		dev_dbg(dev->dev, "Dynamic TAR update disable restore the value");
+		dw_writel(dev, reg, DW_IC_CON);
 	}
 
 	i2c_dw_release_lock(dev);
-- 
1.9.1
