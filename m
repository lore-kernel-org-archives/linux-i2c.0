Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7728C3822BE;
	Wed, 29 Apr 2026 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449001; cv=none; b=cZmicz/dKY23peWzWsFFdhKB2Y4NzrTfUNw53i0+YHwJfkoDZdvTFBMKegW+cvu5TYeip1m2W0VfCSKemtWEjWKrMy/ygrHHYZDhmUEvJMWH02mSqd3/SOnhXUEVrzWsoEb5jqjtU3BPAH82YxSqrTjTtTaasbDe41MkXnyqMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449001; c=relaxed/simple;
	bh=2vZgSG3fz1sfvmpztlC/YNa0AwJeX+tyJ+NMJkqoBMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvBwp05O71TCBlG6kDYLgoc0J3mfhzamWbauUSDCO2M9Y+Iq6BjLoEd+Nn4UmX+t77bXTH1e7JAhMuyQodBiFfOwOspYp+vAbZvcM9UIyvYHVPu/3ZGMzRXft/gOTAUZMSfMAzCPNYGz1hAm1lkHORZNuOd+eqiE5VkgJgTcOfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=mbJtaNcJ; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="mbJtaNcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1777448950;
	bh=tYItqWFcvtrzlS7Ntudj1s5aDXm6FyaHVjowJe67UF0=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=mbJtaNcJPWGwnswP4Y3njcxzs+txX5k/ml/ms4S1ZXDXzJw9hDA8Ilh7ZamQQDfRk
	 EbQ85r9MneRpUPeR6Lem5Fy1XMa34taG5BryuKROLVuGWcK3zi67699johRPFS9K47
	 sJM3gqDMHxaQNULP2GgOkS25+Pbxlw5e2Ago358U=
X-QQ-mid: zesmtpgz1t1777448943t66e499f6
X-QQ-Originating-IP: 2IPYQQm+7cZBVpNEEPOOpSlM/HqOGLcWHnHTTIgCFYM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Apr 2026 15:49:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5682307591694794909
EX-QQ-RecipientCnt: 8
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Wed, 29 Apr 2026 15:48:56 +0800
Subject: [PATCH v6 1/2] i2c: spacemit: configure ILCR/IWCR for accurate SCL
 frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-k1-i2c-ilcr-v6-1-1c7a5a5a8b24@linux.spacemit.com>
References: <20260429-k1-i2c-ilcr-v6-0-1c7a5a5a8b24@linux.spacemit.com>
In-Reply-To: <20260429-k1-i2c-ilcr-v6-0-1c7a5a5a8b24@linux.spacemit.com>
To: Andi Shyti <andi.shyti@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777448937; l=12531;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=2vZgSG3fz1sfvmpztlC/YNa0AwJeX+tyJ+NMJkqoBMA=;
 b=RQZ9V921XGPsvy8WaG35HU19BEzB8OU/CZpdJiP+ANMOxLxY4bk243pTT4ipCnW7WVFbjyEa0
 ytu9sSKtGvoBBQQ1kkka7FpqZ1d3KvJBxcFOxne6sr8CeSfpMR7FC4L
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N8jK27eo0USIaws1mTQTfzXt8E13YvK62LCrD6jc+PWjzWsqK/dnsgfB
	sdWYQon/GpRj7G2avUxvqRTlnyBDi8uBHNQFp/c16IksRn4LVX1IU9PHOBJdk+u689kkTRq
	2nhNbEA4iVw60cAj4Ii89tV/0uU7S/MRy+Xxe4FbVL+ro/MVbo+iPhRf1yeaue4YMNXVWQx
	nnQpC0Qb4yIMEL3E/5bXMNqQ0CEBmXqcN4tR0nXAWd4lBlhWRO/D4F6+PwSAXhcvN4urAjd
	eEikjU/YMRl0joAYmxUEUcu2SSoGQE5Y3mbSgA2YHigHB5/XlgEt4jE22m1TxGcPcmDYCTi
	b5DeSEPj7AsEQVU6lVA3pB1uIqnE5u18LxvQh8KoW7lWTqH1ST3HvEneQQxNCok3paC0wNv
	YPxQreRtn/NayRNol55qElJDEz9NA14MxgEOitN1DERLYg9GjpQTCafeqLcqMkFx+Jj8jeh
	edJ34SVI0+MnkpTF9f/xOg2y5A3lOhU6o2TQtkJqh45yZJZVKL/v2vRdKGH/vTNKQQzQGFe
	cPC/ThPqBdr7t/QQRwZDuSo5DZmnUTwTdR92eRSXekgAvrk7fnaOOj1Y1NUviByv9lH4HlT
	h6emWIEEPPJAXdqiLvTDBlx/CQHmq1x+abXNVrHyfinkzBHpevBaQtM1Af81C0nqfj0aeXh
	ETKXayHpnCFtC7g9p9yItsisdgGJaE4xLgWu1jpQ2I8cxxHZ2rnKLGZuz1bB4PosNfrP471
	GM5XfG9nWOeETaeYjAyWzox1hy26buicI+ogW17Ij8CRP6Y8DcxRwybEMtQIXpll9bGXaa8
	WeA7iBU9/6qfkEfLfWaXaKqzx9Zn7k3f32FCthzM3byusxl6jPOghyEnl8LSDVIYseNQNLY
	DoY5rzg2Lc5wnsyCDkNqSBJIXachANcqSnp4WWG8jAAZoT2rDwcWhj4Fbe5vO3McW0iBDjn
	JJLrOyxS2DrGYnv5MkdX3JWV9Q49ZTrcKTyXowHTa9snaI3s47JC4XIchYjmTfCg9Fn3ssR
	TJdQdkBa96HgHV4IOPm1oMJyJk3+AMUv1x7iJd0bzHLNanOA1rDmFC87wd+6+LL2QwfYAR5
	or1WnQt7/2x9b66WXB8j3Wqk54BaI7JzolHYFJP8Xc2
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

