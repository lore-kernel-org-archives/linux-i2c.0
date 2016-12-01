From: Romain Perier <romain.perier@free-electrons.com>
Subject: [PATCH v7 1/4] i2c: pxa: Add definition of fast and high speed modes via the regs layout
Date: Thu,  1 Dec 2016 12:04:37 +0100
Message-ID: <20161201110440.27530-2-romain.perier@free-electrons.com>
References: <20161201110440.27530-1-romain.perier@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55410 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755255AbcLALEo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 1 Dec 2016 06:04:44 -0500
In-Reply-To: <20161201110440.27530-1-romain.perier@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw>

So far, the bit masks for the fast and high speed mode were statically
defined. Some IP blocks might use different bits for these modes.

This commit introduces new fields in order to enable the definition of
different bit masks for these features. If these fields are undefined,
ICR_FM and ICR_HS are selected to preserve backward compatibility with
other IPs.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
---

Changes in v7:
 - Fixed line over 80 characters for fm_mask and hs_mask in the probe
   function.

 drivers/i2c/busses/i2c-pxa.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index e28b825..b4ac235 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -48,6 +48,8 @@ struct pxa_reg_layout {
 	u32 isar;
 	u32 ilcr;
 	u32 iwcr;
+	u32 fm;
+	u32 hs;
 };
 
 enum pxa_i2c_types {
@@ -193,6 +195,8 @@ struct pxa_i2c {
 	unsigned char		master_code;
 	unsigned long		rate;
 	bool			highmode_enter;
+	u32			fm_mask;
+	u32			hs_mask;
 };
 
 #define _IBMR(i2c)	((i2c)->reg_ibmr)
@@ -503,8 +507,8 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 		writel(i2c->slave_addr, _ISAR(i2c));
 
 	/* set control register values */
-	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
-	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
+	writel(I2C_ICR_INIT | (i2c->fast_mode ? i2c->fm_mask : 0), _ICR(i2c));
+	writel(readl(_ICR(i2c)) | (i2c->high_mode ? i2c->hs_mask : 0), _ICR(i2c));
 
 #ifdef CONFIG_I2C_PXA_SLAVE
 	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
@@ -1234,6 +1238,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	i2c->reg_idbr = i2c->reg_base + pxa_reg_layout[i2c_type].idbr;
 	i2c->reg_icr = i2c->reg_base + pxa_reg_layout[i2c_type].icr;
 	i2c->reg_isr = i2c->reg_base + pxa_reg_layout[i2c_type].isr;
+	i2c->fm_mask = pxa_reg_layout[i2c_type].fm ? : ICR_FM;
+	i2c->hs_mask = pxa_reg_layout[i2c_type].hs ? : ICR_HS;
+
 	if (i2c_type != REGS_CE4100)
 		i2c->reg_isar = i2c->reg_base + pxa_reg_layout[i2c_type].isar;
 
-- 
2.9.3
