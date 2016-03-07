From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v3 04/14] i2c-octeon: Support I2C_M_RECV_LEN
Date: Mon,  7 Mar 2016 16:10:47 +0100
Message-ID: <aa1595b6fd6b16fbc0339115b2169acb6458dd38.1457362545.git.jglauber@cavium.com>
References: <cover.1457362545.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33621 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbcCGPLT (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Mar 2016 10:11:19 -0500
In-Reply-To: <cover.1457362545.git.jglauber@cavium.com>
In-Reply-To: <cover.1457362545.git.jglauber@cavium.com>
References: <cover.1457362545.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>

From: David Daney <david.daney@cavium.com>

If I2C_M_RECV_LEN is set consider the length byte.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 519e328..6041cd7 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -315,16 +315,17 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
  * @i2c: The struct octeon_i2c
  * @target: Target address
  * @data: Pointer to the location to store the data
- * @length: Length of the data
+ * @rlength: Length of the data
+ * @recv_len: flag for length byte
  *
  * The address is sent over the bus, then the data is read.
  *
  * Returns 0 on success, otherwise a negative errno.
  */
 static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
-			   u8 *data, int length)
+			   u8 *data, u16 *rlength, bool recv_len)
 {
-	int i, result;
+	int i, result, length = *rlength;
 	u8 tmp;
 
 	if (length < 1)
@@ -363,7 +364,17 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 			return result;
 
 		data[i] = octeon_i2c_read_sw(i2c, SW_TWSI_EOP_TWSI_DATA);
+		if (recv_len && i == 0) {
+			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1) {
+				dev_err(i2c->dev,
+					"%s: read len > I2C_SMBUS_BLOCK_MAX %d\n",
+					__func__, data[i]);
+				return -EIO;
+			}
+			length += data[i];
+		}
 	}
+	*rlength = length;
 	return 0;
 }
 
@@ -390,7 +401,7 @@ static int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			 pmsg->len, pmsg->addr, i + 1, num);
 		if (pmsg->flags & I2C_M_RD)
 			ret = octeon_i2c_read(i2c, pmsg->addr, pmsg->buf,
-					      pmsg->len);
+					      &pmsg->len, pmsg->flags & I2C_M_RECV_LEN);
 		else
 			ret = octeon_i2c_write(i2c, pmsg->addr, pmsg->buf,
 					       pmsg->len);
-- 
1.9.1