The SpacemiT I2C controller's SCL (Serial Clock Line) frequency for
master mode operations is determined by the ILCR (I2C Load Count Register).
Previously, the driver relied on the hardware's reset default
values for this register.

The hardware's default ILCR values (SLV=0x156, FLV=0x5d) yield SCL
frequencies lower than intended. For example, with the default
31.5 MHz input clock, these default settings result in an SCL
frequency of approximately 93 kHz (standard mode) when targeting 100 kHz,
and approximately 338 kHz (fast mode) when targeting 400 kHz.
These frequencies are below the 100 kHz/400 kHz nominal speeds.

This patch integrates the SCL frequency management into
the Common Clock Framework (CCF). Specifically, the ILCR register,
which acts as a frequency divider for the SCL clock, is now registered
as a managed clock (scl_clk) within the CCF.

The actual hardware timing formulas are:
- standard mode: SCL = FCLK / (2 * SLV + 8)
- fast mode:     SCL = FCLK / (2 * FLV + 10)

These formulas are only valid when the IWCR (Wait Count Register) is
programmed to 0x142A, a value specified by the I2C IP designer. The
driver now initializes IWCR to this value during controller init.

Reviewed-by: Yixun Lan <dlan@gentoo.org>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
Changelog in v6:
- fix SCL frequency calculation to match hardware timing formulas
  (SCL = FCLK / (2*SLV+8) for standard, FCLK / (2*FLV+10) for fast)
- initialize IWCR to 0x142A during init(required by I2C IP for
  correct SCL timing)
- use DIV_ROUND_CLOSEST() instead of DIV_ROUND_UP() for more accurate frequency
- use field_prep() instead of manual bit shift for ILCR register programming
- replace .round_rate with .determine_rate (round_rate was removed from clk_ops)
- remove _MAX_VALUE macros (no longer needed after removing max_lv validation)
- remove redundant max_lv validation in set_rate (determine_rate guarantees valid values)
- simplify scl_clk_disable_unprepare callback to take clk pointer directly
- remove unused parent parameter from spacemit_i2c_register_scl_clk()
- remove stale description about whitespace cleanup from commit message
- Link to v5: https://lore.kernel.org/r/20251226-k1-i2c-ilcr-v5-0-b5807b7dd0e6@linux.spacemit.com

