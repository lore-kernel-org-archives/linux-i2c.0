From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH 1/1] i2c: i801: Restore the presence state of P2SB PCI device after reading BAR
Date: Tue, 15 Aug 2017 00:04:50 +0800
Message-ID: <20170814160450.21978-1-qiuxu.zhuo@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63978 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753127AbdHOGwp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 15 Aug 2017 02:52:45 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, wsa@the-dreams.de
Cc: tony.luck@intel.com, mika.westerberg@intel.com, bp@alien8.de, linux-i2c@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Sun, Yunying reported the following failure on Denverton micro-server:

 EDAC DEBUG: pnd2_init:
 EDAC DEBUG: pnd2_probe:
 EDAC DEBUG: dnv_rd_reg: Read b_cr_tolud_pci=00000000_80000000
 EDAC DEBUG: dnv_rd_reg: Read b_cr_touud_lo_pci=00000000_80000000
 EDAC DEBUG: dnv_rd_reg: Read b_cr_touud_hi_pci=00000000_00000004
 EDAC DEBUG: dnv_rd_reg: Read b_cr_asym_mem_region0_mchbar=00000000_00000000
 EDAC DEBUG: dnv_rd_reg: Read b_cr_asym_mem_region1_mchbar=00000000_00000000
 EDAC DEBUG: dnv_rd_reg: Read b_cr_mot_out_base_mchbar=00000000_00000000
 EDAC DEBUG: dnv_rd_reg: Read b_cr_mot_out_mask_mchbar=00000000_00000000
 EDAC pnd2: Failed to register device with error -19.

On Denverton micro-server, the presence of the P2SB bridge PCI device is
enabled or disabled by the item 'RelaxSecConf' in BIOS setup menu. When
'RelaxSecConf' is enabled, the P2SB PCI device is present and the pnd2_edac
EDAC driver also uses it to get BAR. Hiding the P2SB PCI device caused the
pnd2_edac EDAC driver failed to get BAR then reported the above failure.

Therefor, store the presence state of P2SB PCI device before unhiding it
for reading BAR and restore the presence state after reading BAR.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reported-and-tested-by: Yunying Sun <yunying.sun@intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index c9536e1..e114e4e 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1332,6 +1332,7 @@ static void i801_add_tco(struct i801_priv *priv)
 	u32 tco_base, tco_ctl;
 	u32 base_addr, ctrl_val;
 	u64 base64_addr;
+	u8 hidden;
 
 	if (!(priv->features & FEATURE_TCO))
 		return;
@@ -1376,8 +1377,10 @@ static void i801_add_tco(struct i801_priv *priv)
 
 	devfn = PCI_DEVFN(PCI_SLOT(pci_dev->devfn), 1);
 
-	/* Unhide the P2SB device */
-	pci_bus_write_config_byte(pci_dev->bus, devfn, 0xe1, 0x0);
+	/* Unhide the P2SB device, if it is hidden */
+	pci_bus_read_config_byte(pci_dev->bus, devfn, 0xe1, &hidden);
+	if (hidden)
+		pci_bus_write_config_byte(pci_dev->bus, devfn, 0xe1, 0x0);
 
 	pci_bus_read_config_dword(pci_dev->bus, devfn, SBREG_BAR, &base_addr);
 	base64_addr = base_addr & 0xfffffff0;
@@ -1385,8 +1388,9 @@ static void i801_add_tco(struct i801_priv *priv)
 	pci_bus_read_config_dword(pci_dev->bus, devfn, SBREG_BAR + 0x4, &base_addr);
 	base64_addr |= (u64)base_addr << 32;
 
-	/* Hide the P2SB device */
-	pci_bus_write_config_byte(pci_dev->bus, devfn, 0xe1, 0x1);
+	/* Hide the P2SB device, if it was hidden before */
+	if (hidden)
+		pci_bus_write_config_byte(pci_dev->bus, devfn, 0xe1, hidden);
 	spin_unlock(&p2sb_spinlock);
 
 	res = &tco_res[ICH_RES_MEM_OFF];
-- 
2.9.0.GIT
