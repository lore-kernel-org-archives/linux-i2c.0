From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Mon, 4 Feb 2013 18:19:02 +0100
Message-ID: <20130204181902.06c247ad@endymion.delvare>
References: <1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
	<1359748083-24423-1-git-send-email-nhorman@tuxdriver.com>
	<20130204104744.5f83541e@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130204104744.5f83541e-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bill Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 4 Feb 2013 10:47:44 +0100, Jean Delvare wrote:
> I have backported your code to kernel 3.0 and I'll get back to you when
> I finally get a chance to test it.

OK, I am done with the backport and testing. The test system I have
access to appears to have a single slave on the second iSMT channel, at
address 0x54. I have no idea what this device is so my testing is
fairly limited, in particular I can't test writes. But at least I could
test the quick command and read byte transactions. I believe the
following fix is needed on top of your patch to make non-quick,
non-block transactions right:

---
 i2c-ismt.c |   35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

--- i2c-ismt.orig/i2c-ismt.c
+++ i2c-ismt/i2c-ismt.c
@@ -329,10 +329,23 @@ static int ismt_process_desc(const struc
 	__ismt_desc_dump(&priv->pci_dev->dev, desc);
 
 	if (desc->status & ISMT_DESC_SCS) {
-		if ((size != I2C_SMBUS_QUICK) &&
-		    (read_write == I2C_SMBUS_READ)) {
+		if (read_write == I2C_SMBUS_WRITE &&
+		    size != I2C_SMBUS_PROC_CALL)
+			return 0;
+
+		switch (size) {
+		case I2C_SMBUS_BYTE:
+		case I2C_SMBUS_BYTE_DATA:
+			data->byte = dma_buffer[0];
+			break;
+		case I2C_SMBUS_WORD_DATA:
+		case I2C_SMBUS_PROC_CALL:
+			data->word = dma_buffer[0] | (dma_buffer[1] << 8);
+			break;
+		case I2C_SMBUS_BLOCK_DATA:
 			memcpy(&data->block[1], dma_buffer, desc->rxbytes);
 			data->block[0] = desc->rxbytes;
+			break;
 		}
 		return 0;
 	}
@@ -426,6 +439,8 @@ static int ismt_access(struct i2c_adapte
 			desc->wr_len_cmd = 2;
 			dma_size = 2;
 			dma_direction = DMA_TO_DEVICE;
+			priv->dma_buffer[0] = command;
+			priv->dma_buffer[1] = data->byte;
 		} else {
 			/* Read Byte */
 			dev_dbg(dev, "I2C_SMBUS_BYTE_DATA:  READ\n");
@@ -444,6 +459,9 @@ static int ismt_access(struct i2c_adapte
 			desc->wr_len_cmd = 3;
 			dma_size = 3;
 			dma_direction = DMA_TO_DEVICE;
+			priv->dma_buffer[0] = command;
+			priv->dma_buffer[1] = data->word & 0xff;
+			priv->dma_buffer[2] = data->word >> 8;
 		} else {
 			/* Read Word */
 			dev_dbg(dev, "I2C_SMBUS_WORD_DATA:  READ\n");
@@ -461,6 +479,9 @@ static int ismt_access(struct i2c_adapte
 		desc->rd_len = 2;
 		dma_size = 3;
 		dma_direction = DMA_BIDIRECTIONAL;
+		priv->dma_buffer[0] = command;
+		priv->dma_buffer[1] = data->word & 0xff;
+		priv->dma_buffer[2] = data->word >> 8;
 		break;
 
 	case I2C_SMBUS_BLOCK_DATA:
@@ -471,6 +492,8 @@ static int ismt_access(struct i2c_adapte
 			dma_direction = DMA_TO_DEVICE;
 			desc->wr_len_cmd = dma_size;
 			desc->control |= ISMT_DESC_BLK;
+			priv->dma_buffer[0] = command;
+			memcpy(&priv->dma_buffer[1], &data->block[1], dma_size);
 		} else {
 			/* Block Read */
 			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  READ\n");
@@ -488,14 +511,6 @@ static int ismt_access(struct i2c_adapte
 		return -EOPNOTSUPP;
 	}
 
-	/* Create a temporary buffer for the DMA transaction */
-	/* and insert the command at the beginning of the buffer */
-	if ((read_write == I2C_SMBUS_WRITE) &&
-	    (size > I2C_SMBUS_BYTE)) {
-		memcpy(&priv->dma_buffer[1], &data->block[1], dma_size);
-		priv->dma_buffer[0] = command;
-	}
-
 	/* map the data buffer */
 	if (dma_size != 0) {
 		dev_dbg(dev, " dev=%p\n", dev);

Maybe that's what Seth was missing. Seth, can you please try this patch
of mine and let us know if it helps? Warning: I was only able to test
the quick, receive byte and read byte transactions.

-- 
Jean Delvare
