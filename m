Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B73E557D
	for <linux-i2c@vger.kernel.org>; Thu,  2 Apr 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139583; cv=none; b=XIbZUQaf0j7gnWlJiQj2PonGWOqw/zOprZ9PranzIEXPu9mrtdfQgglscXSbT4BgJCWVwxlo57CRdKoOo1qypTvqrUmLKM3DKgNGCHpAdBrURfX1z8fa1+0VAsTLhykcTdtIP/3rD/w67udjL2QEph4FplYSFnLlhTHfnekNmNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139583; c=relaxed/simple;
	bh=hv8aKq6tnJn92KN1qhwijTP8v+9TkOIfCNGREGBiFLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arhf7fCxbkjPiR5fpw590yLOLMlOSaY6B1VGa2QJY+lNFydM4YMa/Y2taN+TG913VAdHn0fwcXrC1tNoRm4RdyaBm+piAiggkn+DOWU7QyZQ0x/uA3vugiNDnYxHv1I1pVK0kjw6ZJi9Vi4Rda73FYSqwtvSNqn0LyuXrJoyQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTrE7kjv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTrE7kjv"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35c1a131946so1269415a91.0
        for <linux-i2c@vger.kernel.org>; Thu, 02 Apr 2026 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775139581; x=1775744381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz1zlRSiKHlMJZnEUctS28g6FTYx8BEHRWatZco+c68=;
        b=YTrE7kjvGZ+8MOV2wscXSKn+dCH9L6Bs296XS0aG4U28ZeEQ8NRKifgfNfi3fKHytF
         60yd7k0eXwFHQBhdvv1thJJzWw4NWCrt6gmZzADS5+k0CKbwgrAxagKWkEY3p3XX+9EM
         V5AWUsNq3GS35WG2QnNKDOMOAPjBNK/yWJr/e6j7dJ61P3W0Oy3PIZRsiAmzEZIFtjOo
         kf1+9BXpGQ3rL518SIkrfAbRuM2El31e5Mm5xyKl+9zpELu1lVpDKUcmGpWsLKCr6oCy
         ilC5EhgU2x7BDyojFLvj8TwC9EcNKUp8s6zDkthHcUCUEmYhs5/DuJYua8k/Po7URzea
         ErWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139581; x=1775744381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zz1zlRSiKHlMJZnEUctS28g6FTYx8BEHRWatZco+c68=;
        b=LuolWukBLBLNe5C+kkqZ/YqiAaPepja97sVH297fwpg/LZkkeStwXfED3OAQEZZBlV
         LHmAcrnlOAp55s5TKY0Jy3Yft/TRGjSxVXkXqSPeO9O5CmROxkzazF2Yiwf+Mt4ZJgIV
         65R/GVVPDG+tHEw2s7MmCDLhMCWN7GgfJD1VUR/s+JPkT7t2j+0jCBfgvlGhFjD5w5M2
         CeAKu5ESeKHyB3xTDjseIpduSGhHE7mbNzzMmh0foDP4r64WSmmj9jymSv/0TvPUxKlO
         2OVhowpvB2X820eCPdVtWSAg36nzM/B6XkJRGm3D+9atdPdT8LetE2ZBEc1S3LIN4eGu
         LiNg==
X-Forwarded-Encrypted: i=1; AJvYcCXcHjxA0mlTHa7TAGqO7AelV0v/DkNHQSzTUwXWrZvtNz7kS+c/qpsuv/u3gEM6/pEjZLMmnkx4Bv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlhsVNX82H9jhog5VhFIb7bobXTw/4MgRjsqQpZQzPgah2uMR
	JlZfqsA89EwtDu7xc83AChV9SGWuoxA09Xzr3Sj0ZdrJhLceCTHJJgGV
X-Gm-Gg: AeBDiev/CNdhUcRtyUILRfW2Dm3hUTq0RJbZE0M2/89dUpiog6zfI/QPplm9BEQpk31
	rc5mWeOozAIJnJ+929HeTYemj8YLNuk/Xu7LpHei5mIB1cJcUrYEW2HcK2xaQPhn+ZEWLpaKNvH
	3Saioq+hcx9OZJVKuwnHvtlBisTzJpxLAcgf5Yfp9hpDlnS/TFruaJmZ5ZmLDWfXF5WN4BwwRD2
	VjAyQIhPiKL0osDaMKOmNiCI0uu1Q55clAzAUprcnnDOEmb5OCHgXtPZwHJTMQOdBLZikZ/ij9R
	SkcJBq99i93WfjEL0JgGUlybS8OJq/x7F3XaZ2e/ws6YS654E+40SH+cEPGyKGPXzR/oR4jhAX6
	mweSqlMl7/y5VrFkSasJrB6lxggNw13NpZenoDw7wMCfj//wu0IWDwkUkB874queKVagrGT1VNw
	bVEYjr6Ji9/P8nD+po0Uqb