Changelog in v5:
- use __ffs() instead of *_SHIFT
- remove useless *_SHIFT
- check return value when scl clk name array is truncated
- rebase to v6.19-rc1
- Link to v3: https://lore.kernel.org/all/20251017-k1-i2c-ilcr-v4-1-eed4903ecdb9@linux.spacemit.com/

Changelog in v4:
- initialize clk_init_data with {} so that init.flags is implicitly set to 0
- minor cleanup and style fixes for better readability
- remove unused spacemit_i2c_scl_clk_exclusive_put() cleanup callback
- replace clk_set_rate_exclusive()/clk_rate_exclusive_put() pair with clk_set_rate()
- simplify LCR LV field macros by using FIELD_GET/FIELD_MAX helpers
- Link to v3: https://lore.kernel.org/all/20250814-k1-i2c-ilcr-v3-1-317723e74bcd@linux.spacemit.com/

Changelog in v3:
- use MASK macro in `recalc_rate` function
- rename clock name
- Link to v2: https://lore.kernel.org/r/20250718-k1-i2c-ilcr-v2-1-b4c68f13dcb1@linux.spacemit.com

Changelog in v2:
- Align line breaks.
- Check `lv` in `clk_set_rate` function.
- Force fast mode when SCL frequency is illegal or unavailable.
- Change "linux/bits.h" to <linux/bits.h>
- Kconfig: Add dependency on CCF.
- Link to v1: https://lore.kernel.org/all/20250710-k1-i2c-ilcr-v1-1-188d1f460c7d@linux.spacemit.com/
---
 drivers/i2c/busses/Kconfig  |   2 +-
 drivers/i2c/busses/i2c-k1.c | 160 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 153 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 8c935f867a37..89898fff1967 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -793,7 +793,7 @@ config I2C_JZ4780
 config I2C_K1
 	tristate "SpacemiT K1 I2C adapter"
 	depends on ARCH_SPACEMIT || COMPILE_TEST
-	depends on OF
+	depends on OF && COMMON_CLK
 	help
 	  This option enables support for the I2C interface on the SpacemiT K1
 	  platform.
diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index 9152cf436bea..fad6a20bb43d 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -4,7 +4,9 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/i2c.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
@@ -17,6 +19,8 @@
 #define SPACEMIT_ISR		 0x4		/* Status register */
 #define SPACEMIT_IDBR		 0xc		/* Data buffer register */
 #define SPACEMIT_IRCR		 0x18		/* Reset cycle counter */
+#define SPACEMIT_ILCR		 0x10		/* Load Count Register */
+#define SPACEMIT_IWCR		 0x14		/* Wait Count Register */
 #define SPACEMIT_IBMR		 0x1c		/* Bus monitor register */
 
 /* SPACEMIT_ICR register fields */
@@ -88,6 +92,12 @@
 #define SPACEMIT_BMR_SDA         BIT(0)		/* SDA line level */
 #define SPACEMIT_BMR_SCL         BIT(1)		/* SCL line level */
 
+#define SPACEMIT_LCR_LV_STANDARD_MASK		GENMASK(8, 0)
+#define SPACEMIT_LCR_LV_FAST_MASK		GENMASK(17, 9)
+
+/* Required by I2C IP for correct SCL timing */
+#define SPACEMIT_IWCR_INIT_VALUE		0x142A
+
 /* i2c bus recover timeout: us */
 #define SPACEMIT_I2C_BUS_BUSY_TIMEOUT		100000
 
@@ -109,11 +119,20 @@ enum spacemit_i2c_state {
 	SPACEMIT_STATE_WRITE,
 };
 
