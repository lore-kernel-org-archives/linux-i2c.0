From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 2/2] i2c: octeon: thunderx: Limit register access retries
Date: Fri, 23 Sep 2016 11:40:39 +0200
Message-ID: <1140690b8b727cd09afb9c5867983815f33a08c7.1474565039.git.jglauber@cavium.com>
References: <cover.1474565039.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1474565039.git.jglauber@cavium.com>
In-Reply-To: <cover.1474565039.git.jglauber@cavium.com>
References: <cover.1474565039.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Do not infinitely retry register readq and writeq operations
in order to not lock up the CPU in case the TWSI gets stuck.

Return -ETIMEDOUT in case of a failed data read. For all other
cases just return so subsequent operations will fail
and trigger the recovery.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c |  4 +++-
 drivers/i2c/busses/i2c-octeon-core.h | 27 ++++++++++++++++-----------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index f526511..1dfc4b8 100644
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
index 87151ea..1db7c83 100644
--- a/drivers/i2c/busses/i2c-octeon-core.h
+++ b/drivers/i2c/busses/i2c-octeon-core.h
@@ -5,6 +5,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-smbus.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
@@ -144,9 +145,9 @@ static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8
 	u64 tmp;
 
 	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + SW_TWSI(i2c));
-	do {
-		tmp = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
-	} while ((tmp & SW_TWSI_V) != 0);
+
+	readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp, tmp & SW_TWSI_V,
+			   I2C_OCTEON_EVENT_WAIT, i2c->adap.timeout);
 }
 
 #define octeon_i2c_ctl_write(i2c, val)					\
@@ -163,24 +164,28 @@ static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8
  *
  * The I2C core registers are accessed indirectly via the SW_TWSI CSR.
  */
-static inline u8 octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg)
+static inline int octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg,
+				      int *error)
 {
 	u64 tmp;
+	int ret;
 
 	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base + SW_TWSI(i2c));
-	do {
-		tmp = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
-	} while ((tmp & SW_TWSI_V) != 0);
 
+	ret = readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp,
+				 tmp & SW_TWSI_V, I2C_OCTEON_EVENT_WAIT,
+				 i2c->adap.timeout);
+	if (error)
+		*error = ret;
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
