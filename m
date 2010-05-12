From: Farid Hammane <farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-i801: fix all coding style issues found by checkpatch.pl
Date: Wed, 12 May 2010 23:16:48 +0200
Message-ID: <1273699009-915-1-git-send-email-farid.hammane@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org, felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Farid Hammane <farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch fixes up all coding style issues found by the checkpatch.pl tool.
After applying this patch the binary object is still exactly the same.

Signed-off-by: Farid Hammane <farid.hammane-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 299b918..76a010a 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -22,8 +22,8 @@
 /*
   Supports the following Intel I/O Controller Hubs (ICH):
 
-                                  I/O                     Block   I2C
-                                  region  SMBus   Block   proc.   block
+				  I/O                     Block   I2C
+				  region  SMBus   Block   proc.   block
   Chip name             PCI ID    size    PEC     buffer  call    read
   ----------------------------------------------------------------------
   82801AA  (ICH)        0x2413     16      no      no      no      no
@@ -341,8 +341,7 @@ static int i801_block_transaction_byte_by_byte(union i2c_smbus_data *data,
 		do {
 			msleep(1);
 			status = inb_p(SMBHSTSTS);
-		}
-		while ((!(status & SMBHSTSTS_BYTE_DONE))
+		} while ((!(status & SMBHSTSTS_BYTE_DONE))
 		       && (timeout++ < MAX_TIMEOUT));
 
 		result = i801_check_post(status, timeout > MAX_TIMEOUT);
@@ -440,9 +439,9 @@ static int i801_block_transaction(union i2c_smbus_data *data, char read_write,
 }
 
 /* Return negative errno on error. */
-static s32 i801_access(struct i2c_adapter * adap, u16 addr,
+static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		       unsigned short flags, char read_write, u8 command,
-		       int size, union i2c_smbus_data * data)
+		       int size, union i2c_smbus_data *data)
 {
 	int hwpec;
 	int block = 0;
@@ -511,7 +510,7 @@ static s32 i801_access(struct i2c_adapter * adap, u16 addr,
 	else
 		outb_p(inb_p(SMBAUXCTL) & (~SMBAUXCTL_CRC), SMBAUXCTL);
 
-	if(block)
+	if (block)
 		ret = i801_block_transaction(data, read_write, size, hwpec);
 	else
 		ret = i801_transaction(xact | ENABLE_INT9);
@@ -523,9 +522,9 @@ static s32 i801_access(struct i2c_adapter * adap, u16 addr,
 		outb_p(inb_p(SMBAUXCTL) & ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B),
 		       SMBAUXCTL);
 
-	if(block)
+	if (block)
 		return ret;
-	if(ret)
+	if (ret)
 		return ret;
 	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK))
 		return 0;
@@ -585,7 +584,7 @@ static const struct pci_device_id i801_ids[] = {
 	{ 0, }
 };
 
-MODULE_DEVICE_TABLE (pci, i801_ids);
+MODULE_DEVICE_TABLE(pci, i801_ids);
 
 #if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
 static unsigned char apanel_addr;
@@ -689,7 +688,8 @@ static void __devinit dmi_check_onboard_devices(const struct dmi_header *dm,
 }
 #endif
 
-static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int __devinit i801_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
 {
 	unsigned char temp;
 	int err;
-- 
1.7.0
