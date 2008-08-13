From: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-i801: Fix checkpatch warnings
Date: Wed, 13 Aug 2008 22:48:27 +0200
Message-ID: <48A3489B.6060007@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040003080207000104060706"
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------040003080207000104060706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix all checkpatch warnings for the 2.6.27-rc3 driver and replace a lot 
of spaces by tabs.

Note: no functional changes are made.

Signed-off-by: Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 i2c-i801.c |   70 
++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)



--------------040003080207000104060706
Content-Type: text/plain;
 name="style.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="style.diff"

diff -upr linux-2.6.27-rc3/drivers/i2c/busses/i2c-i801.c linux-2.6.27-rc3.style/drivers/i2c/busses/i2c-i801.c
--- linux-2.6.27-rc3/drivers/i2c/busses/i2c-i801.c	2008-08-13 20:45:50.000000000 +0200
+++ linux-2.6.27-rc3.style/drivers/i2c/busses/i2c-i801.c	2008-08-13 21:43:47.000000000 +0200
@@ -22,32 +22,32 @@
 /*
   Supports the following Intel I/O Controller Hubs (ICH):
 
-                                  I/O                     Block   I2C
-                                  region  SMBus   Block   proc.   block
-  Chip name             PCI ID    size    PEC     buffer  call    read
+				I/O			Block	I2C
+				region	SMBus	Block	proc	block
+  Chip name		PCI ID	size	PEC	buffer	call	read
   ----------------------------------------------------------------------
-  82801AA  (ICH)        0x2413     16      no      no      no      no
-  82801AB  (ICH0)       0x2423     16      no      no      no      no
-  82801BA  (ICH2)       0x2443     16      no      no      no      no
-  82801CA  (ICH3)       0x2483     32     soft     no      no      no
-  82801DB  (ICH4)       0x24c3     32     hard     yes     no      no
-  82801E   (ICH5)       0x24d3     32     hard     yes     yes     yes
-  6300ESB               0x25a4     32     hard     yes     yes     yes
-  82801F   (ICH6)       0x266a     32     hard     yes     yes     yes
-  6310ESB/6320ESB       0x269b     32     hard     yes     yes     yes
-  82801G   (ICH7)       0x27da     32     hard     yes     yes     yes
-  82801H   (ICH8)       0x283e     32     hard     yes     yes     yes
-  82801I   (ICH9)       0x2930     32     hard     yes     yes     yes
-  Tolapai               0x5032     32     hard     yes     yes     yes
-  ICH10                 0x3a30     32     hard     yes     yes     yes
-  ICH10                 0x3a60     32     hard     yes     yes     yes
+  82801AA	(ICH)	0x2413	 16	 no	 no	 no	 no
+  82801AB	(ICH0)	0x2423	 16	 no	 no	 no	 no
+  82801BA	(ICH2)	0x2443	 16	 no	 no	 no	 no
+  82801CA	(ICH3)	0x2483	 32	soft	 no	 no	 no
+  82801DB	(ICH4)	0x24c3	 32	hard	 yes	 no	 no
+  82801E	(ICH5)	0x24d3	 32	hard	 yes	 yes	 yes
+  6300ESB		0x25a4	 32	hard	 yes	 yes	 yes
+  82801F	(ICH6)	0x266a	 32	hard	 yes	 yes	 yes
+  6310ESB/6320ESB	0x269b	 32	hard	 yes	 yes	 yes
+  82801G	(ICH7)	0x27da	 32	hard	 yes	 yes	 yes
+  82801H	(ICH8)	0x283e	 32	hard	 yes	 yes	 yes
+  82801I	(ICH9)	0x2930	 32	hard	 yes	 yes	 yes
+  Tolapai		0x5032	 32	hard	 yes	 yes	 yes
+  ICH10			0x3a30	 32	hard	 yes	 yes	 yes
+  ICH10			0x3a60	 32	hard	 yes	 yes	 yes
 
   Features supported by this driver:
-  Software PEC                     no
-  Hardware PEC                     yes
-  Block buffer                     yes
-  Block process call transaction   no
-  I2C block read transaction       yes  (doesn't use the block buffer)
+  Software PEC				no
+  Hardware PEC				yes
+  Block buffer				yes
+  Block process call transaction	no
+  I2C block read transaction		yes (doesn't use the block buffer)
 
   See the file Documentation/i2c/busses/i2c-i801 for details.
 */
@@ -255,9 +255,9 @@ static void i801_wait_hwpec(void)
 	} while ((!(status & SMBHSTSTS_INTR))
 		 && (timeout++ < MAX_TIMEOUT));
 
-	if (timeout >= MAX_TIMEOUT) {
+	if (timeout >= MAX_TIMEOUT)
 		dev_dbg(&I801_dev->dev, "PEC Timeout!\n");
-	}
+
 	outb_p(status, SMBHSTSTS);
 }
 
@@ -338,9 +338,8 @@ static int i801_block_transaction_byte_b
 		do {
 			msleep(1);
 			status = inb_p(SMBHSTSTS);
-		}
-		while ((!(status & SMBHSTSTS_BYTE_DONE))
-		       && (timeout++ < MAX_TIMEOUT));
+		} while ((!(status & SMBHSTSTS_BYTE_DONE))
+			 && (timeout++ < MAX_TIMEOUT));
 
 		result = i801_check_post(status, timeout >= MAX_TIMEOUT);
 		if (result < 0)
@@ -435,9 +434,9 @@ static int i801_block_transaction(union 
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
@@ -506,7 +505,7 @@ static s32 i801_access(struct i2c_adapte
 	else
 		outb_p(inb_p(SMBAUXCTL) & (~SMBAUXCTL_CRC), SMBAUXCTL);
 
-	if(block)
+	if (block)
 		ret = i801_block_transaction(data, read_write, size, hwpec);
 	else
 		ret = i801_transaction(xact | ENABLE_INT9);
@@ -518,9 +517,9 @@ static s32 i801_access(struct i2c_adapte
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
@@ -579,9 +578,10 @@ static struct pci_device_id i801_ids[] =
 	{ 0, }
 };
 
-MODULE_DEVICE_TABLE (pci, i801_ids);
+MODULE_DEVICE_TABLE(pci, i801_ids);
 
-static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int __devinit i801_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
 {
 	unsigned char temp;
 	int err;

--------------040003080207000104060706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--------------040003080207000104060706--
