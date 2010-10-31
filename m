From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [PATCH 1/2 v2] i2c-i801: Handle multiple instances instead of
 keeping global state
Date: Sun, 31 Oct 2010 11:19:42 -0400
Message-ID: <1288538382.4570.48.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

It's poor form to keep driver state in global variables rather than
per-instance. It never really mattered in practice when there was only
one controller on the chipset =E2=80=94 but the latest chipsets do have=
 more
than one controller, so now we care.

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
I still think the paragraph above is entirely redundant for any
half-sane reader, but it doesn't do any harm.

This is only compile tested, but the changes from the previous version
are fairly trivial and cosmetic, and it is ObviouslyCorrect=E2=84=A2

Have fixed the complaints where I had succumbed to the temptation to le=
t
emacs 'fix' indentation on lines I was (almost) touching anyway, and th=
e
temptation to fix the copyright headers which looked fairly messy to me
and which I had originally cleaned up. The company do ask me to put
correct copyright headers in code I touch, so I have still done that.

It now uses i2c_[gs]et_drvdata() instead of recasting pointers. Not tha=
t
we could ever build the kernel with strict-aliasing anyway, but OK.

 drivers/i2c/busses/i2c-i801.c |  315 ++++++++++++++++++++++-----------=
--------
 1 files changed, 171 insertions(+), 144 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i80=
1.c
index 1fe30da..404ca3f 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -3,6 +3,7 @@
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, and Mark D. Studebaker
     <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
     Copyright (C) 2007, 2008   Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+    Copyright =C2=A9 2010 Intel Corporation, David Woodhouse <dwmw2@in=
fradead.org>
=20
     This program is free software; you can redistribute it and/or modi=
fy
     it under the terms of the GNU General Public License as published =
by
@@ -55,8 +56,6 @@
   See the file Documentation/i2c/busses/i2c-i801 for details.
 */
=20
-/* Note: we assume there can only be one I801, with one SMBus interfac=
e */
-
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -70,16 +69,16 @@
 #include <linux/dmi.h>
=20
 /* I801 SMBus address offsets */
-#define SMBHSTSTS	(0 + i801_smba)
-#define SMBHSTCNT	(2 + i801_smba)
-#define SMBHSTCMD	(3 + i801_smba)
-#define SMBHSTADD	(4 + i801_smba)
-#define SMBHSTDAT0	(5 + i801_smba)
-#define SMBHSTDAT1	(6 + i801_smba)
-#define SMBBLKDAT	(7 + i801_smba)
-#define SMBPEC		(8 + i801_smba)		/* ICH3 and later */
-#define SMBAUXSTS	(12 + i801_smba)	/* ICH4 and later */
-#define SMBAUXCTL	(13 + i801_smba)	/* ICH4 and later */
+#define SMBHSTSTS(p)	(0 + (p)->smba)
+#define SMBHSTCNT(p)	(2 + (p)->smba)
+#define SMBHSTCMD(p)	(3 + (p)->smba)
+#define SMBHSTADD(p)	(4 + (p)->smba)
+#define SMBHSTDAT0(p)	(5 + (p)->smba)
+#define SMBHSTDAT1(p)	(6 + (p)->smba)
+#define SMBBLKDAT(p)	(7 + (p)->smba)
+#define SMBPEC(p)	(8 + (p)->smba)		/* ICH3 and later */
+#define SMBAUXSTS(p)	(12 + (p)->smba)	/* ICH4 and later */
+#define SMBAUXCTL(p)	(13 + (p)->smba)	/* ICH4 and later */
=20
 /* PCI Address Constants */
 #define SMBBAR		4
@@ -128,16 +127,20 @@
 				 SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
 				 SMBHSTSTS_INTR)
=20
-static unsigned long i801_smba;
-static unsigned char i801_original_hstcfg;
+struct i801_priv {
+	struct i2c_adapter adapter;
+	unsigned long smba;
+	unsigned char original_hstcfg;
+	struct pci_dev *pci_dev;
+	unsigned int features;
+};
+
 static struct pci_driver i801_driver;
-static struct pci_dev *I801_dev;
=20
 #define FEATURE_SMBUS_PEC	(1 << 0)
 #define FEATURE_BLOCK_BUFFER	(1 << 1)
 #define FEATURE_BLOCK_PROC	(1 << 2)
 #define FEATURE_I2C_BLOCK_READ	(1 << 3)
