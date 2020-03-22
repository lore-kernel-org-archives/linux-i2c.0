From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] i2c: iproc: add support for SMBUS quick cmd
Date: Sun, 22 Mar 2020 23:53:22 +0530
Message-ID: <20200322182322.32743-1-rayagonda.kokatanur@broadcom.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33005 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgCVSXg (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 22 Mar 2020 14:23:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so14027549wrd.0
        for <linux-i2c@vger.kernel.org>; Sun, 22 Mar 2020 11:23:35 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Wolfram Sang <wsa@the-dreams.de>, Lori Hikichi <lori.hikichi@broadcom.com>, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Nishka Dasgupta <nishkadg.linux@gmail.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add support for SMBUS quick command.

SMBUS quick command passes single bit of information to the
slave (target) device. Can be used to turn slave device on or off.

By default i2c_detect tool uses the smbus quick cmd to try and
detect devices. Without this support it will not detect some slaves.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 30efb7913b2e..6a461e06e6dd 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -79,6 +79,7 @@
 #define M_CMD_STATUS_RX_FIFO_FULL    0x6
 #define M_CMD_PROTOCOL_SHIFT         9
 #define M_CMD_PROTOCOL_MASK          0xf
+#define M_CMD_PROTOCOL_QUICK         0x0
 #define M_CMD_PROTOCOL_BLK_WR        0x7
 #define M_CMD_PROTOCOL_BLK_RD        0x8
 #define M_CMD_PROTOCOL_PROCESS       0xa
@@ -765,7 +766,11 @@ static int bcm_iproc_i2c_xfer_internal(struct bcm_iproc_i2c_dev *iproc_i2c,
 	 * number of bytes to read
 	 */
 	val = BIT(M_CMD_START_BUSY_SHIFT);
-	if (msg->flags & I2C_M_RD) {
+
+	if (msg->len == 0) {
+		/* SMBUS QUICK Command (Read/Write) */
+		val |= (M_CMD_PROTOCOL_QUICK << M_CMD_PROTOCOL_SHIFT);
+	} else if (msg->flags & I2C_M_RD) {
 		u32 protocol;
 
 		iproc_i2c->rx_bytes = 0;
@@ -827,8 +832,7 @@ static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
 {
 	u32 val;
 
-	/* We do not support the SMBUS Quick command */
-	val = I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+	val = I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 
 	if (adap->algo->reg_slave)
 		val |= I2C_FUNC_SLAVE;
-- 
2.17.1
