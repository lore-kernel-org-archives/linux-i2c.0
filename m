From: Radu Rendec <radu.rendec@gmail.com>
Subject: [PATCH 1/2] i2c: ismt: 16-byte align the DMA buffer address
Date: Fri, 18 Aug 2017 17:01:27 +0100
Message-ID: <20170818160128.21228-2-radu.rendec@gmail.com>
References: <20170818160128.21228-1-radu.rendec@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36682 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdHRQBt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 18 Aug 2017 12:01:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id d40so4692456wma.3
        for <linux-i2c@vger.kernel.org>; Fri, 18 Aug 2017 09:01:48 -0700 (PDT)
In-Reply-To: <20170818160128.21228-1-radu.rendec@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Radu Rendec <radu.rendec@gmail.com>

Use only a portion of the data buffer for DMA transfers, which is always
16-byte aligned. This makes the DMA buffer address 16-byte aligned and
compensates for spurious hardware parity errors that may appear when the
DMA buffer address is not 16-byte aligned.

The data buffer is enlarged in order to accommodate any possible 16-byte
alignment offset and changes the DMA code to only use a portion of the
data buffer, which is 16-byte aligned.

The symptom of the hardware issue is the same as the one addressed in
v3.12-rc2-5-gbf41691 and manifests by transfers failing with EIO, with
bit 9 being set in the ERRSTS register.

Signed-off-by: Radu Rendec <radu.rendec@gmail.com>
---
 drivers/i2c/busses/i2c-ismt.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index e98e44e..ccce0ca 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -172,7 +172,7 @@ struct ismt_priv {
 	dma_addr_t io_rng_dma;			/* descriptor HW base addr */
 	u8 head;				/* ring buffer head pointer */
 	struct completion cmp;			/* interrupt completion */
-	u8 dma_buffer[I2C_SMBUS_BLOCK_MAX + 1];	/* temp R/W data buffer */
+	u8 buffer[I2C_SMBUS_BLOCK_MAX + 16];	/* temp R/W data buffer */
 };
 
 /**
@@ -320,7 +320,7 @@ static int ismt_process_desc(const struct ismt_desc *desc,
 			     struct ismt_priv *priv, int size,
 			     char read_write)
 {
-	u8 *dma_buffer = priv->dma_buffer;
+	u8 *dma_buffer = (u8*)ALIGN((unsigned long)&priv->buffer[0], 16);
 
 	dev_dbg(&priv->pci_dev->dev, "Processing completed descriptor\n");
 	__ismt_desc_dump(&priv->pci_dev->dev, desc);
@@ -388,11 +388,12 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 	struct ismt_desc *desc;
 	struct ismt_priv *priv = i2c_get_adapdata(adap);
 	struct device *dev = &priv->pci_dev->dev;
+	u8 *dma_buffer = (u8*)ALIGN((unsigned long)&priv->buffer[0], 16);
 
 	desc = &priv->hw[priv->head];
 
 	/* Initialize the DMA buffer */
-	memset(priv->dma_buffer, 0, sizeof(priv->dma_buffer));
+	memset(priv->buffer, 0, sizeof(priv->buffer));
 
 	/* Initialize the descriptor */
 	memset(desc, 0, sizeof(struct ismt_desc));
@@ -441,8 +442,8 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 			desc->wr_len_cmd = 2;
 			dma_size = 2;
 			dma_direction = DMA_TO_DEVICE;
-			priv->dma_buffer[0] = command;
-			priv->dma_buffer[1] = data->byte;
+			dma_buffer[0] = command;
+			dma_buffer[1] = data->byte;
 		} else {
 			/* Read Byte */
 			dev_dbg(dev, "I2C_SMBUS_BYTE_DATA:  READ\n");
@@ -461,9 +462,9 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 			desc->wr_len_cmd = 3;
 			dma_size = 3;
 			dma_direction = DMA_TO_DEVICE;
-			priv->dma_buffer[0] = command;
-			priv->dma_buffer[1] = data->word & 0xff;
-			priv->dma_buffer[2] = data->word >> 8;
+			dma_buffer[0] = command;
+			dma_buffer[1] = data->word & 0xff;
+			dma_buffer[2] = data->word >> 8;
 		} else {
 			/* Read Word */
 			dev_dbg(dev, "I2C_SMBUS_WORD_DATA:  READ\n");
@@ -481,9 +482,9 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 		desc->rd_len = 2;
 		dma_size = 3;
 		dma_direction = DMA_BIDIRECTIONAL;
-		priv->dma_buffer[0] = command;
-		priv->dma_buffer[1] = data->word & 0xff;
-		priv->dma_buffer[2] = data->word >> 8;
+		dma_buffer[0] = command;
+		dma_buffer[1] = data->word & 0xff;
+		dma_buffer[2] = data->word >> 8;
 		break;
 
 	case I2C_SMBUS_BLOCK_DATA:
@@ -494,8 +495,8 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 			dma_direction = DMA_TO_DEVICE;
 			desc->wr_len_cmd = dma_size;
 			desc->control |= ISMT_DESC_BLK;
-			priv->dma_buffer[0] = command;
-			memcpy(&priv->dma_buffer[1], &data->block[1], dma_size - 1);
+			dma_buffer[0] = command;
+			memcpy(&dma_buffer[1], &data->block[1], dma_size - 1);
 		} else {
 			/* Block Read */
 			dev_dbg(dev, "I2C_SMBUS_BLOCK_DATA:  READ\n");
@@ -522,8 +523,8 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 			dma_direction = DMA_TO_DEVICE;
 			desc->wr_len_cmd = dma_size;
 			desc->control |= ISMT_DESC_I2C;
-			priv->dma_buffer[0] = command;
-			memcpy(&priv->dma_buffer[1], &data->block[1], dma_size - 1);
+			dma_buffer[0] = command;
+			memcpy(&dma_buffer[1], &data->block[1], dma_size - 1);
 		} else {
 			/* i2c Block Read */
 			dev_dbg(dev, "I2C_SMBUS_I2C_BLOCK_DATA:  READ\n");
@@ -552,18 +553,18 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 	if (dma_size != 0) {
 		dev_dbg(dev, " dev=%p\n", dev);
 		dev_dbg(dev, " data=%p\n", data);
-		dev_dbg(dev, " dma_buffer=%p\n", priv->dma_buffer);
+		dev_dbg(dev, " dma_buffer=%p\n", dma_buffer);
 		dev_dbg(dev, " dma_size=%d\n", dma_size);
 		dev_dbg(dev, " dma_direction=%d\n", dma_direction);
 
 		dma_addr = dma_map_single(dev,
-				      priv->dma_buffer,
+				      dma_buffer,
 				      dma_size,
 				      dma_direction);
 
 		if (dma_mapping_error(dev, dma_addr)) {
 			dev_err(dev, "Error in mapping dma buffer %p\n",
-				priv->dma_buffer);
+				dma_buffer);
 			return -EIO;
 		}
 
-- 
2.9.5
