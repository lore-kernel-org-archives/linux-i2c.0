Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619BA21D3F3
	for <linux-i2c@vger.kernel.org>; Thu,  2 Apr 2026 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139578; cv=none; b=Gw79H+C6Ko8naUbwvfNB+rRAp78FfwP/sNMorV1zIkNsBHgnC23Wca95mXiB8owUyoGB+Amg/x2BHGf1XGcG775Oci8WyoF/KnRx8zFppiCs9cD0HMsTVok3DmhHMgzdhwKnT9Fs4jcGATdZ+90z5MfREw2EiifmVAfnTz28oVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139578; c=relaxed/simple;
	bh=y0KdBtWEhpWDDwoMoFbqEA38DgTVTwsUgIllnO/my3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipQbYKQXTSFsqsrtPpb+LXQaEM6E6AZHN8dXiCtePF+SVE212v0MtrcH9/A6HcF6G007IpF63SKnb9RyJ/TY+twNVCon7Loh+YV1TwoR2bsHViqq65dMDIMCoQ315CtglrTESxkLIOXqc7RFa0O5phWBwL8VWavv3lLN0ebHIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCswU037; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCswU037"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35c124d2613so500397a91.2
        for <linux-i2c@vger.kernel.org>; Thu, 02 Apr 2026 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775139577; x=1775744377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEwVt/TOby91/obLvpEjMbAjKWw/iIZ/j0HIP3lRSWw=;
        b=HCswU037XxBg9k7D4K86dM+p/PxPsS37/Vrjgc0/QsRC/kaBBaMPRDEsLlqy9AgdWW
         s9sK7snZdJTmEOYmm3EMo806gzmkpVO3uC9/l4KuMK5+uKiACq0QIcAnDInpT6NZQEAF
         +TV/RHG1XSaCuyHwSjDzVApXSpcLNaQIqoddmVKXsEWmsB6oRZrg0Sp72zC+8K6pj5Ma
         bUU3LiKqVdwGYjRbPsmIFC2zQoYl3JLzdFEbOdfnPk2QqiZPuswPD5sARdOo4AKe1SOR
         bz+Rkr7V7iheZa4CG8g3P0HRU6wNxOpVyn8skuVIxxj6fPwcVC8eZ5yFGPi6SM2wyhUP
         KGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139577; x=1775744377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEwVt/TOby91/obLvpEjMbAjKWw/iIZ/j0HIP3lRSWw=;
        b=GG8d2SFk8sTNO9d7kv4NRTxP37AeOSc+m/HWfWgUfHzc4Yyz59XjWE6uFuIaM5S1Q2
         DQ19E9LcoQSaoosQeO0JIXx4sdLy5mJX6c7naxxbpfBuJFMdIUsQbDa91x2yrU4s4Nvj
         XtNrkrzJkNdxAnKqYBNcuMAyUWsmarQ2KkYp/0h2mBg4z0G95c8NfLy4uzvejrE9+QM2
         jhYt6WdLcKlKLMb//ezeKOIQmkAs8s+D0Hzr7v2wjoCWyh8pDdNeM7SlQVxK6EuMckmE
         YbDQyza9TkluCuuXHohK/gLhd0ATNb+AEVEM6G9UBdtDwvJ1HYxy5vV204jObg0LGco4
         yjLA==
X-Forwarded-Encrypted: i=1; AJvYcCUM3fh9KTe5UVA4sL2d79ZfKNZJ2JNu7DuaZ+a7NqhrcwtxZqkWqzifPepd5lRwSgRTcTzRTaiDXDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Uwgx8l3rnP4gXTwh+UItLfHMJf+z2U3PZRsNUpG04e3o4tpm
	esSHVDYcR1pBpU37X+rrSzN3IqZs1pcVc3W8r5NVWey75Z4xwbyKGC7Z
X-Gm-Gg: AeBDiesPMKsg43mE9BRemzOT85fEsWWZezpo5dxkTJ3gVfEwcGsDuiyyhEiDqtYoU9+
	/iljEqdZH1FCcbrDThaCB5uskA/jNsg6Bpt/axNjM8usCcuseobp7Cc/YJISNaGs+coNF00Wn+8
	tHFqG0jR5KUQQ9VDP0eTL0yo2Xq3cc1C/Sa3ilaL1vJiO1xFGjX+qQBQ4Ff5PxNB66jC3kB9SLk
	T2sntLtWbLRm9G1WDWw++dI54ZolLQcAFZXM2Ln0n3x2qw0RnLT5DvfsNt8CJMj61t4tm9RkwgK
	3ixEv55l4wBbRTUfbCLGJApeM4B9iOr5F5jb8JZoJDEEhplNdmPvqwau5zx/8lIcetaT7/VrzvO
	FfDfAbpg7Pz5QugB94ATPnt7vbns2uhlgojSAIb9+XRC6PVD7Whc0asDxXYF9anb5UaOTvc9D0D
	qbke0WyX8Y8p+axr0bXaSd
