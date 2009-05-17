From: Harald Welte <HaraldWelte-yS34VQbMlVtBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] [I2C] i2c-viapro: Add new PCI device ID For VX855
Date: Sun, 17 May 2009 14:04:39 +0800
Message-ID: <20090517060439.GE4909@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The south bridge of the VIA VX855 chipset has a different PCI Device ID
so i2c-viapro.c needs to be updated with this.

Signed-off-by: Harald Welte <HaraldWelte-yS34VQbMlVtBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-viapro.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
index 02e6f72..7a0b15a 100644
--- a/drivers/i2c/busses/i2c-viapro.c
+++ b/drivers/i2c/busses/i2c-viapro.c
@@ -37,6 +37,7 @@
    VT8251             0x3287             yes
    CX700              0x8324             yes
    VX800/VX820        0x8353             yes
+   VX855/VX875        0x8409             yes
 
    Note: we assume there can only be one device, with one SMBus interface.
 */
@@ -469,6 +470,8 @@ static struct pci_device_id vt596_ids[] = {
 	  .driver_data = SMBBA3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX800),
 	  .driver_data = SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX855),
+	  .driver_data = SMBBA3 },
 	{ 0, }
 };
 
-- 
1.6.2.4
