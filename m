Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72B369208
	for <linux-i2c@vger.kernel.org>; Sat, 21 Mar 2026 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090317; cv=none; b=r/goWnAa6CV0luDxqRHoCAdvJnbGW9FEl/CwqU4U8XSPOelG8o4wrBpuy+x8Xj68LJaKVL+33RXXCi6yp44PxsTqZcoNCNqToZAe60mX1ZtLI6hu78t/4P8bQHY/emqqWtnADhj0t2T4fP2opPTmu7YQj7D2dSmPbnngJs3k5Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090317; c=relaxed/simple;
	bh=ErRXIKKrZtvUDHCCbsyQScC3qgRiWghxFNv9drlvIdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijSdhTRogTWltRKdHw34eYtWw0sI7gxR+r/R83fgR2gSNRkts3MUFP76j+riuGmUzGGADsjeWoR8d/fRwCl1p11wV3ueJtjlzYi2qXiXBa/AqvsWSekp0GsqbCVKbgau3fpbK8m2jJg8ne8E7qM0C+YA+i/N/AY3MJtgTBAFVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZnIDfO1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZnIDfO1"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c7412b07f22so1651714a12.0
        for <linux-i2c@vger.kernel.org>; Sat, 21 Mar 2026 03:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774090315; x=1774695115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RscDJZRuCLSR0EdEAqplFbrptB0CGIjOssvNhZ5r5oU=;
        b=hZnIDfO1LjgGshjOMo4GmtFsPXqkub/mZ4LdpbNy0rOulWMGP8Y3motgQIff8O7Seg
         2fLD1rDOV8Xdg2AnznMWdGBezbZw3nahZUEvOUxzf7mrkxmaNZNKMfgwE7W999NNMkKH
         9HkVWJe23pdUdns9S6q3OVzPTIVwtIf7KSTZr/RoU2E+Y2csqN0h7bmLg26Fv5tHFnMJ
         VLb5NjlzOAkzqz8YEyHf6XrLCTrNH+yJBAwnO4sLSe/crN8BNucGRhf0pIt3jRtCtzoo
         aWqeJXRd0t4mN2bpXB3pZmUjuk6OrD5SOvrBZfG+/bMNOMu3d+ZKS5PRpyy8PBezwANy
         2QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774090315; x=1774695115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RscDJZRuCLSR0EdEAqplFbrptB0CGIjOssvNhZ5r5oU=;
        b=opw0u984B7HkwDQfVnnxbMwHj6CvPMuHMEDcuKYrDiAmY2hdvBkEQi5agEx3cix28O
         u6GfB5cyc10b/nQ2x9ZIK1XHUVnhcYkt5K03d9gw6GYGBHsmXn/ppjnFMB2f7l/IPB7n
         cKh1AXn5FcJWwtJODS3FfkxQYcvUorPUq0W9+6QUlAWgQ8wyZJCVn+ZhHBsLTeukeq+e
         kb7uaJY4lU6d10GG4tLyCXWNx1ZhqVzRs2Z6Hmvyl6Oux1LCSW4Q9QfrJ7jAMCbvMXny
         iOsLqvlcyx6yza3xTrh4yHn3D23YJFuoZe/VO6IJCT/Fbk0QmCsmBqJUQ0YSDsMLEyGu
         vk3A==
X-Forwarded-Encrypted: i=1; AJvYcCVDOzg7zczih6GP5var0TzAKylGqtwC/to3BdKocHdfIqyCTepeagtcHWWRA7Tih7AChMqrISPwVCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDyHrBOSm0tNytGafv8laiYOf+SIGBxuE+IKmTruolyx6CYQ0
	eeZVavjAew6MUGvYPhWss1iGo34yn0N8TTW1GzhyBHjoCRQIHPRFVQdb
X-Gm-Gg: ATEYQzyUhwlObJS31yA56QM+hAb6qmCjV0maoUVqi9OZZBAtVPbUQvCyNxsAHsUQTGv
	wcM+I9yFmx9jahZD6zaQ5yOhZqhVcg9QWAALhfeYpmcnqE+SaS9bJ9ychlE1mhm5pL3t1Xp5fYO
	qnlar1iouEtamK6aJ7vZHzIA5Mf77a/8hpmyPM6LSiHaxr26jeMWCKT2FyH07CBbBXwVS8i3dhd
	7+/rcpilvujGaJ/XcKQUhcR5KyeYDtKu4XO8mHSHmqJjLxRrfCoyg0PwDytxDquE3wqoPnvrIwK
	19kuOLteBiXaqlQ+S4/JePYgw0z24qCRf40uBh2GDY01BpuO7uJ3RYtp4EvbqKmuXMXnQSoBJh6
	AuGpAG+aoYKio54YsHis7QpVLkqUfXdAd5VAV8zKW51I22gO44hPj9xarfYT3k/CSHj//NXRV5Z
	Vvyog28DtkMtNYK1WgG0Dn
X-Received: by 2002:a17:903:1a2e:b0:2ae:cd8c:bd04 with SMTP id d9443c01a7336-2b077165dabmr82219915ad.10.1774090315176;
        Sat, 21 Mar 2026 03:51:55 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08365a62bsm66752865ad.46.2026.03.21.03.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 03:51:54 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	David Wu <david.wu@rock-chips.com>
Subject: [PATCH v2] i2c: rk3x: add support for SCL OE debounce and slave hold recovery
Date: Sat, 21 Mar 2026 16:21:43 +0530
Message-ID: <20260321105146.7419-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wu <david.wu@rock-chips.com>