X-Received: by 2002:a17:90b:3d92:b0:35b:90e7:c453 with SMTP id 98e67ed59e1d1-35dc6e43b12mr7324340a91.6.1775139576619;
        Thu, 02 Apr 2026 07:19:36 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm10959123a91.10.2026.04.02.07.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:19:35 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	David Wu <david.wu@rock-chips.com>
Subject: [PATCH v3 1/2] i2c: rk3x: add support for SCL OE debounce and slave hold recovery
Date: Thu,  2 Apr 2026 19:49:22 +0530
Message-ID: <20260402141927.7216-1-linux.amoon@gmail.com>
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
- Initialize the SLV_HDSCL bit in i2c_start for I2C interrupt field.

The recovery logic is gated by 'has_scl_oe_debounce' to ensure that
reserved bits on older SoC variants do not trigger false-positive
recoveries.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Changes:
v3: intialize the SLV_HDSCL bit in in i2c_start for interupt enable
 v2: https://lore.kernel.org/all/20260321105146.7419-1-linux.amoon@gmail.com/
v2: Aded the to detect REG_INT_SLV_HDSCL interrupt timeout
    it was part of origmal commit below.
    [1] https://github.com/radxa/kernel/commit/006c0b1e7710d471119a69d6bd56917a15a85a0b
Fix the order of SoB,
Fix the doc warning reporteed by kernel test robot
 v1: https://lore.kernel.org/all/20260103052506.6743-1-linux.amoon@gmail.com/
---
 drivers/i2c/busses/i2c-rk3x.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index fcede9f6ed54..06a77780cf82 100644
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
+#define REG_INT_SLV_HDSCL BIT(7) /* Slave hold scl interrupt enable */
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
@@ -248,8 +252,12 @@ static inline void rk3x_i2c_clean_ipd(struct rk3x_i2c *i2c)
 static void rk3x_i2c_start(struct rk3x_i2c *i2c)
 {
 	u32 val = i2c_readl(i2c, REG_CON) & REG_CON_TUNING_MASK;
+	u32 ien = REG_INT_START;
 
-	i2c_writel(i2c, REG_INT_START, REG_IEN);
+	if (i2c->soc_data->has_scl_oe_debounce)
+		ien |= REG_INT_SLV_HDSCL;
+
+	i2c_writel(i2c, ien, REG_IEN);
 
 	/* enable adapter with correct mode, send START condition */
 	val |= REG_CON_EN | REG_CON_MOD(i2c->mode) | REG_CON_START;
@@ -876,6 +884,7 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 {
 	struct i2c_timings *t = &i2c->t;
 	struct rk3x_i2c_calced_timings calc;
+	unsigned long period, time_hold = (WAIT_TIMEOUT / 2) * 1000000;
 	u64 t_low_ns, t_high_ns;
 	unsigned long flags;
 	u32 val;
@@ -893,6 +902,13 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
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
@@ -1063,6 +1079,7 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 	unsigned long flags;
 	long time_left;
 	u32 val;
+	u32 ipd = 0; /* To store interrupt pending status for timeout analysis */
 	int ret = 0;
 	int i;
 
@@ -1107,6 +1124,9 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 		spin_lock_irqsave(&i2c->lock, flags);
 
 		if (time_left == 0) {
+			/* Read IPD before clearing to check for Slave Hold SCL */
+			ipd = i2c_readl(i2c, REG_IPD);
+
 			/* Force a STOP condition without interrupt */
 			i2c_writel(i2c, 0, REG_IEN);
 			val = i2c_readl(i2c, REG_CON) & REG_CON_TUNING_MASK;
@@ -1125,6 +1145,17 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
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
 
@@ -1198,6 +1229,7 @@ static const struct rk3x_i2c_soc_data rk3288_soc_data = {
 static const struct rk3x_i2c_soc_data rk3399_soc_data = {
 	.grf_offset = -1,
 	.calc_timings = rk3x_i2c_v1_calc_timings,
+	.has_scl_oe_debounce = true,
 };
 
 static const struct of_device_id rk3x_i2c_match[] = {

base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
-- 
2.50.1