-static unsigned int i801_features;
=20
 static const char *i801_feature_names[] =3D {
 	"SMBus PEC",
@@ -152,24 +155,24 @@ MODULE_PARM_DESC(disable_features, "Disable selec=
ted driver features");
=20
 /* Make sure the SMBus host is ready to start transmitting.
    Return 0 if it is, -EBUSY if it is not. */
-static int i801_check_pre(void)
+static int i801_check_pre(struct i801_priv *priv)
 {
 	int status;
=20
-	status =3D inb_p(SMBHSTSTS);
+	status =3D inb_p(SMBHSTSTS(priv));
 	if (status & SMBHSTSTS_HOST_BUSY) {
-		dev_err(&I801_dev->dev, "SMBus is busy, can't use it!\n");
+		dev_err(&priv->pci_dev->dev, "SMBus is busy, can't use it!\n");
 		return -EBUSY;
 	}
=20
 	status &=3D STATUS_FLAGS;
 	if (status) {
-		dev_dbg(&I801_dev->dev, "Clearing status flags (%02x)\n",
+		dev_dbg(&priv->pci_dev->dev, "Clearing status flags (%02x)\n",
 			status);
-		outb_p(status, SMBHSTSTS);
-		status =3D inb_p(SMBHSTSTS) & STATUS_FLAGS;
+		outb_p(status, SMBHSTSTS(priv));
+		status =3D inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
 		if (status) {
-			dev_err(&I801_dev->dev,
+			dev_err(&priv->pci_dev->dev,
 				"Failed clearing status flags (%02x)\n",
 				status);
 			return -EBUSY;
@@ -180,48 +183,48 @@ static int i801_check_pre(void)
 }
=20
 /* Convert the status register to an error code, and clear it. */
-static int i801_check_post(int status, int timeout)
+static int i801_check_post(struct i801_priv *priv, int status, int tim=
eout)
 {
 	int result =3D 0;
=20
 	/* If the SMBus is still busy, we give up */
 	if (timeout) {
-		dev_err(&I801_dev->dev, "Transaction timeout\n");
+		dev_err(&priv->pci_dev->dev, "Transaction timeout\n");
 		/* try to stop the current command */
-		dev_dbg(&I801_dev->dev, "Terminating the current operation\n");
-		outb_p(inb_p(SMBHSTCNT) | SMBHSTCNT_KILL, SMBHSTCNT);
+		dev_dbg(&priv->pci_dev->dev, "Terminating the current operation\n");
+		outb_p(inb_p(SMBHSTCNT(priv)) | SMBHSTCNT_KILL, SMBHSTCNT(priv));
 		msleep(1);
-		outb_p(inb_p(SMBHSTCNT) & (~SMBHSTCNT_KILL), SMBHSTCNT);
+		outb_p(inb_p(SMBHSTCNT(priv)) & (~SMBHSTCNT_KILL), SMBHSTCNT(priv));
=20
 		/* Check if it worked */
-		status =3D inb_p(SMBHSTSTS);
+		status =3D inb_p(SMBHSTSTS(priv));
 		if ((status & SMBHSTSTS_HOST_BUSY) ||
 		    !(status & SMBHSTSTS_FAILED))
-			dev_err(&I801_dev->dev,
+			dev_err(&priv->pci_dev->dev,
 				"Failed terminating the transaction\n");
-		outb_p(STATUS_FLAGS, SMBHSTSTS);
+		outb_p(STATUS_FLAGS, SMBHSTSTS(priv));
 		return -ETIMEDOUT;
 	}
=20
 	if (status & SMBHSTSTS_FAILED) {
 		result =3D -EIO;
-		dev_err(&I801_dev->dev, "Transaction failed\n");
+		dev_err(&priv->pci_dev->dev, "Transaction failed\n");
 	}
 	if (status & SMBHSTSTS_DEV_ERR) {
 		result =3D -ENXIO;
-		dev_dbg(&I801_dev->dev, "No response\n");
+		dev_dbg(&priv->pci_dev->dev, "No response\n");
 	}
 	if (status & SMBHSTSTS_BUS_ERR) {
 		result =3D -EAGAIN;
-		dev_dbg(&I801_dev->dev, "Lost arbitration\n");
+		dev_dbg(&priv->pci_dev->dev, "Lost arbitration\n");
 	}
=20
 	if (result) {
 		/* Clear error flags */
-		outb_p(status & STATUS_FLAGS, SMBHSTSTS);
-		status =3D inb_p(SMBHSTSTS) & STATUS_FLAGS;
+		outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
+		status =3D inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
 		if (status) {
-			dev_warn(&I801_dev->dev, "Failed clearing status "
+			dev_warn(&priv->pci_dev->dev, "Failed clearing status "
 				 "flags at end of transaction (%02x)\n",
 				 status);
 		}
@@ -230,86 +233,88 @@ static int i801_check_post(int status, int timeou=
t)
 	return result;
 }
=20
-static int i801_transaction(int xact)
+static int i801_transaction(struct i801_priv *priv, int xact)
 {
 	int status;
 	int result;
 	int timeout =3D 0;
=20
-	result =3D i801_check_pre();
+	result =3D i801_check_pre(priv);
 	if (result < 0)
 		return result;
=20
 	/* the current contents of SMBHSTCNT can be overwritten, since PEC,
 	 * INTREN, SMBSCMD are passed in xact */
-	outb_p(xact | I801_START, SMBHSTCNT);
+	outb_p(xact | I801_START, SMBHSTCNT(priv));
=20
 	/* We will always wait for a fraction of a second! */
 	do {
 		msleep(1);
-		status =3D inb_p(SMBHSTSTS);
+		status =3D inb_p(SMBHSTSTS(priv));
 	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT))=
;
=20
-	result =3D i801_check_post(status, timeout > MAX_TIMEOUT);
+	result =3D i801_check_post(priv, status, timeout > MAX_TIMEOUT);
 	if (result < 0)
 		return result;
=20
-	outb_p(SMBHSTSTS_INTR, SMBHSTSTS);
+	outb_p(SMBHSTSTS_INTR, SMBHSTSTS(priv));
 	return 0;
 }
=20
 /* wait for INTR bit as advised by Intel */
-static void i801_wait_hwpec(void)
+static void i801_wait_hwpec(struct i801_priv *priv)
 {
 	int timeout =3D 0;
 	int status;
=20
 	do {
 		msleep(1);
-		status =3D inb_p(SMBHSTSTS);
+		status =3D inb_p(SMBHSTSTS(priv));
 	} while ((!(status & SMBHSTSTS_INTR))
 		 && (timeout++ < MAX_TIMEOUT));
=20
 	if (timeout > MAX_TIMEOUT)
-		dev_dbg(&I801_dev->dev, "PEC Timeout!\n");
+		dev_dbg(&priv->pci_dev->dev, "PEC Timeout!\n");
=20
-	outb_p(status, SMBHSTSTS);
+	outb_p(status, SMBHSTSTS(priv));
 }
=20
-static int i801_block_transaction_by_block(union i2c_smbus_data *data,
+static int i801_block_transaction_by_block(struct i801_priv *priv,
+					   union i2c_smbus_data *data,
 					   char read_write, int hwpec)
 {
 	int i, len;
 	int status;
=20
-	inb_p(SMBHSTCNT); /* reset the data buffer index */
+	inb_p(SMBHSTCNT(priv)); /* reset the data buffer index */
=20
 	/* Use 32-byte buffer to process this transaction */
 	if (read_write =3D=3D I2C_SMBUS_WRITE) {
 		len =3D data->block[0];
-		outb_p(len, SMBHSTDAT0);
+		outb_p(len, SMBHSTDAT0(priv));
 		for (i =3D 0; i < len; i++)
-			outb_p(data->block[i+1], SMBBLKDAT);
+			outb_p(data->block[i+1], SMBBLKDAT(priv));
 	}
=20
-	status =3D i801_transaction(I801_BLOCK_DATA | ENABLE_INT9 |
+	status =3D i801_transaction(priv, I801_BLOCK_DATA | ENABLE_INT9 |
 				  I801_PEC_EN * hwpec);
 	if (status)
 		return status;
=20
 	if (read_write =3D=3D I2C_SMBUS_READ) {
-		len =3D inb_p(SMBHSTDAT0);
+		len =3D inb_p(SMBHSTDAT0(priv));
 		if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
 			return -EPROTO;
=20
 		data->block[0] =3D len;
 		for (i =3D 0; i < len; i++)
-			data->block[i + 1] =3D inb_p(SMBBLKDAT);
+			data->block[i + 1] =3D inb_p(SMBBLKDAT(priv));
 	}
 	return 0;
 }
=20
-static int i801_block_transaction_byte_by_byte(union i2c_smbus_data *d=
ata,
+static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
+					       union i2c_smbus_data *data,
 					       char read_write, int command,
 					       int hwpec)
 {
@@ -319,15 +324,15 @@ static int i801_block_transaction_byte_by_byte(un=
ion i2c_smbus_data *data,
 	int result;
 	int timeout;
=20
-	result =3D i801_check_pre();
+	result =3D i801_check_pre(priv);
 	if (result < 0)
 		return result;
=20
 	len =3D data->block[0];
=20
 	if (read_write =3D=3D I2C_SMBUS_WRITE) {
-		outb_p(len, SMBHSTDAT0);
-		outb_p(data->block[1], SMBBLKDAT);
+		outb_p(len, SMBHSTDAT0(priv));
+		outb_p(data->block[1], SMBBLKDAT(priv));
 	}
=20
 	for (i =3D 1; i <=3D len; i++) {
@@ -343,34 +348,37 @@ static int i801_block_transaction_byte_by_byte(un=
ion i2c_smbus_data *data,
 			else
 				smbcmd =3D I801_BLOCK_DATA;
 		}
-		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT);
+		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT(priv));
=20
 		if (i =3D=3D 1)
-			outb_p(inb(SMBHSTCNT) | I801_START, SMBHSTCNT);
+			outb_p(inb(SMBHSTCNT(priv)) | I801_START,
+			       SMBHSTCNT(priv));
=20
 		/* We will always wait for a fraction of a second! */
 		timeout =3D 0;
 		do {
 			msleep(1);
-			status =3D inb_p(SMBHSTSTS);
+			status =3D inb_p(SMBHSTSTS(priv));
 		} while ((!(status & SMBHSTSTS_BYTE_DONE))
 			 && (timeout++ < MAX_TIMEOUT));
=20
-		result =3D i801_check_post(status, timeout > MAX_TIMEOUT);
+		result =3D i801_check_post(priv, status, timeout > MAX_TIMEOUT);
 		if (result < 0)
 			return result;
=20
 		if (i =3D=3D 1 && read_write =3D=3D I2C_SMBUS_READ
 		 && command !=3D I2C_SMBUS_I2C_BLOCK_DATA) {
-			len =3D inb_p(SMBHSTDAT0);
+			len =3D inb_p(SMBHSTDAT0(priv));
 			if (len < 1 || len > I2C_SMBUS_BLOCK_MAX) {
-				dev_err(&I801_dev->dev,
+				dev_err(&priv->pci_dev->dev,
 					"Illegal SMBus block read size %d\n",
 					len);
 				/* Recover */
-				while (inb_p(SMBHSTSTS) & SMBHSTSTS_HOST_BUSY)
-					outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS);
-				outb_p(SMBHSTSTS_INTR, SMBHSTSTS);
+				while (inb_p(SMBHSTSTS(priv)) &
+				       SMBHSTSTS_HOST_BUSY)
+					outb_p(SMBHSTSTS_BYTE_DONE,
+					       SMBHSTSTS(priv));
+				outb_p(SMBHSTSTS_INTR, SMBHSTSTS(priv));
 				return -EPROTO;
 			}
 			data->block[0] =3D len;
@@ -378,27 +386,28 @@ static int i801_block_transaction_byte_by_byte(un=
ion i2c_smbus_data *data,
=20
 		/* Retrieve/store value in SMBBLKDAT */
 		if (read_write =3D=3D I2C_SMBUS_READ)
-			data->block[i] =3D inb_p(SMBBLKDAT);
+			data->block[i] =3D inb_p(SMBBLKDAT(priv));
 		if (read_write =3D=3D I2C_SMBUS_WRITE && i+1 <=3D len)
-			outb_p(data->block[i+1], SMBBLKDAT);
+			outb_p(data->block[i+1], SMBBLKDAT(priv));
=20
 		/* signals SMBBLKDAT ready */
-		outb_p(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_INTR, SMBHSTSTS);
+		outb_p(SMBHSTSTS_BYTE_DONE | SMBHSTSTS_INTR, SMBHSTSTS(priv));
 	}
=20
 	return 0;
 }
=20
-static int i801_set_block_buffer_mode(void)
+static int i801_set_block_buffer_mode(struct i801_priv *priv)
 {
-	outb_p(inb_p(SMBAUXCTL) | SMBAUXCTL_E32B, SMBAUXCTL);
-	if ((inb_p(SMBAUXCTL) & SMBAUXCTL_E32B) =3D=3D 0)
+	outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_E32B, SMBAUXCTL(priv));
+	if ((inb_p(SMBAUXCTL(priv)) & SMBAUXCTL_E32B) =3D=3D 0)
 		return -EIO;
 	return 0;
 }
=20
 /* Block transaction function */
-static int i801_block_transaction(union i2c_smbus_data *data, char rea=
d_write,
+static int i801_block_transaction(struct i801_priv *priv,
+				  union i2c_smbus_data *data, char read_write,
 				  int command, int hwpec)
 {
 	int result =3D 0;
@@ -407,11 +416,11 @@ static int i801_block_transaction(union i2c_smbus=
_data *data, char read_write,
 	if (command =3D=3D I2C_SMBUS_I2C_BLOCK_DATA) {
 		if (read_write =3D=3D I2C_SMBUS_WRITE) {
 			/* set I2C_EN bit in configuration register */
-			pci_read_config_byte(I801_dev, SMBHSTCFG, &hostc);
-			pci_write_config_byte(I801_dev, SMBHSTCFG,
+			pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &hostc);
+			pci_write_config_byte(priv->pci_dev, SMBHSTCFG,
 					      hostc | SMBHSTCFG_I2C_EN);
-		} else if (!(i801_features & FEATURE_I2C_BLOCK_READ)) {
-			dev_err(&I801_dev->dev,
+		} else if (!(priv->features & FEATURE_I2C_BLOCK_READ)) {
+			dev_err(&priv->pci_dev->dev,
 				"I2C block read is unsupported!\n");
 			return -EOPNOTSUPP;
 		}
@@ -430,22 +439,23 @@ static int i801_block_transaction(union i2c_smbus=
_data *data, char read_write,
 	/* Experience has shown that the block buffer can only be used for
 	   SMBus (not I2C) block transactions, even though the datasheet
 	   doesn't mention this limitation. */
-	if ((i801_features & FEATURE_BLOCK_BUFFER)
+	if ((priv->features & FEATURE_BLOCK_BUFFER)
 	 && command !=3D I2C_SMBUS_I2C_BLOCK_DATA
-	 && i801_set_block_buffer_mode() =3D=3D 0)
-		result =3D i801_block_transaction_by_block(data, read_write,
-							 hwpec);
+	 && i801_set_block_buffer_mode(priv) =3D=3D 0)
+		result =3D i801_block_transaction_by_block(priv, data,
+							 read_write, hwpec);
 	else
-		result =3D i801_block_transaction_byte_by_byte(data, read_write,
+		result =3D i801_block_transaction_byte_by_byte(priv, data,
+							     read_write,
 							     command, hwpec);
=20
 	if (result =3D=3D 0 && hwpec)
-		i801_wait_hwpec();
+		i801_wait_hwpec(priv);
=20
 	if (command =3D=3D I2C_SMBUS_I2C_BLOCK_DATA
 	 && read_write =3D=3D I2C_SMBUS_WRITE) {
 		/* restore saved configuration register value */
-		pci_write_config_byte(I801_dev, SMBHSTCFG, hostc);
+		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
 	}
 	return result;
 }
@@ -458,81 +468,83 @@ static s32 i801_access(struct i2c_adapter *adap, =
u16 addr,
 	int hwpec;
 	int block =3D 0;
 	int ret, xact =3D 0;
+	struct i801_priv *priv =3D i2c_get_adapdata(adap);
=20
-	hwpec =3D (i801_features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_=
PEC)
+	hwpec =3D (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT=
_PEC)
 		&& size !=3D I2C_SMBUS_QUICK
 		&& size !=3D I2C_SMBUS_I2C_BLOCK_DATA;
=20
 	switch (size) {
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
+		       SMBHSTADD(priv));
 		xact =3D I801_QUICK;
 		break;
 	case I2C_SMBUS_BYTE:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
+		       SMBHSTADD(priv));
 		if (read_write =3D=3D I2C_SMBUS_WRITE)
-			outb_p(command, SMBHSTCMD);
+			outb_p(command, SMBHSTCMD(priv));
 		xact =3D I801_BYTE;
 		break;
 	case I2C_SMBUS_BYTE_DATA:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
-		outb_p(command, SMBHSTCMD);
+		       SMBHSTADD(priv));
+		outb_p(command, SMBHSTCMD(priv));
 		if (read_write =3D=3D I2C_SMBUS_WRITE)
-			outb_p(data->byte, SMBHSTDAT0);
+			outb_p(data->byte, SMBHSTDAT0(priv));
 		xact =3D I801_BYTE_DATA;
 		break;
 	case I2C_SMBUS_WORD_DATA:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
-		outb_p(command, SMBHSTCMD);
+		       SMBHSTADD(priv));
+		outb_p(command, SMBHSTCMD(priv));
 		if (read_write =3D=3D I2C_SMBUS_WRITE) {
-			outb_p(data->word & 0xff, SMBHSTDAT0);
-			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1);
+			outb_p(data->word & 0xff, SMBHSTDAT0(priv));
+			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1(priv));
 		}
 		xact =3D I801_WORD_DATA;
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
-		       SMBHSTADD);
-		outb_p(command, SMBHSTCMD);
+		       SMBHSTADD(priv));
+		outb_p(command, SMBHSTCMD(priv));
 		block =3D 1;
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
 		/* NB: page 240 of ICH5 datasheet shows that the R/#W
 		 * bit should be cleared here, even when reading */
-		outb_p((addr & 0x7f) << 1, SMBHSTADD);
+		outb_p((addr & 0x7f) << 1, SMBHSTADD(priv));
 		if (read_write =3D=3D I2C_SMBUS_READ) {
 			/* NB: page 240 of ICH5 datasheet also shows
 			 * that DATA1 is the cmd field when reading */
-			outb_p(command, SMBHSTDAT1);
+			outb_p(command, SMBHSTDAT1(priv));
 		} else
-			outb_p(command, SMBHSTCMD);
+			outb_p(command, SMBHSTCMD(priv));
 		block =3D 1;
 		break;
 	default:
-		dev_err(&I801_dev->dev, "Unsupported transaction %d\n", size);
+		dev_err(&priv->pci_dev->dev, "Unsupported transaction %d\n", size);
 		return -EOPNOTSUPP;
 	}
=20
 	if (hwpec)	/* enable/disable hardware PEC */
-		outb_p(inb_p(SMBAUXCTL) | SMBAUXCTL_CRC, SMBAUXCTL);
+		outb_p(inb_p(SMBAUXCTL(priv)) | SMBAUXCTL_CRC, SMBAUXCTL(priv));
 	else
-		outb_p(inb_p(SMBAUXCTL) & (~SMBAUXCTL_CRC), SMBAUXCTL);
+		outb_p(inb_p(SMBAUXCTL(priv)) & (~SMBAUXCTL_CRC), SMBAUXCTL(priv));
=20
 	if (block)
-		ret =3D i801_block_transaction(data, read_write, size, hwpec);
+		ret =3D i801_block_transaction(priv, data, read_write, size,
+					     hwpec);
 	else
-		ret =3D i801_transaction(xact | ENABLE_INT9);
+		ret =3D i801_transaction(priv, xact | ENABLE_INT9);
=20
 	/* Some BIOSes don't like it when PEC is enabled at reboot or resume
 	   time, so we forcibly disable it after every transaction. Turn off
 	   E32B for the same reason. */
 	if (hwpec || block)
-		outb_p(inb_p(SMBAUXCTL) & ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B),
-		       SMBAUXCTL);
+		outb_p(inb_p(SMBAUXCTL(priv)) & ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B),
+		       SMBAUXCTL(priv));
=20
 	if (block)
 		return ret;
@@ -544,10 +556,11 @@ static s32 i801_access(struct i2c_adapter *adap, =
u16 addr,
 	switch (xact & 0x7f) {
 	case I801_BYTE:	/* Result put in SMBHSTDAT0 */
 	case I801_BYTE_DATA:
-		data->byte =3D inb_p(SMBHSTDAT0);
+		data->byte =3D inb_p(SMBHSTDAT0(priv));
 		break;
 	case I801_WORD_DATA:
-		data->word =3D inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
+		data->word =3D inb_p(SMBHSTDAT0(priv)) +
+			     (inb_p(SMBHSTDAT1(priv)) << 8);
 		break;
 	}
 	return 0;
@@ -556,11 +569,13 @@ static s32 i801_access(struct i2c_adapter *adap, =
u16 addr,
=20
 static u32 i801_func(struct i2c_adapter *adapter)
 {
+	struct i801_priv *priv =3D i2c_get_adapdata(adapter);
+
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	       I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK |
-	       ((i801_features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0)=
 |
-	       ((i801_features & FEATURE_I2C_BLOCK_READ) ?
+	       ((priv->features & FEATURE_SMBUS_PEC) ? I2C_FUNC_SMBUS_PEC : 0=
) |
+	       ((priv->features & FEATURE_I2C_BLOCK_READ) ?
 		I2C_FUNC_SMBUS_READ_I2C_BLOCK : 0);
 }
=20
@@ -569,12 +584,6 @@ static const struct i2c_algorithm smbus_algorithm =
=3D {
 	.functionality	=3D i801_func,
 };
=20
-static struct i2c_adapter i801_adapter =3D {
-	.owner		=3D THIS_MODULE,
-	.class		=3D I2C_CLASS_HWMON | I2C_CLASS_SPD,
-	.algo		=3D &smbus_algorithm,
-};
-
 static const struct pci_device_id i801_ids[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AA_3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801AB_3) },
@@ -706,16 +715,26 @@ static int __devinit i801_probe(struct pci_dev *d=
ev,
 {
 	unsigned char temp;
 	int err, i;
+	struct i801_priv *priv;
+
+	priv =3D kzalloc(sizeof (*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	i2c_set_adapdata(&priv->adapter, priv);
+	priv->adapter.owner =3D THIS_MODULE;
+	priv->adapter.class =3D I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	priv->adapter.algo =3D &smbus_algorithm;
+=09
+	priv->pci_dev =3D dev;
=20
-	I801_dev =3D dev;
-	i801_features =3D 0;
 	switch (dev->device) {
 	default:
-		i801_features |=3D FEATURE_I2C_BLOCK_READ;
+		priv->features |=3D FEATURE_I2C_BLOCK_READ;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801DB_3:
-		i801_features |=3D FEATURE_SMBUS_PEC;
-		i801_features |=3D FEATURE_BLOCK_BUFFER;
+		priv->features |=3D FEATURE_SMBUS_PEC;
+		priv->features |=3D FEATURE_BLOCK_BUFFER;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801CA_3:
 	case PCI_DEVICE_ID_INTEL_82801BA_2:
@@ -726,11 +745,11 @@ static int __devinit i801_probe(struct pci_dev *d=
ev,
=20
 	/* Disable features on user request */
 	for (i =3D 0; i < ARRAY_SIZE(i801_feature_names); i++) {
-		if (i801_features & disable_features & (1 << i))
+		if (priv->features & disable_features & (1 << i))
 			dev_notice(&dev->dev, "%s disabled by user\n",
 				   i801_feature_names[i]);
 	}
-	i801_features &=3D ~disable_features;
+	priv->features &=3D ~disable_features;
=20
 	err =3D pci_enable_device(dev);
 	if (err) {
@@ -740,8 +759,8 @@ static int __devinit i801_probe(struct pci_dev *dev=
,
 	}
=20
 	/* Determine the address of the SMBus area */
-	i801_smba =3D pci_resource_start(dev, SMBBAR);
-	if (!i801_smba) {
+	priv->smba =3D pci_resource_start(dev, SMBBAR);
+	if (!priv->smba) {
 		dev_err(&dev->dev, "SMBus base address uninitialized, "
 			"upgrade BIOS\n");
 		err =3D -ENODEV;
@@ -757,19 +776,19 @@ static int __devinit i801_probe(struct pci_dev *d=
ev,
 	err =3D pci_request_region(dev, SMBBAR, i801_driver.name);
 	if (err) {
 		dev_err(&dev->dev, "Failed to request SMBus region "
-			"0x%lx-0x%Lx\n", i801_smba,
+			"0x%lx-0x%Lx\n", priv->smba,
 			(unsigned long long)pci_resource_end(dev, SMBBAR));
 		goto exit;
 	}
=20
-	pci_read_config_byte(I801_dev, SMBHSTCFG, &temp);
-	i801_original_hstcfg =3D temp;
+	pci_read_config_byte(priv->pci_dev, SMBHSTCFG, &temp);
+	priv->original_hstcfg =3D temp;
 	temp &=3D ~SMBHSTCFG_I2C_EN;	/* SMBus timing */
 	if (!(temp & SMBHSTCFG_HST_EN)) {
 		dev_info(&dev->dev, "Enabling SMBus device\n");
 		temp |=3D SMBHSTCFG_HST_EN;
 	}
-	pci_write_config_byte(I801_dev, SMBHSTCFG, temp);
+	pci_write_config_byte(priv->pci_dev, SMBHSTCFG, temp);
=20
 	if (temp & SMBHSTCFG_SMB_SMI_EN)
 		dev_dbg(&dev->dev, "SMBus using interrupt SMI#\n");
@@ -777,19 +796,19 @@ static int __devinit i801_probe(struct pci_dev *d=
ev,
 		dev_dbg(&dev->dev, "SMBus using PCI Interrupt\n");
=20
 	/* Clear special mode bits */
-	if (i801_features & (FEATURE_SMBUS_PEC | FEATURE_BLOCK_BUFFER))
-		outb_p(inb_p(SMBAUXCTL) & ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B),
-		       SMBAUXCTL);
+	if (priv->features & (FEATURE_SMBUS_PEC | FEATURE_BLOCK_BUFFER))
+		outb_p(inb_p(SMBAUXCTL(priv)) & ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B),
+		       SMBAUXCTL(priv));
=20
 	/* set up the sysfs linkage to our parent device */
-	i801_adapter.dev.parent =3D &dev->dev;
+	priv->adapter.dev.parent =3D &dev->dev;
=20
 	/* Retry up to 3 times on lost arbitration */
-	i801_adapter.retries =3D 3;
+	priv->adapter.retries =3D 3;
=20
-	snprintf(i801_adapter.name, sizeof(i801_adapter.name),
-		"SMBus I801 adapter at %04lx", i801_smba);
-	err =3D i2c_add_adapter(&i801_adapter);
+	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
+		"SMBus I801 adapter at %04lx", priv->smba);
+	err =3D i2c_add_adapter(&priv->adapter);
 	if (err) {
 		dev_err(&dev->dev, "Failed to add SMBus adapter\n");
 		goto exit_release;
@@ -803,27 +822,33 @@ static int __devinit i801_probe(struct pci_dev *d=
ev,
 		memset(&info, 0, sizeof(struct i2c_board_info));
 		info.addr =3D apanel_addr;
 		strlcpy(info.type, "fujitsu_apanel", I2C_NAME_SIZE);
-		i2c_new_device(&i801_adapter, &info);
+		i2c_new_device(&priv->adapter, &info);
 	}
 #endif
 #if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHMD_MOD=
ULE
 	if (dmi_name_in_vendors("FUJITSU"))
-		dmi_walk(dmi_check_onboard_devices, &i801_adapter);
+		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
 #endif
=20
+	pci_set_drvdata(dev, priv);
 	return 0;
=20
 exit_release:
 	pci_release_region(dev, SMBBAR);
 exit:
+	kfree(priv);
 	return err;
 }
=20
 static void __devexit i801_remove(struct pci_dev *dev)
 {
-	i2c_del_adapter(&i801_adapter);
-	pci_write_config_byte(I801_dev, SMBHSTCFG, i801_original_hstcfg);
+	struct i801_priv *priv =3D pci_get_drvdata(dev);
+
+	i2c_del_adapter(&priv->adapter);
+	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
 	pci_release_region(dev, SMBBAR);
+	pci_set_drvdata(dev, NULL);
+	kfree(priv);
 	/*
 	 * do not call pci_disable_device(dev) since it can cause hard hangs =
on
 	 * some systems during power-off (eg. Fujitsu-Siemens Lifebook E8010)
@@ -833,8 +858,10 @@ static void __devexit i801_remove(struct pci_dev *=
dev)
 #ifdef CONFIG_PM
 static int i801_suspend(struct pci_dev *dev, pm_message_t mesg)
 {
+	struct i801_priv *priv =3D pci_get_drvdata(dev);
+
 	pci_save_state(dev);
-	pci_write_config_byte(dev, SMBHSTCFG, i801_original_hstcfg);
+	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
 	pci_set_power_state(dev, pci_choose_state(dev, mesg));
 	return 0;
 }
--=20
1.7.3.1


--=20
David Woodhouse                            Open Source Technology Centr=
e
David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org                              Intel Corporatio=
n
