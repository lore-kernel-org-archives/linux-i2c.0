From: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: i2c-au1550: relax bus timings a bit
Date: Tue,  8 Sep 2015 08:56:23 +0200
Message-ID: <1441695383-87868-1-git-send-email-manuel.lauss@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-au1550 driver has to program various setup and hold times
for the sda/scl signals by hand.  The current values seem to be
working best when the driver is supplied with 50MHz, however on the
DB1300 board 48MHz is the closest we can get to it, and the timings
are a bit too tight for that, leading to the last bit of a transmission
sometimes being swallowed.  This manifests itself in wrong readings
of the ne1619 sensor and inability to configure the wm8731 i2s codec.

With the relaxed timings, both the sensor and the i2s codec can now
be accessed more reliably over a wider range of I2C block input
frequencies.

Verified on DB1200, DB1300 and DB1550 boards.

Signed-off-by: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-au1550.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index a6aae84..4de1107 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -284,10 +284,10 @@ static void i2c_au1550_setup(struct i2c_au1550_data *priv)
 	/* Set the protocol timer values.  See Table 71 in the
 	 * Au1550 Data Book for standard timing values.
 	 */
-	WR(priv, PSC_SMBTMR, PSC_SMBTMR_SET_TH(0) | PSC_SMBTMR_SET_PS(15) | \
-		PSC_SMBTMR_SET_PU(15) | PSC_SMBTMR_SET_SH(15) | \
-		PSC_SMBTMR_SET_SU(15) | PSC_SMBTMR_SET_CL(15) | \
-		PSC_SMBTMR_SET_CH(15));
+	WR(priv, PSC_SMBTMR, PSC_SMBTMR_SET_TH(0) | PSC_SMBTMR_SET_PS(20) | \
+		PSC_SMBTMR_SET_PU(20) | PSC_SMBTMR_SET_SH(20) | \
+		PSC_SMBTMR_SET_SU(20) | PSC_SMBTMR_SET_CL(20) | \
+		PSC_SMBTMR_SET_CH(20));
 
 	cfg |= PSC_SMBCFG_DE_ENABLE;
 	WR(priv, PSC_SMBCFG, cfg);
-- 
2.5.1
