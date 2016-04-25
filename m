From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v7 04/15] i2c: octeon: Add flush writeq helper function
Date: Mon, 25 Apr 2016 16:33:33 +0200
Message-ID: <1461594824-7215-5-git-send-email-jglauber@cavium.com>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

From: Peter Swain <pswain@cavium.com>

Add helper function that reads back a value after writing to
make sure the write is finished and use it in octeon_i2c_write_int().

Signed-off-by: Peter Swain <pswain@cavium.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index ad563cf..60a02b2 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -103,6 +103,12 @@ struct octeon_i2c {
 	struct device *dev;
 };
 
+static void octeon_i2c_writeq_flush(u64 val, void __iomem *addr)
+{
+	__raw_writeq(val, addr);
+	__raw_readq(addr);	/* wait for write to land */
+}
+
 /**
  * octeon_i2c_reg_write - write an I2C core register
  * @i2c: The struct octeon_i2c
@@ -173,8 +179,7 @@ static u64 octeon_i2c_read_int(struct octeon_i2c *i2c)
  */
 static void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
 {
-	__raw_writeq(data, i2c->twsi_base + TWSI_INT);
-	__raw_readq(i2c->twsi_base + TWSI_INT);
+	octeon_i2c_writeq_flush(data, i2c->twsi_base + TWSI_INT);
 }
 
 /**
-- 
1.9.1
