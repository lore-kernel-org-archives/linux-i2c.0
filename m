From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Fix all checkpatch warnings
Date: Mon, 29 Mar 2010 16:43:31 +0200
Message-ID: <20100329164331.0d4fb69d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Fix all checkpatch warnings. No functional changes are made.

Signed-off-by: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
I can't remember why this patch didn't make it upstream back then, but
it's about time to get it there.

 drivers/i2c/busses/i2c-i801.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)


--- linux-2.6.34-rc1.orig/drivers/i2c/busses/i2c-i801.c	2010-03-15 10:53:11.000000000 +0100
+++ linux-2.6.34-rc1/drivers/i2c/busses/i2c-i801.c	2010-03-15 14:45:42.000000000 +0100
@@ -352,9 +352,8 @@ static int i801_block_transaction_byte_b
 		do {
 			msleep(1);
 			status = inb_p(SMBHSTSTS);
-		}
-		while ((!(status & SMBHSTSTS_BYTE_DONE))
-		       && (timeout++ < MAX_TIMEOUT));
+		} while ((!(status & SMBHSTSTS_BYTE_DONE))
+			 && (timeout++ < MAX_TIMEOUT));
 
 		result = i801_check_post(status, timeout > MAX_TIMEOUT);
 		if (result < 0)
@@ -451,9 +450,9 @@ static int i801_block_transaction(union
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
@@ -522,7 +521,7 @@ static s32 i801_access(struct i2c_adapte
 	else
 		outb_p(inb_p(SMBAUXCTL) & (~SMBAUXCTL_CRC), SMBAUXCTL);
 
-	if(block)
+	if (block)
 		ret = i801_block_transaction(data, read_write, size, hwpec);
 	else
 		ret = i801_transaction(xact | ENABLE_INT9);
@@ -534,9 +533,9 @@ static s32 i801_access(struct i2c_adapte
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
@@ -596,7 +595,7 @@ static const struct pci_device_id i801_i
 	{ 0, }
 };
 
-MODULE_DEVICE_TABLE (pci, i801_ids);
+MODULE_DEVICE_TABLE(pci, i801_ids);
 
 #if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
 static unsigned char apanel_addr;
@@ -700,7 +699,8 @@ static void __devinit dmi_check_onboard_
 }
 #endif
 
-static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int __devinit i801_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
 {
 	unsigned char temp;
 	int err, i;


-- 
Jean Delvare