+enum spacemit_i2c_mode {
+	SPACEMIT_MODE_STANDARD,
+	SPACEMIT_MODE_FAST
+};
+
 /* i2c-spacemit driver's main struct */
 struct spacemit_i2c_dev {
 	struct device *dev;
 	struct i2c_adapter adapt;
 
+	struct clk_hw scl_clk_hw;
+	struct clk *scl_clk;
+	enum spacemit_i2c_mode mode;
+
 	/* hardware resources */
 	void __iomem *base;
 	int irq;
@@ -135,6 +154,82 @@ struct spacemit_i2c_dev {
 	u32 status;
 };
 
+static void spacemit_i2c_scl_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static int spacemit_i2c_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	struct spacemit_i2c_dev *i2c = container_of(hw, struct spacemit_i2c_dev, scl_clk_hw);
+	u32 lv, lcr, mask, denom;
+
+	/*
+	 * Hardware timing formulas:
+	 * - standard mode: SCL = FCLK / (2 * SLV + 8)
+	 * - fast mode:     SCL = FCLK / (2 * FLV + 10)
+	 */
+	denom = DIV_ROUND_CLOSEST(parent_rate, rate);
+
+	if (i2c->mode == SPACEMIT_MODE_STANDARD) {
+		mask = SPACEMIT_LCR_LV_STANDARD_MASK;
+		lv = (denom <= 8) ? 0 : DIV_ROUND_CLOSEST(denom - 8, 2);
+	} else {
+		mask = SPACEMIT_LCR_LV_FAST_MASK;
+		lv = (denom <= 10) ? 0 : DIV_ROUND_CLOSEST(denom - 10, 2);
+	}
+
+	lcr = readl(i2c->base + SPACEMIT_ILCR);
+	lcr &= ~mask;
+	lcr |= field_prep(mask, lv);
+	writel(lcr, i2c->base + SPACEMIT_ILCR);
+
+	return 0;
+}
+
+static int spacemit_i2c_clk_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
+{
+	struct spacemit_i2c_dev *i2c = container_of(hw, struct spacemit_i2c_dev, scl_clk_hw);
+	u32 lv, denom;
+
+	denom = DIV_ROUND_CLOSEST(req->best_parent_rate, req->rate);
+
+	if (i2c->mode == SPACEMIT_MODE_STANDARD) {
+		lv = (denom <= 8) ? 0 : DIV_ROUND_CLOSEST(denom - 8, 2);
+		req->rate = DIV_ROUND_CLOSEST(req->best_parent_rate, lv * 2 + 8);
+	} else {
+		lv = (denom <= 10) ? 0 : DIV_ROUND_CLOSEST(denom - 10, 2);
+		req->rate = DIV_ROUND_CLOSEST(req->best_parent_rate, lv * 2 + 10);
+	}
+
+	return 0;
+}
+
+static unsigned long spacemit_i2c_clk_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct spacemit_i2c_dev *i2c = container_of(hw, struct spacemit_i2c_dev, scl_clk_hw);
+	u32 lcr, lv = 0;
+
+	lcr = readl(i2c->base + SPACEMIT_ILCR);
+
+	if (i2c->mode == SPACEMIT_MODE_STANDARD) {
+		lv = FIELD_GET(SPACEMIT_LCR_LV_STANDARD_MASK, lcr);
+		return DIV_ROUND_CLOSEST(parent_rate, lv * 2 + 8);
+	}
+
+	lv = FIELD_GET(SPACEMIT_LCR_LV_FAST_MASK, lcr);
+	return DIV_ROUND_CLOSEST(parent_rate, lv * 2 + 10);
+}
+
+static const struct clk_ops spacemit_i2c_clk_ops = {
+	.set_rate = spacemit_i2c_clk_set_rate,
+	.determine_rate = spacemit_i2c_clk_determine_rate,
+	.recalc_rate = spacemit_i2c_clk_recalc_rate,
+};
+
 static void spacemit_i2c_enable(struct spacemit_i2c_dev *i2c)
 {
 	u32 val;
@@ -153,6 +248,28 @@ static void spacemit_i2c_disable(struct spacemit_i2c_dev *i2c)
 	writel(val, i2c->base + SPACEMIT_ICR);
 }
 
