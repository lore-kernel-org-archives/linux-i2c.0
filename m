From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH] i2c: i801: fix DNV's SMBCTRL register offset
Date: Mon,  3 Sep 2018 08:37:05 +0300
Message-ID: <20180903053705.9844-1-felipe.balbi@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

DNV's iTCO is slightly different with SMBCTRL sitting at a differnt
offset when compared to all other devices. Let's fix so that we can
properly use iTCO watchdog.

Fixes: 84d7f2ebd70d ("i2c: i801: Add support for Intel DNV")
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 941c223f6491..390bf253b6ea 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1400,6 +1400,11 @@ static void i801_add_tco(struct i801_priv *priv)
 
 	res = &tco_res[ICH_RES_MEM_OFF];
 	res->start = (resource_size_t)base64_addr + SBREG_SMBCTRL;
+
+	/* DNV device has SMBCTRL at 0xcf000c */
+	if (pci_dev->device == PCI_DEVICE_ID_INTEL_DNV_SMBUS)
+		res->start += 0x90000;
+
 	res->end = res->start + 3;
 	res->flags = IORESOURCE_MEM;
 
-- 
2.18.0
