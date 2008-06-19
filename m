From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Subject: [PATCH] i2c-au1550: fix PM support.
Date: Thu, 19 Jun 2008 10:27:49 +0200
Message-ID: <20080619082749.GA20058@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>

Factor out reset/disable code to separate functions as they are
also required for suspend/resume.

Tested on Au1200.

Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
---
 drivers/i2c/busses/i2c-au1550.c |  119 +++++++++++++++++++++------------------
 1 files changed, 64 insertions(+), 55 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 8c4d9c7..2f23b32 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -312,6 +312,58 @@ static const struct i2c_algorithm au1550_algo = {
 	.functionality	= au1550_func,
 };
 
+static void i2c_au1550_setup(struct i2c_au1550_data *priv)
+{
+	volatile psc_smb_t *sp = (volatile psc_smb_t *)priv->psc_base;
+	u32 stat;
+
+	sp->psc_ctrl = PSC_CTRL_DISABLE;
+	au_sync();
+	sp->psc_sel = PSC_SEL_PS_SMBUSMODE;
+	sp->psc_smbcfg = 0;
+	au_sync();
+	sp->psc_ctrl = PSC_CTRL_ENABLE;
+	au_sync();
+	do {
+		stat = sp->psc_smbstat;
+		au_sync();
+	} while ((stat & PSC_SMBSTAT_SR) == 0);
+
+	sp->psc_smbcfg = (PSC_SMBCFG_RT_FIFO8 | PSC_SMBCFG_TT_FIFO8 |
+				PSC_SMBCFG_DD_DISABLE);
+
+	/* Divide by 8 to get a 6.25 MHz clock.  The later protocol
+	 * timings are based on this clock.
+	 */
+	sp->psc_smbcfg |= PSC_SMBCFG_SET_DIV(PSC_SMBCFG_DIV8);
+	sp->psc_smbmsk = PSC_SMBMSK_ALLMASK;
+	au_sync();
+
+	/* Set the protocol timer values.  See Table 71 in the
+	 * Au1550 Data Book for standard timing values.
+	 */
+	sp->psc_smbtmr = PSC_SMBTMR_SET_TH(0) | PSC_SMBTMR_SET_PS(15) | \
+		PSC_SMBTMR_SET_PU(15) | PSC_SMBTMR_SET_SH(15) | \
+		PSC_SMBTMR_SET_SU(15) | PSC_SMBTMR_SET_CL(15) | \
+		PSC_SMBTMR_SET_CH(15);
+	au_sync();
+
+	sp->psc_smbcfg |= PSC_SMBCFG_DE_ENABLE;
+	do {
+		stat = sp->psc_smbstat;
+		au_sync();
+	} while ((stat & PSC_SMBSTAT_SR) == 0);
+}
+
+static void i2c_au1550_disable(struct i2c_au1550_data *priv)
+{
+	volatile psc_smb_t *sp = (volatile psc_smb_t *)priv->psc_base;
+
+	sp->psc_smbcfg = 0;
+	sp->psc_ctrl = PSC_CTRL_DISABLE;
+	au_sync();
+}
+
 /*
  * registering functions to load algorithms at runtime
  * Prior to calling us, the 50MHz clock frequency and routing
@@ -321,9 +373,7 @@ static int __devinit
 i2c_au1550_probe(struct platform_device *pdev)
 {
 	struct i2c_au1550_data *priv;
-	volatile psc_smb_t *sp;
 	struct resource *r;
-	u32 stat;
 	int ret;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -362,43 +412,7 @@ i2c_au1550_probe(struct platform_device *pdev)
 
 	/* Now, set up the PSC for SMBus PIO mode.
 	*/
