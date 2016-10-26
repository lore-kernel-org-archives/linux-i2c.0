From: tnhuynh@apm.com
Subject: [PATCH v2] I2C Designware Core Supports SMBUS BLOCK
Date: Wed, 26 Oct 2016 16:48:28 +0700
Message-ID: <1477475308-24293-1-git-send-email-tnhuynh@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com, Tin Huynh <tnhuynh@apm.com>
List-Id: linux-i2c@vger.kernel.org

From: Tin Huynh <tnhuynh@apm.com>

Free and Open IPMI use SMBUS BLOCK Read/Write to support SSIF protocol.
However, I2C Designwave Core Driver doesn't handle the case at the moment.
The below patch supports this feature.

Change from V1:
	-Remove empty lines
	-Add flags variable to make clean code
	-Change DW_DEFAULT_FUNCTIONALITY in i2c-designware-pcidrv.c

Signed-off-by: Tin Huynh <tnhuynh@apm.com>
---
 drivers/i2c/busses/i2c-designware-core.c    |   36 ++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-designware-pcidrv.c  |    1 +
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 1fe93c4..c77a83f 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -543,6 +543,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	intr_mask = DW_IC_INTR_DEFAULT_MASK;
 
 	for (; dev->msg_write_idx < dev->msgs_num; dev->msg_write_idx++) {
+		u32 flags = msgs[dev->msg_write_idx].flags;
 		/*
 		 * if target address has changed, we need to
 		 * reprogram the target address in the i2c
@@ -588,8 +589,15 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 			 * detected from the registers so we set it always
 			 * when writing/reading the last byte.
 			 */
+
+			/*
+			 * i2c-core.c always set the buffer length of
+			 * I2C_FUNC_SMBUS_BLOCK_DATA to 1. The length will
+			 * be adjusted when receiving the first byte.
+			 * Thus we can't stop the transaction here.
+			 */
 			if (dev->msg_write_idx == dev->msgs_num - 1 &&
-			    buf_len == 1)
+			    buf_len == 1 && !(flags & I2C_M_RECV_LEN))
 				cmd |= BIT(9);
 
 			if (need_restart) {
@@ -614,7 +622,12 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 		dev->tx_buf = buf;
 		dev->tx_buf_len = buf_len;
 
-		if (buf_len > 0) {
+		/*
+		 * Because we don't know the buffer length in the
+		 * I2C_FUNC_SMBUS_BLOCK_DATA case, we can't stop
+		 * the transaction here.
+		 */
+		if (buf_len > 0 || flags & I2C_M_RECV_LEN) {
 			/* more bytes to be written */
 			dev->status |= STATUS_WRITE_IN_PROGRESS;
 			break;
@@ -659,7 +672,24 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 		rx_valid = dw_readl(dev, DW_IC_RXFLR);
 
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
-			*buf++ = dw_readl(dev, DW_IC_DATA_CMD);
+			u32 flags = msgs[dev->msg_read_idx].flags;
+			*buf = dw_readl(dev, DW_IC_DATA_CMD);
+			/* ensure length byte is a valid value */
+			if (flags & I2C_M_RECV_LEN &&
+				*buf <= I2C_SMBUS_BLOCK_MAX && *buf > 0) {
+				/*
+				 * Adjust the buffer length and mask the flag
+				 * after receiving the first byte
+				 */
+				len = (flags & I2C_CLIENT_PEC) ?
+					*buf + 2 : *buf + 1;
+				dev->tx_buf_len = len > dev->rx_outstanding ?
+					len - dev->rx_outstanding : 0;
+				msgs[dev->msg_read_idx].len = len;
+				flags &= ~I2C_M_RECV_LEN;
+				msgs[dev->msg_read_idx].flags = flags;
+			}
+			buf++;
 			dev->rx_outstanding--;
 		}
 
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 96f8230..8ffe2da 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -75,6 +75,7 @@ struct dw_pci_controller {
 					I2C_FUNC_SMBUS_BYTE |		\
 					I2C_FUNC_SMBUS_BYTE_DATA |	\
 					I2C_FUNC_SMBUS_WORD_DATA |	\
+					I2C_FUNC_SMBUS_BLOCK_DATA |	\
 					I2C_FUNC_SMBUS_I2C_BLOCK)
 
 /* Merrifield HCNT/LCNT/SDA hold time */
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 0b42a12..886fb62 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -220,6 +220,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 		I2C_FUNC_SMBUS_BYTE |
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_BLOCK_DATA |
 		I2C_FUNC_SMBUS_I2C_BLOCK;
 
 	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-- 
1.7.1
