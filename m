From: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: [PATCH] i2c-mpc: Do not generate STOP after read.
Date: Tue, 13 Oct 2009 10:12:03 +0200
Message-ID: <1255421523-16268-1-git-send-email-Joakim.Tjernlund@transmode.se>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The driver always ends a read with a STOP condition which
breaks subsequent I2C reads/writes in the same transaction as
these expect to do a repeated START(ReSTART).

This will also help I2C multimaster as the bus will not be released
after the first read, but when the whole transaction ends.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
---

Andrew,

Seems like nobody wants to touch this patch. Jean Delvare
refers to Ben Dooks and he has not replied to any of my mails.
Perhaps you can carry it in you patch queue?

 drivers/i2c/busses/i2c-mpc.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index cdb1858..88ae582 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -369,9 +369,6 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
 	unsigned timeout = i2c->adap.timeout;
 	u32 flags = restart ? CCR_RSTA : 0;
 
-	/* Start with MEN */
-	if (!restart)
-		writeccr(i2c, CCR_MEN);
 	/* Start as master */
 	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
 	/* Write target byte */
@@ -400,9 +397,6 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 	int i, result;
 	u32 flags = restart ? CCR_RSTA : 0;
 
-	/* Start with MEN */
-	if (!restart)
-		writeccr(i2c, CCR_MEN);
 	/* Switch to read - restart */
 	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
 	/* Write target address byte - this time with the read flag set */
@@ -429,9 +423,9 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 		/* Generate txack on next to last byte */
 		if (i == length - 2)
 			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_TXAK);
-		/* Generate stop on last byte */
+		/* Do not generate stop on last byte */
 		if (i == length - 1)
-			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK);
+			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX);
 		data[i] = readb(i2c->base + MPC_I2C_DR);
 	}
 
-- 
1.6.4.3
