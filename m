From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH 1/4] i2c/au1550: remove usage of volatile keyword
Date: Thu, 14 Jul 2011 10:56:52 +0200
Message-ID: <1310633815-18817-2-git-send-email-manuel.lauss@googlemail.com>
References: <1310633815-18817-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1310633815-18817-1-git-send-email-manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Replace the usage of "volatile"s with register accessor functions.

Signed-off-by: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 arch/mips/include/asm/mach-au1x00/au1xxx_psc.h |   13 --
 drivers/i2c/busses/i2c-au1550.c                |  252 +++++++++--------------
 2 files changed, 99 insertions(+), 166 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_psc.h b/arch/mips/include/asm/mach-au1x00/au1xxx_psc.h
index 892b7f1..5a5cb73 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_psc.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_psc.h
@@ -394,19 +394,6 @@ typedef struct	psc_spi {
 #define PSC_SPITXRX_LC		(1 << 29)
 #define PSC_SPITXRX_SR		(1 << 28)
 
-/* PSC in SMBus (I2C) Mode. */
-typedef struct	psc_smb {
-	u32	psc_sel;
-	u32	psc_ctrl;
-	u32	psc_smbcfg;
-	u32	psc_smbmsk;
-	u32	psc_smbpcr;
-	u32	psc_smbstat;
-	u32	psc_smbevnt;
-	u32	psc_smbtxrx;
-	u32	psc_smbtmr;
-} psc_smb_t;
-
 /* SMBus Config Register. */
 #define PSC_SMBCFG_RT_MASK	(3 << 30)
 #define PSC_SMBCFG_RT_FIFO1	(0 << 30)
diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 532828b..70b027c 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -39,29 +39,42 @@
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
+#define PSC_SEL		0x00
+#define PSC_CTRL	0x04
+#define PSC_SMBCFG	0x08
+#define PSC_SMBMSK	0x0C
+#define PSC_SMBPCR	0x10
+#define PSC_SMBSTAT	0x14
+#define PSC_SMBEVNT	0x18
+#define PSC_SMBTXRX	0x1C
+#define PSC_SMBTMR	0x20
+
 struct i2c_au1550_data {
-	u32	psc_base;
+	void __iomem *psc_base;
 	int	xfer_timeout;
 	int	ack_timeout;
 	struct i2c_adapter adap;
 	struct resource *ioarea;
 };
 
-static int
-wait_xfer_done(struct i2c_au1550_data *adap)
+static inline void WR(struct i2c_au1550_data *a, int r, unsigned long v)
 {
-	u32	stat;
-	int	i;
-	volatile psc_smb_t	*sp;
+	__raw_writel(v, a->psc_base + r);
+	wmb();
+}
 
-	sp = (volatile psc_smb_t *)(adap->psc_base);
+static inline unsigned long RD(struct i2c_au1550_data *a, int r)
+{
+	return __raw_readl(a->psc_base + r);
+}
 
-	/* Wait for Tx Buffer Empty
-	*/
+static int wait_xfer_done(struct i2c_au1550_data *adap)
+{
+	int i;
+
+	/* Wait for Tx Buffer Empty */
 	for (i = 0; i < adap->xfer_timeout; i++) {
-		stat = sp->psc_smbstat;
-		au_sync();
-		if ((stat & PSC_SMBSTAT_TE) != 0)
+		if (RD(adap, PSC_SMBSTAT) & PSC_SMBSTAT_TE)
 			return 0;
 
 		udelay(1);
@@ -70,41 +83,27 @@ wait_xfer_done(struct i2c_au1550_data *adap)
 	return -ETIMEDOUT;
 }
 
-static int
-wait_ack(struct i2c_au1550_data *adap)
+static int wait_ack(struct i2c_au1550_data *adap)
 {
-	u32	stat;
-	volatile psc_smb_t	*sp;
+	unsigned long stat;
 
 	if (wait_xfer_done(adap))
 		return -ETIMEDOUT;
 
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-
-	stat = sp->psc_smbevnt;
-	au_sync();
-
+	stat = RD(adap, PSC_SMBEVNT);
 	if ((stat & (PSC_SMBEVNT_DN | PSC_SMBEVNT_AN | PSC_SMBEVNT_AL)) != 0)
 		return -ETIMEDOUT;
 
 	return 0;
 }
 
-static int
-wait_master_done(struct i2c_au1550_data *adap)
+static int wait_master_done(struct i2c_au1550_data *adap)
 {
-	u32	stat;
-	int	i;
-	volatile psc_smb_t	*sp;
+	int i;
 
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-
-	/* Wait for Master Done.
-	*/
+	/* Wait for Master Done. */
 	for (i = 0; i < adap->xfer_timeout; i++) {
-		stat = sp->psc_smbevnt;
-		au_sync();
-		if ((stat & PSC_SMBEVNT_MD) != 0)
+		if ((RD(adap, PSC_SMBEVNT) & PSC_SMBEVNT_MD) != 0)
 			return 0;
 		udelay(1);
 	}
@@ -115,29 +114,20 @@ wait_master_done(struct i2c_au1550_data *adap)
 static int
 do_address(struct i2c_au1550_data *adap, unsigned int addr, int rd, int q)
 {
-	volatile psc_smb_t	*sp;
-	u32			stat;
+	unsigned long stat;
 
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-
-	/* Reset the FIFOs, clear events.
-	*/
-	stat = sp->psc_smbstat;
-	sp->psc_smbevnt = PSC_SMBEVNT_ALLCLR;
-	au_sync();
+	/* Reset the FIFOs, clear events. */
+	stat = RD(adap, PSC_SMBSTAT);
+	WR(adap, PSC_SMBEVNT, PSC_SMBEVNT_ALLCLR);
 
 	if (!(stat & PSC_SMBSTAT_TE) || !(stat & PSC_SMBSTAT_RE)) {
-		sp->psc_smbpcr = PSC_SMBPCR_DC;
-		au_sync();
-		do {
-			stat = sp->psc_smbpcr;
-			au_sync();
-		} while ((stat & PSC_SMBPCR_DC) != 0);
+		WR(adap, PSC_SMBPCR, PSC_SMBPCR_DC);
+		while ((RD(adap, PSC_SMBPCR) & PSC_SMBPCR_DC) != 0)
+			cpu_relax();
 		udelay(50);
 	}
 
-	/* Write out the i2c chip address and specify operation
-	*/
+	/* Write out the i2c chip address and specify operation */
 	addr <<= 1;
 	if (rd)
 		addr |= 1;
@@ -146,56 +136,42 @@ do_address(struct i2c_au1550_data *adap, unsigned int addr, int rd, int q)
 	if (q)
 		addr |= PSC_SMBTXRX_STP;
 
-	/* Put byte into fifo, start up master.
-	*/
-	sp->psc_smbtxrx = addr;
-	au_sync();
-	sp->psc_smbpcr = PSC_SMBPCR_MS;
-	au_sync();
+	/* Put byte into fifo, start up master. */
+	WR(adap, PSC_SMBTXRX, addr);
+	WR(adap, PSC_SMBPCR, PSC_SMBPCR_MS);
 	if (wait_ack(adap))
 		return -EIO;
 	return (q) ? wait_master_done(adap) : 0;
 }
 
-static u32
-wait_for_rx_byte(struct i2c_au1550_data *adap, u32 *ret_data)
+static int wait_for_rx_byte(struct i2c_au1550_data *adap, unsigned char *out)
 {
-	int	j;
-	u32	data, stat;
-	volatile psc_smb_t	*sp;
+	int j;
 
 	if (wait_xfer_done(adap))
 		return -EIO;
 
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-
 	j =  adap->xfer_timeout * 100;
 	do {
 		j--;
 		if (j <= 0)
 			return -EIO;
 
-		stat = sp->psc_smbstat;
-		au_sync();
-		if ((stat & PSC_SMBSTAT_RE) == 0)
+		if ((RD(adap, PSC_SMBSTAT) & PSC_SMBSTAT_RE) == 0)
 			j = 0;
 		else
 			udelay(1);
 	} while (j > 0);
-	data = sp->psc_smbtxrx;
-	au_sync();
-	*ret_data = data;
+
+	*out = RD(adap, PSC_SMBTXRX);
 
 	return 0;
 }
 
-static int
-i2c_read(struct i2c_au1550_data *adap, unsigned char *buf,
+static int i2c_read(struct i2c_au1550_data *adap, unsigned char *buf,
 		    unsigned int len)
 {
-	int	i;
-	u32	data;
-	volatile psc_smb_t	*sp;
+	int i;
 
 	if (len == 0)
 		return 0;
@@ -204,62 +180,46 @@ i2c_read(struct i2c_au1550_data *adap, unsigned char *buf,
 	 * zero bytes for timing, waiting for bytes to appear in the
 	 * receive fifo, then reading the bytes.
 	 */
-
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-
 	i = 0;
-	while (i < (len-1)) {
-		sp->psc_smbtxrx = 0;
-		au_sync();
-		if (wait_for_rx_byte(adap, &data))
+	while (i < (len - 1)) {
+		WR(adap, PSC_SMBTXRX, 0);
+		if (wait_for_rx_byte(adap, &buf[i]))
 			return -EIO;
 
-		buf[i] = data;
 		i++;
 	}
 
-	/* The last byte has to indicate transfer done.
-	*/
-	sp->psc_smbtxrx = PSC_SMBTXRX_STP;
-	au_sync();
+	/* The last byte has to indicate transfer done. */
+	WR(adap, PSC_SMBTXRX, PSC_SMBTXRX_STP);
 	if (wait_master_done(adap))
 		return -EIO;
 
-	data = sp->psc_smbtxrx;
-	au_sync();
-	buf[i] = data;
+	buf[i] = (unsigned char)(RD(adap, PSC_SMBTXRX) & 0xff);
 	return 0;
 }
 
-static int
-i2c_write(struct i2c_au1550_data *adap, unsigned char *buf,
+static int i2c_write(struct i2c_au1550_data *adap, unsigned char *buf,
 		     unsigned int len)
 {
-	int	i;
-	u32	data;
-	volatile psc_smb_t	*sp;
+	int i;
+	unsigned long data;
 
 	if (len == 0)
 		return 0;
 
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-
 	i = 0;
 	while (i < (len-1)) {
 		data = buf[i];
-		sp->psc_smbtxrx = data;
-		au_sync();
+		WR(adap, PSC_SMBTXRX, data);
 		if (wait_ack(adap))
 			return -EIO;
 		i++;
 	}
 
-	/* The last byte has to indicate transfer done.
-	*/
+	/* The last byte has to indicate transfer done. */
 	data = buf[i];
 	data |= PSC_SMBTXRX_STP;
-	sp->psc_smbtxrx = data;
-	au_sync();
+	WR(adap, PSC_SMBTXRX, data);
 	if (wait_master_done(adap))
 		return -EIO;
 	return 0;
@@ -269,12 +229,10 @@ static int
 au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_au1550_data *adap = i2c_adap->algo_data;
-	volatile psc_smb_t *sp = (volatile psc_smb_t *)adap->psc_base;
 	struct i2c_msg *p;
 	int i, err = 0;
 
-	sp->psc_ctrl = PSC_CTRL_ENABLE;
-	au_sync();
+	WR(adap, PSC_CTRL, PSC_CTRL_ENABLE);
 
 	for (i = 0; !err && i < num; i++) {
 		p = &msgs[i];
@@ -293,14 +251,12 @@ au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 	if (err == 0)
 		err = num;
 
-	sp->psc_ctrl = PSC_CTRL_SUSPEND;
-	au_sync();
+	WR(adap, PSC_CTRL, PSC_CTRL_SUSPEND);
 
 	return err;
 }
 
-static u32
-au1550_func(struct i2c_adapter *adap)
+static u32 au1550_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
@@ -312,57 +268,45 @@ static const struct i2c_algorithm au1550_algo = {
 
 static void i2c_au1550_setup(struct i2c_au1550_data *priv)
 {
-	volatile psc_smb_t *sp = (volatile psc_smb_t *)priv->psc_base;
-	u32 stat;
-
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
+	unsigned long cfg;
 
-	sp->psc_smbcfg = (PSC_SMBCFG_RT_FIFO8 | PSC_SMBCFG_TT_FIFO8 |
-				PSC_SMBCFG_DD_DISABLE);
+	WR(priv, PSC_CTRL, PSC_CTRL_DISABLE);
+	WR(priv, PSC_SEL, PSC_SEL_PS_SMBUSMODE);
+	WR(priv, PSC_SMBCFG, 0);
+	WR(priv, PSC_CTRL, PSC_CTRL_ENABLE);
+	while ((RD(priv, PSC_SMBSTAT) & PSC_SMBSTAT_SR) == 0)
+		cpu_relax();
+
+	cfg = PSC_SMBCFG_RT_FIFO8 | PSC_SMBCFG_TT_FIFO8 | PSC_SMBCFG_DD_DISABLE;
+	WR(priv, PSC_SMBCFG, cfg);
 
 	/* Divide by 8 to get a 6.25 MHz clock.  The later protocol
 	 * timings are based on this clock.
 	 */
-	sp->psc_smbcfg |= PSC_SMBCFG_SET_DIV(PSC_SMBCFG_DIV8);
-	sp->psc_smbmsk = PSC_SMBMSK_ALLMASK;
-	au_sync();
+	cfg |= PSC_SMBCFG_SET_DIV(PSC_SMBCFG_DIV8);
+	WR(priv, PSC_SMBCFG, cfg);
+	WR(priv, PSC_SMBMSK, PSC_SMBMSK_ALLMASK);
 
 	/* Set the protocol timer values.  See Table 71 in the
 	 * Au1550 Data Book for standard timing values.
 	 */
-	sp->psc_smbtmr = PSC_SMBTMR_SET_TH(0) | PSC_SMBTMR_SET_PS(15) | \
+	WR(priv, PSC_SMBTMR, PSC_SMBTMR_SET_TH(0) | PSC_SMBTMR_SET_PS(15) | \
 		PSC_SMBTMR_SET_PU(15) | PSC_SMBTMR_SET_SH(15) | \
 		PSC_SMBTMR_SET_SU(15) | PSC_SMBTMR_SET_CL(15) | \
-		PSC_SMBTMR_SET_CH(15);
-	au_sync();
+		PSC_SMBTMR_SET_CH(15));
 
-	sp->psc_smbcfg |= PSC_SMBCFG_DE_ENABLE;
-	do {
-		stat = sp->psc_smbstat;
-		au_sync();
-	} while ((stat & PSC_SMBSTAT_SR) == 0);
+	cfg |= PSC_SMBCFG_DE_ENABLE;
+	WR(priv, PSC_SMBCFG, cfg);
+	while ((RD(priv, PSC_SMBSTAT) & PSC_SMBSTAT_SR) == 0)
+		cpu_relax();
 
-	sp->psc_ctrl = PSC_CTRL_SUSPEND;
-	au_sync();
+	WR(priv, PSC_CTRL, PSC_CTRL_SUSPEND);
 }
 
 static void i2c_au1550_disable(struct i2c_au1550_data *priv)
 {
-	volatile psc_smb_t *sp = (volatile psc_smb_t *)priv->psc_base;
-
-	sp->psc_smbcfg = 0;
-	sp->psc_ctrl = PSC_CTRL_DISABLE;
-	au_sync();
+	WR(priv, PSC_SMBCFG, 0);
+	WR(priv, PSC_CTRL, PSC_CTRL_DISABLE);
 }
 
 /*
@@ -396,7 +340,11 @@ i2c_au1550_probe(struct platform_device *pdev)
 		goto out_mem;
 	}
 
-	priv->psc_base = CKSEG1ADDR(r->start);
+	priv->psc_base = ioremap(r->start, resource_size(r));
+	if (!priv->psc_base) {
+		ret = -EIO;
+		goto out_map;
+	}
 	priv->xfer_timeout = 200;
 	priv->ack_timeout = 200;
 
@@ -406,8 +354,7 @@ i2c_au1550_probe(struct platform_device *pdev)
 	priv->adap.dev.parent = &pdev->dev;
 	strlcpy(priv->adap.name, "Au1xxx PSC I2C", sizeof(priv->adap.name));
 
-	/* Now, set up the PSC for SMBus PIO mode.
-	*/
+	/* Now, set up the PSC for SMBus PIO mode. */
 	i2c_au1550_setup(priv);
 
 	ret = i2c_add_numbered_adapter(&priv->adap);
@@ -417,7 +364,8 @@ i2c_au1550_probe(struct platform_device *pdev)
 	}
 
 	i2c_au1550_disable(priv);
-
+	iounmap(priv->psc_base);
+out_map:
 	release_resource(priv->ioarea);
 	kfree(priv->ioarea);
 out_mem:
@@ -426,14 +374,14 @@ out:
 	return ret;
 }
 
-static int __devexit
-i2c_au1550_remove(struct platform_device *pdev)
+static int __devexit i2c_au1550_remove(struct platform_device *pdev)
 {
 	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
 
 	platform_set_drvdata(pdev, NULL);
 	i2c_del_adapter(&priv->adap);
 	i2c_au1550_disable(priv);
+	iounmap(priv->psc_base);
 	release_resource(priv->ioarea);
 	kfree(priv->ioarea);
 	kfree(priv);
@@ -476,14 +424,12 @@ static struct platform_driver au1xpsc_smbus_driver = {
 	.resume		= i2c_au1550_resume,
 };
 
-static int __init
-i2c_au1550_init(void)
+static int __init i2c_au1550_init(void)
 {
 	return platform_driver_register(&au1xpsc_smbus_driver);
 }
 
-static void __exit
-i2c_au1550_exit(void)
+static void __exit i2c_au1550_exit(void)
 {
 	platform_driver_unregister(&au1xpsc_smbus_driver);
 }
-- 
1.7.6
