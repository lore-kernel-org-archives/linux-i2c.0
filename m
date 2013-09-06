From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 4/7] power/mpc85xx: Add delay after enabling I2C master
Date: Fri, 6 Sep 2013 08:43:16 -0700
Message-ID: <1378482199-10581-4-git-send-email-yorksun@freescale.com>
References: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1378482199-10581-1-git-send-email-yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Erratum A-006037 indicates I2C controller executes the write to I2CCR only
after it sees SCL idle for 64K cycle of internal I2C controller clocks. If
during this waiting period, I2C controller is disabled (I2CCR[MEN] set to
0), then the controller could end in bad state, and hang the future access
to I2C register.

The mpc_i2c_fixup() function tries to recover the bus from a stalled state
where the 9th clock pulse wasn't generated. However, this workaround
disables and enables I2C controller without meeting waiting requirement of
this erratum.

This erratum applies to some 85xx SoCs. It is safe to apply to all of them
for mpc_i2c_fixup().

Signed-off-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Reviewed-by: Wood Scott-B07421 <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Tested-by: Fleming Andrew-AFLEMING <AFLEMING-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
CC: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/i2c/busses/i2c-mpc.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index b80c768..55dce43 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -106,7 +106,12 @@ static irqreturn_t mpc_i2c_isr(int irq, void *dev_id)
 static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 {
 	int k;
-	u32 delay_val = 1000000 / i2c->real_clk + 1;
+	u32 delay_val;
+#ifdef CONFIG_PPC_85xx
+	delay_val = 65536 / (fsl_get_sys_freq() / 2000000);	/* 64K cycle */
+#else
+	delay_val = 1000000 / i2c->real_clk + 1;
+#endif
 
 	if (delay_val < 2)
 		delay_val = 2;
@@ -116,7 +121,11 @@ static void mpc_i2c_fixup(struct mpc_i2c *i2c)
 		writeccr(i2c, CCR_MSTA | CCR_MTX | CCR_MEN);
 		udelay(delay_val);
 		writeccr(i2c, CCR_MEN);
+#ifdef CONFIG_PPC_85xx
+		udelay(delay_val);
+#else
 		udelay(delay_val << 1);
+#endif
 	}
 }
 
-- 
1.7.9.5
