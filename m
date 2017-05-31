From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] i2c: at91: Fix compilation warning.
Date: Wed, 31 May 2017 12:45:38 +0530
Message-ID: <ad09a3e39508817a96e9a9477b62e992031d5b69.1496214450.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34886 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdEaHPw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 31 May 2017 03:15:52 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ludovic.desroches@microchip.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Replace '%d' by '%zu' to fix the following compilation warning:-

drivers/i2c/busses/i2c-at91.c:277:2: warning: format ‘%d’ expects argument of type ‘int’, but argument 5 has type ‘size_t’ [-Wformat=]
  dev_dbg(dev->dev, "wrote 0x%x, to go %d\n", *dev->buf, dev->buf_len);
  ^
drivers/i2c/busses/i2c-at91.c: In function ‘at91_twi_read_next_byte’:
drivers/i2c/busses/i2c-at91.c:405:4: warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘size_t’ [-Wformat=]
    dev_dbg(dev->dev, "received block length %d\n",
    ^
drivers/i2c/busses/i2c-at91.c:418:2: warning: format ‘%d’ expects argument of type ‘int’, but argument 5 has type ‘size_t’ [-Wformat=]
  dev_dbg(dev->dev, "read 0x%x, to go %d\n", *dev->buf, dev->buf_len);
  ^
drivers/i2c/busses/i2c-at91.c: In function ‘at91_do_twi_transfer’:
drivers/i2c/busses/i2c-at91.c:625:2: warning: format ‘%d’ expects argument of type ‘int’, but argument 5 has type ‘size_t’ [-Wformat=]
  dev_dbg(dev->dev, "transfer: %s %d bytes.\n",

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/i2c/busses/i2c-at91.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 2525cd9..38dd61d 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -274,7 +274,7 @@ static void at91_twi_write_next_byte(struct at91_twi_dev *dev)
 		if (!dev->use_alt_cmd)
 			at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
 
-	dev_dbg(dev->dev, "wrote 0x%x, to go %d\n", *dev->buf, dev->buf_len);
+	dev_dbg(dev->dev, "wrote 0x%x, to go %zu\n", *dev->buf, dev->buf_len);
 
 	++dev->buf;
 }
@@ -402,7 +402,7 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 			dev->msg->flags &= ~I2C_M_RECV_LEN;
 			dev->buf_len += *dev->buf;
 			dev->msg->len = dev->buf_len + 1;
-			dev_dbg(dev->dev, "received block length %d\n",
+			dev_dbg(dev->dev, "received block length %zu\n",
 					 dev->buf_len);
 		} else {
 			/* abort and send the stop by reading one more byte */
@@ -415,7 +415,7 @@ static void at91_twi_read_next_byte(struct at91_twi_dev *dev)
 	if (!dev->use_alt_cmd && dev->buf_len == 1)
 		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_STOP);
 
-	dev_dbg(dev->dev, "read 0x%x, to go %d\n", *dev->buf, dev->buf_len);
+	dev_dbg(dev->dev, "read 0x%x, to go %zu\n", *dev->buf, dev->buf_len);
 
 	++dev->buf;
 }
@@ -622,7 +622,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 	 * writing the corresponding bit into the Control Register.
 	 */
 
-	dev_dbg(dev->dev, "transfer: %s %d bytes.\n",
+	dev_dbg(dev->dev, "transfer: %s %zu bytes.\n",
 		(dev->msg->flags & I2C_M_RD) ? "read" : "write", dev->buf_len);
 
 	reinit_completion(&dev->cmd_complete);
-- 
1.9.1
