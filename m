From: tnhuynh@apm.com
Subject: [PATCH v1] I2C Designware Core Supports SMBUS BLOCK
Date: Tue, 25 Oct 2016 11:35:13 +0700
Message-ID: <1477370113-15145-1-git-send-email-tnhuynh@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33111 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754020AbcJYEfk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Oct 2016 00:35:40 -0400
Received: by mail-pf0-f169.google.com with SMTP id 128so111856314pfz.0
        for <linux-i2c@vger.kernel.org>; Mon, 24 Oct 2016 21:35:39 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches@apm.com, Tin Huynh <tnhuynh@apm.com>

From: Tin Huynh <tnhuynh@apm.com>

Free and Open IPMI use SMBUS BLOCK Read/Write to support SSIF protocol.
However, I2C Designwave Core Driver doesn't handle the case at the moment.
The below patch supports this feature.

Signed-off-by: Tin Huynh <tnhuynh@apm.com>
---
 drivers/i2c/busses/i2c-designware-core.c    |   42 +++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 1fe93c4..3abf0e5 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -588,8 +588,17 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
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
+
 			if (dev->msg_write_idx == dev->msgs_num - 1 &&
-			    buf_len == 1)
+			    buf_len == 1 &&
+			    !(msgs[dev->msg_write_idx].flags & I2C_M_RECV_LEN))
 				cmd |= BIT(9);
 
 			if (need_restart) {
@@ -614,7 +623,14 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 		dev->tx_buf = buf;
 		dev->tx_buf_len = buf_len;
 
-		if (buf_len > 0) {
+		/*
+		 * Because we don't know the buffer length in the
+		 * I2C_FUNC_SMBUS_BLOCK_DATA case, we can't stop
+		 * the transcation here.
+		 */
+
+		if (buf_len > 0 ||
+			msgs[dev->msg_write_idx].flags & I2C_M_RECV_LEN) {
 			/* more bytes to be written */
 			dev->status |= STATUS_WRITE_IN_PROGRESS;
 			break;
@@ -659,7 +675,27 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 		rx_valid = dw_readl(dev, DW_IC_RXFLR);
 
 		for (; len > 0 && rx_valid > 0; len--, rx_valid--) {
-			*buf++ = dw_readl(dev, DW_IC_DATA_CMD);
+			*buf = dw_readl(dev, DW_IC_DATA_CMD);
+			/* ensure length byte is a valid value */
+			if (msgs[dev->msg_read_idx].flags & I2C_M_RECV_LEN
+				&& *buf <= I2C_SMBUS_BLOCK_MAX  && *buf > 0) {
+				/*
+				 * Adjust the buffer length and mask the flag
+				 * after receiving the first byte
+				 */
+				msgs[dev->msg_read_idx].flags &=
+								~I2C_M_RECV_LEN;
+				len = *buf + 1;
+				/* Increase one with PEC flag */
+				if (msgs[dev->msg_read_idx].flags &
+							I2C_CLIENT_PEC)
+					len++;
+
+				dev->tx_buf_len = len > dev->rx_outstanding ?
+					len - dev->rx_outstanding : 0;
+				msgs[dev->msg_read_idx].len = len;
+			}
+			buf++;
 			dev->rx_outstanding--;
 		}
 
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


-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
