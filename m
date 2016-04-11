From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v6 11/19] i2c: octeon: Flush TWSI writes with readback
Date: Mon, 11 Apr 2016 17:28:42 +0200
Message-ID: <0a859e6918a2c7fbe0e71040a840e770e5b2d10a.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

From: Peter Swain <pswain@cavium.com>

Signed-off-by: Peter Swain <pswain@cavium.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/i2c/busses/i2c-octeon.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index fff1ac0..8d54fc9 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -127,6 +127,12 @@ struct octeon_i2c {
 	atomic_t hlc_int_en_cnt;
 };
 
+static void writeqflush(u64 val, void __iomem *addr)
+{
+	__raw_writeq(val, addr);
+	__raw_readq(addr);	/* wait for write to land */
+}
+
 /**
  * octeon_i2c_reg_write - write an I2C core register
  * @i2c: The struct octeon_i2c
@@ -197,8 +203,7 @@ static u64 octeon_i2c_read_int(struct octeon_i2c *i2c)
  */
 static void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
 {
-	__raw_writeq(data, i2c->twsi_base + TWSI_INT);
-	__raw_readq(i2c->twsi_base + TWSI_INT);
+	writeqflush(data, i2c->twsi_base + TWSI_INT);
 }
 
 /**
@@ -487,7 +492,7 @@ static int octeon_i2c_hlc_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 	else
 		cmd |= SW_TWSI_OP_7;
 
-	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
 		goto err;
@@ -541,10 +546,10 @@ static int octeon_i2c_hlc_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 
 		for (i = 0; i < msgs[0].len - 4 && i < 4; i++, j--)
 			ext |= (u64) msgs[0].buf[j] << (8 * i);
-		__raw_writeq(ext, i2c->twsi_base + SW_TWSI_EXT);
+		writeqflush(ext, i2c->twsi_base + SW_TWSI_EXT);
 	}
 
-	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
 		goto err;
@@ -589,7 +594,7 @@ static int octeon_i2c_hlc_comp_read(struct octeon_i2c *i2c, struct i2c_msg *msgs
 		cmd |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
 
 	octeon_i2c_hlc_int_clear(i2c);
-	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
 
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
@@ -649,10 +654,10 @@ static int octeon_i2c_hlc_comp_write(struct octeon_i2c *i2c, struct i2c_msg *msg
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
