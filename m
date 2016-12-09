From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 3/4] i2c: octeon: thunderx: Limit register access retries
Date: Fri,  9 Dec 2016 10:31:57 +0100
Message-ID: <20161209093158.3161-4-jglauber@cavium.com>
References: <20161209093158.3161-1-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32999 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933210AbcLIJca (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Dec 2016 04:32:30 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so2764168wmu.0
        for <linux-i2c@vger.kernel.org>; Fri, 09 Dec 2016 01:32:29 -0800 (PST)
In-Reply-To: <20161209093158.3161-1-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: Paul Burton <paul.burton@imgtec.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Jan Glauber <jglauber@cavium.com>

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
index 3d10f1a..1d8775799 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -342,7 +342,9 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
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
index 87151ea..e160f83 100644
--- a/drivers/i2c/busses/i2c-octeon-core.h
+++ b/drivers/i2c/busses/i2c-octeon-core.h
@@ -141,11 +141,14 @@ static inline void octeon_i2c_writeq_flush(u64 val, void __iomem *addr)
  */
 static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8 data)
 {
+	int tries = 1000;
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
+	int tries = 1000;
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
2.9.0.rc0.21.g7777322