As per the RK3399 and RK35xx datasheet, Rockchip I2C controllers
feature a SCL_OE_DB register (0x24). This register is used to
configure the debounce time for the SCL output enable signal,
which helps prevent glitches and ensures timing compliance during bus
handover or slave clock stretching.

Introduce a 'has_scl_oe_debounce' flag to rk3x_i2c_soc_data to
distinguish between hardware versions. For supported SoCs, calculate
the debounce counter dynamically based on the current clock rate
and program it during divider adaptation.

Additionally:
- Implement detection for the REG_INT_SLV_HDSCL (Slave Hold SCL)
  interrupt bit during transfer timeouts.
- Capture the Interrupt Pending (IPD) register state before clearing
  interrupts during a timeout to check for the slave hold condition.
- Re-apply the clock dividers via rk3x_i2c_adapt_div() if a slave
  hold is detected on supported SoCs to attempt bus recovery.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: https://lore.kernel.org/all/20260103052506.6743-1-linux.amoon@gmail.com/
Changes:
v2: Aded the to detect REG_INT_SLV_HDSCL interrupt timeout
    it was part of origmal commit below.
    [1] https://github.com/radxa/kernel/commit/006c0b1e7710d471119a69d6bd56917a15a85a0b
Fix the order of SoB,
Fix the doc warning reporteed by kernel test robot
---
 drivers/i2c/busses/i2c-rk3x.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index fcede9f6ed54..57ef31cd96eb 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -36,6 +36,7 @@
 #define REG_IEN        0x18 /* interrupt enable */
 #define REG_IPD        0x1c /* interrupt pending */
 #define REG_FCNT       0x20 /* finished count */
+#define REG_SCL_OE_DB  0x24 /* Slave hold scl debounce */
 
 /* Data buffer offsets */
 #define TXBUFFER_BASE 0x100
@@ -74,6 +75,7 @@ enum {
 #define REG_INT_START     BIT(4) /* START condition generated */
 #define REG_INT_STOP      BIT(5) /* STOP condition generated */
 #define REG_INT_NAKRCV    BIT(6) /* NACK received */
+#define REG_INT_SLV_HDSCL BIT(7) /* slave hold scl */
 #define REG_INT_ALL       0x7f
 
 /* Constants */
@@ -161,10 +163,12 @@ enum rk3x_i2c_state {
 
 /**
  * struct rk3x_i2c_soc_data - SOC-specific data
+ * @has_scl_oe_debounce: Support for slave hold SCL debounce
  * @grf_offset: offset inside the grf regmap for setting the i2c type
  * @calc_timings: Callback function for i2c timing information calculated
  */
 struct rk3x_i2c_soc_data {
+	bool has_scl_oe_debounce;
 	int grf_offset;
 	int (*calc_timings)(unsigned long, struct i2c_timings *,
 			    struct rk3x_i2c_calced_timings *);
@@ -876,6 +880,7 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 {
 	struct i2c_timings *t = &i2c->t;
 	struct rk3x_i2c_calced_timings calc;
+	unsigned long period, time_hold = (WAIT_TIMEOUT / 2) * 1000000;
 	u64 t_low_ns, t_high_ns;
 	unsigned long flags;
 	u32 val;
@@ -893,6 +898,13 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 	i2c_writel(i2c, val, REG_CON);
 	i2c_writel(i2c, (calc.div_high << 16) | (calc.div_low & 0xffff),
 		   REG_CLKDIV);
+
+	if (i2c->soc_data->has_scl_oe_debounce) {
+		period = DIV_ROUND_UP(1000000000, clk_rate);
+		val = DIV_ROUND_UP(time_hold, period);
+		i2c_writel(i2c, val, REG_SCL_OE_DB);
+	}
+
 	spin_unlock_irqrestore(&i2c->lock, flags);
 
 	clk_disable(i2c->pclk);
@@ -1063,6 +1075,7 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 	unsigned long flags;
 	long time_left;
 	u32 val;
+	u32 ipd = 0; /* To store interrupt pending status for timeout analysis */
 	int ret = 0;
 	int i;
 
@@ -1107,6 +1120,9 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 		spin_lock_irqsave(&i2c->lock, flags);
 
 		if (time_left == 0) {
+			/* Read IPD before clearing to check for Slave Hold SCL */
+			ipd = i2c_readl(i2c, REG_IPD);
+
 			/* Force a STOP condition without interrupt */
 			i2c_writel(i2c, 0, REG_IEN);
 			val = i2c_readl(i2c, REG_CON) & REG_CON_TUNING_MASK;
@@ -1125,6 +1141,17 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 		}
 	}
 
+	/*
+	 * If a timeout occurred and the slave is holding SCL,
+	 * re-apply the timings/dividers to attempt recovery.
+	 */
+	if (ret == -ETIMEDOUT && i2c->soc_data->has_scl_oe_debounce) {
+		if (ipd & REG_INT_SLV_HDSCL) {
+			dev_err(i2c->dev, "SCL hold by slave detected, resetting timings.\n");
+			rk3x_i2c_adapt_div(i2c, clk_get_rate(i2c->clk));
+		}
+	}
+
 	clk_disable(i2c->pclk);
 	clk_disable(i2c->clk);
 
@@ -1198,6 +1225,7 @@ static const struct rk3x_i2c_soc_data rk3288_soc_data = {
 static const struct rk3x_i2c_soc_data rk3399_soc_data = {
 	.grf_offset = -1,
 	.calc_timings = rk3x_i2c_v1_calc_timings,
+	.has_scl_oe_debounce = true,
 };
 
 static const struct of_device_id rk3x_i2c_match[] = {

base-commit: a0c83177734ab98623795e1ba2cf4b72c23de5e7
-- 
2.50.1

