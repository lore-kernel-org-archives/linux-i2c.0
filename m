From: Nickolaus Woodruff <nickolauswoodruff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drivers/i2c/i2c-core.c: Fix sparse warning
Date: Thu, 2 Apr 2015 22:53:38 -0400
Message-ID: <20150403025338.GA18595@Caladan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch fixes the following sparse warning in drivers/i2c/:

CHECK   drivers/i2c/i2c-core.c
drivers/i2c/i2c-core.c:2353:36: warning: dubious: x | !y

Signed-off-by: Nickolaus Woodruff <nickolauswoodruff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index edf274c..f50d46e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2350,7 +2350,7 @@ static u8 i2c_smbus_pec(u8 crc, u8 *p, size_t count)
 static u8 i2c_smbus_msg_pec(u8 pec, struct i2c_msg *msg)
 {
 	/* The address will be sent first */
-	u8 addr = (msg->addr << 1) | !!(msg->flags & I2C_M_RD);
+	u8 addr = (msg->addr << 1) | ((msg->flags & I2C_M_RD) != 0);
 	pec = i2c_smbus_pec(pec, &addr, 1);

 	/* The data buffer follows */
--
1.9.1
