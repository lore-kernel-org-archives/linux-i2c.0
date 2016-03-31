From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v5 07/14] i2c: octeon: Flush TWSI writes with readback
Date: Thu, 31 Mar 2016 12:28:20 +0200
Message-ID: <91058f45f8a356b167a6a478f14b53e7c4df9108.1459352583.git.jglauber@cavium.com>
References: <cover.1459327368.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33946 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929AbcCaK2t (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 31 Mar 2016 06:28:49 -0400
In-Reply-To: <cover.1459327368.git.jglauber@cavium.com>
In-Reply-To: <cover.1459352583.git.jglauber@cavium.com>
References: <cover.1459352583.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Jan Glauber <jglauber@cavium.com>

From: Peter Swain <pswain@cavium.com>

Signed-off-by: Peter Swain <pswain@cavium.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/i2c/busses/i2c-octeon.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index bd5915d..44ce9d4 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -129,6 +129,12 @@ struct octeon_i2c {
 
 static int reset_how;
 
+static void writeqflush(u64 val, void __iomem *addr)
+{
+	__raw_writeq(val, addr);
+	__raw_readq(addr);	/* wait for write to land */
+}
+
 /**
  * octeon_i2c_write_sw - write an I2C core register
  * @i2c: The struct octeon_i2c
@@ -189,8 +195,7 @@ static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
  */
 static void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
 {
-	__raw_writeq(data, i2c->twsi_base + TWSI_INT);
-	__raw_readq(i2c->twsi_base + TWSI_INT);
+	writeqflush(data, i2c->twsi_base + TWSI_INT);
 }
 
 /**
@@ -576,10 +581,10 @@ static int octeon_i2c_simple_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 
 		for (i = 0; i < msgs[0].len - 4 && i < 4; i++, j--)
 			ext |= (u64) msgs[0].buf[j] << (8 * i);
-		__raw_writeq(ext, i2c->twsi_base + SW_TWSI_EXT);
+		writeqflush(ext, i2c->twsi_base + SW_TWSI_EXT);
 	}
 
-	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
 
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
@@ -625,7 +630,7 @@ static int octeon_i2c_ia_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 		cmd |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
 
 	octeon_i2c_hlc_int_clear(i2c);
-	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
 
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
@@ -685,10 +690,10 @@ static int octeon_i2c_ia_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 		set_ext = true;
 	}
 	if (set_ext)
-		__raw_writeq(ext, i2c->twsi_base + SW_TWSI_EXT);
+		writeqflush(ext, i2c->twsi_base + SW_TWSI_EXT);
 
 	octeon_i2c_hlc_int_clear(i2c);
-	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
 
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
-- 
1.9.1
