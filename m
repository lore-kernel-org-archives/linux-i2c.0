From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: fix PM support.
Date: Sat, 28 Jun 2008 16:12:32 +0200
Message-ID: <20080628161232.22f0ba50@scarran>
References: <20080619082749.GA20058@roarinelk.homelinux.net>
	<20080628112746.32349c47@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080628112746.32349c47-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

> Hi Manuel,
> 
> On Thu, 19 Jun 2008 10:27:49 +0200, Manuel Lauss wrote:
> > From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> > 
> > Factor out reset/disable code to separate functions as they are
> > also required for suspend/resume.
> > 
> > Tested on Au1200.
> > 
> > Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-au1550.c |  119 +++++++++++++++++++++------------------
> >  1 files changed, 64 insertions(+), 55 deletions(-)
> 
> This patch doesn't apply cleanly on top of 2.6.26-rc8. I can try to fix
> it manually, but given that I can't even build the i2c-au1550 driver,
> that's a bit risky. Can you please update the patch so that it applies
> on top of 2.6.26-rc8, test again and resubmit?

Sorry about that; here is the new and tested patch.
I took the opportunity to sneak one additional change in (runtime PM).

Thanks!
	Manuel Lauss

--

From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Subject: [PATCH] i2c-au1550: fix PM support.

Fix driver power management:
- suspend the PSC while driver is idle.
- move PSC init/deinit to separate functions, as PSC must be
  initialized/shutdown on resume/suspend.

Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
---
 drivers/i2c/busses/i2c-au1550.c |  130 ++++++++++++++++++++++----------------
 1 files changed, 75 insertions(+), 55 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index cae9dc8..66a04c2 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -269,9 +269,13 @@ static int
 au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_au1550_data *adap = i2c_adap->algo_data;
+	volatile psc_smb_t *sp = (volatile psc_smb_t *)adap->psc_base;
 	struct i2c_msg *p;
 	int i, err = 0;
 
+	sp->psc_ctrl = PSC_CTRL_ENABLE;
+	au_sync();
+
 	for (i = 0; !err && i < num; i++) {
 		p = &msgs[i];
 		err = do_address(adap, p->addr, p->flags & I2C_M_RD,
@@ -288,6 +292,10 @@ au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 	*/
 	if (err == 0)
 		err = num;
+
+	sp->psc_ctrl = PSC_CTRL_SUSPEND;
+	au_sync();
+
 	return err;
 }
 
@@ -302,6 +310,61 @@ static const struct i2c_algorithm au1550_algo = {
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
+
+	sp->psc_ctrl = PSC_CTRL_SUSPEND;
+	au_sync();
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
@@ -311,9 +374,7 @@ static int __devinit
 i2c_au1550_probe(struct platform_device *pdev)
 {
 	struct i2c_au1550_data *priv;
-	volatile psc_smb_t *sp;
 	struct resource *r;
-	u32 stat;
 	int ret;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -348,43 +409,7 @@ i2c_au1550_probe(struct platform_device *pdev)
 
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
@@ -392,10 +417,7 @@ i2c_au1550_probe(struct platform_device *pdev)
 		return 0;
 	}
 
-	/* disable the PSC */
-	sp->psc_smbcfg = 0;
-	sp->psc_ctrl = PSC_CTRL_DISABLE;
-	au_sync();
+	i2c_au1550_disable(priv);
 
 	release_resource(priv->ioarea);
 	kfree(priv->ioarea);
@@ -409,27 +431,24 @@ static int __devexit
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
 	release_resource(priv->ioarea);
 	kfree(priv->ioarea);
 	kfree(priv);
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
 
@@ -437,14 +456,15 @@ static int
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
