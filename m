From: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2] I2C: mpc: insert DR read in i2c_fixup()
Date: Tue,  3 Jun 2014 11:00:32 +0200
Message-ID: <1401786032-17818-1-git-send-email-valentin.longchamp@keymile.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Cox <adrian-nKrwMtk+6Wm9FHfhHBbuYA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Rainer Boschung <rainer.boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The mpc_i2c_fixup function is called when the bus is not released by a
slave. The function generates 9 pulses that should lead the slave
to release the bus.

The sequence that generates the pulses disables/enables the I2C module
that controls the blocked bus. We have found out on the P2041 SoC that
this could cause the CPU to hang (for a short delay).

To avoid this, this patch introduces a read to the I2CDR register
between the re-enablement of the I2C module in master mode and its
returning to the slave mode instead of the delay (the final delay,
between the pulses is kept), as proposed in procedure from the P2041
reference manual (16.6.2.3), and the other manuals from the mpc83xx and
mpc85xx families.

Signed-off-by: Rainer Boschung <rainer.boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>

---

Changes in v2:
- removed unused dr register read variable
- improve commit message (reference to other MPC families)

 drivers/i2c/busses/i2c-mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index f539163..6a32aa0 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -115,7 +115,7 @@ static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 	for (k = 9; k; k--) {
 		writeccr(i2c, 0);
 		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
-		udelay(delay_val);
+		readb(i2c->base + MPC_I2C_DR);
 		writeccr(i2c, CCR_MEN);
 		udelay(delay_val << 1);
 	}
-- 
1.8.0.1
