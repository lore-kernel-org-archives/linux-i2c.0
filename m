From: Jan Glauber <jglauber@cavium.com>
Subject: [Resend PATCH 06/10] i2c-octeon: Flush TWSI writes with readback
Date: Mon, 29 Feb 2016 14:46:13 +0100
Message-ID: <a3fe08c015f2700f5cdd6b2b770d3e1254751b5e.1456752497.git.jglauber@cavium.com>
References: <cover.1456752497.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1456752497.git.jglauber@cavium.com>
In-Reply-To: <cover.1456752497.git.jglauber@cavium.com>
References: <cover.1456752497.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, ddaney@caviumnetworks.com, Peter Swain <pswain@cavium.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

From: Peter Swain <pswain@cavium.com>

Signed-off-by: Peter Swain <pswain@cavium.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
Acked-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/i2c/busses/i2c-octeon.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 0b28d8c..bb15a9c 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -130,6 +130,12 @@ static int timeout = 2;
 module_param(timeout, int, 0444);
 MODULE_PARM_DESC(timeout, "Low-level device timeout (ms)");
 
+static void writeqflush(u64 val, void __iomem *addr)
+{
+	__raw_writeq(val, addr);
+	__raw_readq(addr);	/* wait for write to land */
+}
+
 /**
  * octeon_i2c_write_sw - write an I2C core register
  * @i2c: The struct octeon_i2c
@@ -190,8 +196,7 @@ static u8 octeon_i2c_read_sw(struct octeon_i2c *i2c, u64 eop_reg)
  */
 static void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
 {
-	__raw_writeq(data, i2c->twsi_base + TWSI_INT);
-	__raw_readq(i2c->twsi_base + TWSI_INT);
+	writeqflush(data, i2c->twsi_base + TWSI_INT);
 }
 
 /**
@@ -797,10 +802,10 @@ static int octeon_i2c_simple_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 
 		for (i = 0; i < msgs[0].len - 4 && i < 4; i++, j--)
 			ext |= (u64) msgs[0].buf[j] << (8 * i);
-		__raw_writeq(ext, i2c->twsi_base + SW_TWSI_EXT);
+		writeqflush(ext, i2c->twsi_base + SW_TWSI_EXT);
 	}
 
-	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
 
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
@@ -846,7 +851,7 @@ static int octeon_i2c_ia_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 		cmd |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
 
 	octeon_i2c_hlc_int_clear(i2c);
-	__raw_writeq(cmd, i2c->twsi_base + SW_TWSI);
+	writeqflush(cmd, i2c->twsi_base + SW_TWSI);
 
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
@@ -906,10 +911,10 @@ static int octeon_i2c_ia_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
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