X-Received: by 2002:a17:90b:314b:b0:35a:2ed:9b6f with SMTP id 98e67ed59e1d1-35dd65b05e0mr2598226a91.0.1775139581041;
        Thu, 02 Apr 2026 07:19:41 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm10959123a91.10.2026.04.02.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:19:40 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
	linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 2/2] i2c: rk3x: Fix deadlock by splitting rk3x_i2c_adapt_div into locked/unlocked variants
Date: Thu,  2 Apr 2026 19:49:23 +0530
Message-ID: <20260402141927.7216-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402141927.7216-1-linux.amoon@gmail.com>
References: <20260402141927.7216-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce __rk3x_i2c_adapt_div() function as a locked-only helper to
handle core timing calculations and register updates. This restructuring
allows these operations to be safely called from contexts where i2c->lock
is already held—such as during error recovery in rk3x_i2c_xfer_common
avoiding recursive locking or deadlocks.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: new patch to avoid deadlock.
---
 drivers/i2c/busses/i2c-rk3x.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 06a77780cf82..2556a3d8b2a1 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -880,22 +880,18 @@ static int rk3x_i2c_v1_calc_timings(unsigned long clk_rate,
 	return ret;
 }
 
-static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
+static void __rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 {
 	struct i2c_timings *t = &i2c->t;
 	struct rk3x_i2c_calced_timings calc;
 	unsigned long period, time_hold = (WAIT_TIMEOUT / 2) * 1000000;
 	u64 t_low_ns, t_high_ns;
-	unsigned long flags;
 	u32 val;
 	int ret;
 
 	ret = i2c->soc_data->calc_timings(clk_rate, t, &calc);
 	WARN_ONCE(ret != 0, "Could not reach SCL freq %u", t->bus_freq_hz);
 
-	clk_enable(i2c->pclk);
-
-	spin_lock_irqsave(&i2c->lock, flags);
 	val = i2c_readl(i2c, REG_CON);
 	val &= ~REG_CON_TUNING_MASK;
 	val |= calc.tuning;
@@ -909,10 +905,6 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 		i2c_writel(i2c, val, REG_SCL_OE_DB);
 	}
 
-	spin_unlock_irqrestore(&i2c->lock, flags);
-
-	clk_disable(i2c->pclk);
-
 	t_low_ns = div_u64(8ULL * HZ_PER_GHZ * (calc.div_low + 1), clk_rate);
 	t_high_ns = div_u64(8ULL * HZ_PER_GHZ * (calc.div_high + 1), clk_rate);
 	dev_dbg(i2c->dev,
@@ -922,6 +914,19 @@ static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
 		t_low_ns, t_high_ns);
 }
 
+static void rk3x_i2c_adapt_div(struct rk3x_i2c *i2c, unsigned long clk_rate)
+{
+	unsigned long flags;
+
+	clk_enable(i2c->pclk);
+
+	spin_lock_irqsave(&i2c->lock, flags);
+	__rk3x_i2c_adapt_div(i2c, clk_rate);
+	spin_unlock_irqrestore(&i2c->lock, flags);
+
+	clk_disable(i2c->pclk);
+}
+
 /**
  * rk3x_i2c_clk_notifier_cb - Clock rate change callback
  * @nb:		Pointer to notifier block
@@ -1152,7 +1157,7 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 	if (ret == -ETIMEDOUT && i2c->soc_data->has_scl_oe_debounce) {
 		if (ipd & REG_INT_SLV_HDSCL) {
 			dev_err(i2c->dev, "SCL hold by slave detected, resetting timings.\n");
-			rk3x_i2c_adapt_div(i2c, clk_get_rate(i2c->clk));
+			__rk3x_i2c_adapt_div(i2c, clk_get_rate(i2c->clk));
 		}
 	}
 
-- 
2.50.1

