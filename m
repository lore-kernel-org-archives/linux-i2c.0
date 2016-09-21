From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 5/5] i2c: octeon,thunderx: Limit register access retries
Date: Wed, 21 Sep 2016 08:51:06 +0200
Message-ID: <a52c3157fd27c939185163d2df23e39174cabc60.1474439371.git.jglauber@cavium.com>
References: <cover.1474439371.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34321 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752733AbcIUGvm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Sep 2016 02:51:42 -0400
In-Reply-To: <cover.1474439371.git.jglauber@cavium.com>
In-Reply-To: <cover.1474439371.git.jglauber@cavium.com>
References: <cover.1474439371.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

Do not infinitely retry register readq and writeq operations
in order to not lock up the CPU in case the TWSI gets stuck.

Return -EIO in case of a failed data read. For all other
cases just return so subsequent operations will fail
and trigger the recovery.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c |  4 +++-
 drivers/i2c/busses/i2c-octeon-core.h | 21 ++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index b21aa3e..6ba0146 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -381,7 +381,9 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 		if (result)
 			return result;
 
-		data[i] = octeon_i2c_data_read(i2c);
+		data[i] = octeon_i2c_data_read(i2c, &result);
+		if (result)
+			return result;
 		if (recv_len && i == 0) {
 			if (data[i] > I2C_SMBUS_BLOCK_MAX + 1)
 				return -EPROTO;
diff --git a/drivers/i2c/busses/i2c-octeon-core.h b/drivers/i2c/busses/i2c-octeon-core.h
index 87151ea..177d4cc 100644
--- a/drivers/i2c/busses/i2c-octeon-core.h
+++ b/drivers/i2c/busses/i2c-octeon-core.h
@@ -141,11 +141,14 @@ static inline void octeon_i2c_writeq_flush(u64 val, void __iomem *addr)
  */
 static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8 data)
 {
+	int tries = 100;
 	u64 tmp;
 
 	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + SW_TWSI(i2c));
 	do {
 		tmp = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
+		if (--tries < 0)
+			return;
 	} while ((tmp & SW_TWSI_V) != 0);
 }
 
@@ -163,24 +166,32 @@ static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8
  *
  * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
  */
-static inline u8 octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg)
+static inline int octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg,
+				      int *error)
 {
+	int tries = 100;
 	u64 tmp;
 
 	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base + SW_TWSI(i2c));
 	do {
 		tmp = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
+		if (--tries < 0) {
+			/* signal that the returned data is invalid */
+			if (error)
+				*error = -EIO;
+			return 0;
+		}
 	} while ((tmp & SW_TWSI_V) != 0);
 
 	return tmp & 0xFF;
 }
 
 #define octeon_i2c_ctl_read(i2c)					\
-	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_CTL)
-#define octeon_i2c_data_read(i2c)					\
-	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_DATA)
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_CTL, NULL)
+#define octeon_i2c_data_read(i2c, error)				\
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_DATA, error)
 #define octeon_i2c_stat_read(i2c)					\
-	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT)
+	octeon_i2c_reg_read(i2c, SW_TWSI_EOP_TWSI_STAT, NULL)
 
 /**
  * octeon_i2c_read_int - read the TWSI_INT register
-- 
1.9.1
