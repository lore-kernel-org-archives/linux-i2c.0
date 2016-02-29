From: Jan Glauber <jglauber@cavium.com>
Subject: [Resend PATCH 02/10] i2c-octeon: Support I2C_M_RECV_LEN
Date: Mon, 29 Feb 2016 14:46:09 +0100
Message-ID: <5f4464a95f70dc1f2a5d324616bb20de020d38dd.1456752497.git.jglauber@cavium.com>
References: <cover.1456752497.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33769 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbcB2Nqj (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 29 Feb 2016 08:46:39 -0500
In-Reply-To: <cover.1456752497.git.jglauber@cavium.com>
In-Reply-To: <cover.1456752497.git.jglauber@cavium.com>
References: <cover.1456752497.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, ddaney@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>

From: David Daney <ddaney@caviumnetworks.com>

If I2C_M_RECV_LEN is set consider the length byte.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 1f14094..fa4d439 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -392,13 +392,14 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
  * @target: Target address
  * @data: Pointer to the location to store the data
  * @rlength: Length of the data
+ * @recv_len: flag for length byte
  *
  * The address is sent over the bus, then the data is read.
  *
  * Returns 0 on success, otherwise a negative errno.
  */
 static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
-			   u16 *rlength)
+			   u16 *rlength, bool recv_len)
 {
 	int length = *rlength;
 	int i, result;
@@ -438,6 +439,15 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
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
 	*rlength = length;
 	return 0;
@@ -466,7 +476,8 @@ static int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			 pmsg->len, pmsg->addr, i + 1, num);
 		if (pmsg->flags & I2C_M_RD)
 			ret = octeon_i2c_read(i2c, pmsg->addr, pmsg->buf,
-					      &pmsg->len);
+					      &pmsg->len,
+					      pmsg->flags & I2C_M_RECV_LEN);
 		else
 			ret = octeon_i2c_write(i2c, pmsg->addr, pmsg->buf,
 					       pmsg->len);
-- 
1.9.1