-	sp = (volatile psc_smb_t *)priv->psc_base;
-	sp->psc_ctrl = PSC_CTRL_DISABLE;
-	au_sync();
-	sp->psc_sel = PSC_SEL_PS_SMBUSMODE;
-	sp->psc_smbcfg = 0;
-	au_sync();
-	sp->psc_ctrl = PSC_CTRL_ENABLE;
-	au_sync();
-	do {
-		stat = sp->psc_smbstat;
-		au_sync();
-	} while ((stat & PSC_SMBSTAT_SR) == 0);
-
-	sp->psc_smbcfg = (PSC_SMBCFG_RT_FIFO8 | PSC_SMBCFG_TT_FIFO8 |
-				PSC_SMBCFG_DD_DISABLE);
-
-	/* Divide by 8 to get a 6.25 MHz clock.  The later protocol
-	 * timings are based on this clock.
-	 */
-	sp->psc_smbcfg |= PSC_SMBCFG_SET_DIV(PSC_SMBCFG_DIV8);
-	sp->psc_smbmsk = PSC_SMBMSK_ALLMASK;
-	au_sync();
-
-	/* Set the protocol timer values.  See Table 71 in the
-	 * Au1550 Data Book for standard timing values.
-	 */
-	sp->psc_smbtmr = PSC_SMBTMR_SET_TH(0) | PSC_SMBTMR_SET_PS(15) | \
-		PSC_SMBTMR_SET_PU(15) | PSC_SMBTMR_SET_SH(15) | \
-		PSC_SMBTMR_SET_SU(15) | PSC_SMBTMR_SET_CL(15) | \
-		PSC_SMBTMR_SET_CH(15);
-	au_sync();
-
-	sp->psc_smbcfg |= PSC_SMBCFG_DE_ENABLE;
-	do {
-		stat = sp->psc_smbstat;
-		au_sync();
-	} while ((stat & PSC_SMBSTAT_DR) == 0);
+	i2c_au1550_setup(priv);
 
 	ret = i2c_add_numbered_adapter(&priv->adap);
 	if (ret == 0) {
@@ -406,10 +420,7 @@ i2c_au1550_probe(struct platform_device *pdev)
 		return 0;
 	}
 
-	/* disable the PSC */
-	sp->psc_smbcfg = 0;
-	sp->psc_ctrl = PSC_CTRL_DISABLE;
-	au_sync();
+	i2c_au1550_disable(priv);
 
 	iounmap((void *)priv->psc_base);
 out_map:
@@ -425,13 +436,10 @@ static int __devexit
 i2c_au1550_remove(struct platform_device *pdev)
 {
 	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
-	volatile psc_smb_t *sp = (volatile psc_smb_t *)priv->psc_base;
 
 	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&priv->adap);
-	sp->psc_smbcfg = 0;
-	sp->psc_ctrl = PSC_CTRL_DISABLE;
-	au_sync();
+	i2c_au1550_disable(priv);
 	iounmap((void *)priv->psc_base);
 	release_resource(priv->ioarea);
 	kfree(priv->ioarea);
@@ -439,14 +447,14 @@ i2c_au1550_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int
 i2c_au1550_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
-	volatile psc_smb_t *sp = (volatile psc_smb_t *)priv->psc_base;
 
-	sp->psc_ctrl = PSC_CTRL_SUSPEND;
-	au_sync();
+	i2c_au1550_disable(priv);
+
 	return 0;
 }
 
@@ -454,14 +462,15 @@ static int
 i2c_au1550_resume(struct platform_device *pdev)
 {
 	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
-	volatile psc_smb_t *sp = (volatile psc_smb_t *)priv->psc_base;
 
-	sp->psc_ctrl = PSC_CTRL_ENABLE;
-	au_sync();
-	while (!(sp->psc_smbstat & PSC_SMBSTAT_SR))
-		au_sync();
+	i2c_au1550_setup(priv);
+
 	return 0;
 }
+#else
+#define i2c_au1550_suspend	NULL
+#define i2c_au1550_resume	NULL
+#endif
 
 static struct platform_driver au1xpsc_smbus_driver = {
 	.driver = {
-- 
1.5.5.4


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