+static struct clk *spacemit_i2c_register_scl_clk(struct spacemit_i2c_dev *i2c)
+{
+	struct clk_init_data init = {};
+	char name[64];
+	int ret;
+
+	ret = snprintf(name, sizeof(name), "%s_scl_clk", dev_name(i2c->dev));
+	if (ret >= ARRAY_SIZE(name))
+		dev_warn(i2c->dev, "scl clock name truncated");
+
+	init.name = name;
+	init.ops = &spacemit_i2c_clk_ops;
+	init.parent_data = (struct clk_parent_data[]) {
+		{ .fw_name = "func" },
+	};
+	init.num_parents = 1;
+
+	i2c->scl_clk_hw.init = &init;
+
+	return devm_clk_register(i2c->dev, &i2c->scl_clk_hw);
+}
+
 static void spacemit_i2c_reset(struct spacemit_i2c_dev *i2c)
 {
 	writel(SPACEMIT_CR_UR, i2c->base + SPACEMIT_ICR);
@@ -286,7 +403,7 @@ static void spacemit_i2c_init(struct spacemit_i2c_dev *i2c)
 		val |= SPACEMIT_CR_MSDIE;
 	}
 
-	if (i2c->clock_freq == SPACEMIT_I2C_MAX_FAST_MODE_FREQ)
+	if (i2c->mode == SPACEMIT_MODE_FAST)
 		val |= SPACEMIT_CR_MODE_FAST;
 
 	/* disable response to general call */
@@ -309,6 +426,14 @@ static void spacemit_i2c_init(struct spacemit_i2c_dev *i2c)
 	writel(val, i2c->base + SPACEMIT_IRCR);
 
 	spacemit_i2c_clear_int_status(i2c, SPACEMIT_I2C_INT_STATUS_MASK);
+
+	/*
+	 * Initialize IWCR to the value specified by the I2C IP designer.
+	 * The SCL frequency formulas (SCL = FCLK / (2*SLV+8) for standard
+	 * mode, SCL = FCLK / (2*FLV+10) for fast mode) are only valid when
+	 * IWCR contains this specific value.
+	 */
+	writel(SPACEMIT_IWCR_INIT_VALUE, i2c->base + SPACEMIT_IWCR);
 }
 
 static void spacemit_i2c_start(struct spacemit_i2c_dev *i2c)
@@ -703,14 +828,15 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
 		dev_warn(dev, "failed to read clock-frequency property: %d\n", ret);
 
 	/* For now, this driver doesn't support high-speed. */
-	if (!i2c->clock_freq || i2c->clock_freq > SPACEMIT_I2C_MAX_FAST_MODE_FREQ) {
-		dev_warn(dev, "unsupported clock frequency %u; using %u\n",
-			 i2c->clock_freq, SPACEMIT_I2C_MAX_FAST_MODE_FREQ);
+	if (i2c->clock_freq > SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ &&
+	    i2c->clock_freq <= SPACEMIT_I2C_MAX_FAST_MODE_FREQ) {
+		i2c->mode = SPACEMIT_MODE_FAST;
+	} else if (i2c->clock_freq && i2c->clock_freq <= SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ) {
+		i2c->mode = SPACEMIT_MODE_STANDARD;
+	} else {
+		dev_warn(i2c->dev, "invalid clock-frequency, fallback to fast mode");
+		i2c->mode = SPACEMIT_MODE_FAST;
 		i2c->clock_freq = SPACEMIT_I2C_MAX_FAST_MODE_FREQ;
-	} else if (i2c->clock_freq < SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ) {
-		dev_warn(dev, "unsupported clock frequency %u; using %u\n",
-			 i2c->clock_freq,  SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ);
-		i2c->clock_freq = SPACEMIT_I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
 	i2c->dev = &pdev->dev;
@@ -732,6 +858,11 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable func clock");
 
+	i2c->scl_clk = spacemit_i2c_register_scl_clk(i2c);
+	if (IS_ERR(i2c->scl_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->scl_clk),
+				     "failed to register scl clock\n");
+
 	clk = devm_clk_get_enabled(dev, "bus");
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable bus clock");
@@ -741,6 +872,19 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(rst),
 				     "failed to acquire deasserted reset\n");
 
+	ret = clk_set_rate(i2c->scl_clk, i2c->clock_freq);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to set rate for SCL clock");
+
+	ret = clk_prepare_enable(i2c->scl_clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to prepare and enable clock");
+
+	ret = devm_add_action_or_reset(dev, spacemit_i2c_scl_clk_disable_unprepare,
+				       i2c->scl_clk);
+	if (ret)
+		return ret;
+
 	spacemit_i2c_reset(i2c);
 
 	i2c_set_adapdata(&i2c->adapt, i2c);

-- 
2.54.0

